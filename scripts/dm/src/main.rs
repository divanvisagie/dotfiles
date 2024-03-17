use std::{env, process::Command};

fn get_is_dark_mode() -> bool {
    //if linux
    if cfg!(target_os = "linux") {
        let output = Command::new("gsettings")
            .args(&["get", "org.gnome.desktop.interface", "gtk-theme"])
            .output()
            .expect("Failed to execute command");
        let theme = String::from_utf8_lossy(&output.stdout);
        return theme.contains("dark");
    }
    if cfg!(target_os = "macos") {
        let output = Command::new("defaults")
            .args(&["read", "-g", "AppleInterfaceStyle"])
            .output()
            .expect("Failed to execute command");
        let theme = String::from_utf8_lossy(&output.stdout);
        return theme.contains("Dark");
    }
    panic!("Unsupported OS");
}

fn set_alacritty_theme(dark: bool) {
    let alacritty_config = std::fs::read_to_string(
        std::env::var("HOME").unwrap() + "/.config/alacritty/alacritty.toml",
    )
    .unwrap();

    // break away if the first line is not importing a path that contains the word "themes"
    if !alacritty_config.contains("themes") {
        println!("No themes found in alacritty config");
        return;
    }

    //remove first line from alacritty config
    let alacritty_config = alacritty_config
        .lines()
        .skip(1)
        .collect::<Vec<_>>()
        .join("\n");

    let new_first_line = if dark {
        vec![
            r###"import = ["~/.config/alacritty/themes/themes/everforest_dark.toml"]"###.to_string(),
            alacritty_config,
        ]
        .join("\n")
    } else {
        vec![
            r###"import = ["~/.config/alacritty/themes/themes/rose-pine-dawn.toml"]"###.to_string(),
            alacritty_config,
        ]
        .join("\n")
    };

    std::fs::write(std::env::var("HOME").unwrap() + "/.config/alacritty/alacritty.toml", new_first_line).unwrap();
}

fn set_gtk_theme(dark: bool) {
    if dark {
        Command::new("gsettings")
            .args(&["set", "org.gnome.desktop.interface", "gtk-theme", "Yaru-dark"])
            .output()
            .expect("Failed to execute command");
    } else {
        Command::new("gsettings")
            .args(&["set", "org.gnome.desktop.interface", "gtk-theme", "Yaru"])
            .output()
            .expect("Failed to execute command");
    }
}

fn set_gtk_wallpaper(dark: bool) {
    // wallpaper set ~/.dotfiles/wallpapers/dark.png
    //
    let image_name = if dark {
        "dark.png"
    } else {
        "light.jpg"
    };

    // set the gnome desktop wallpaper
    if let Ok(home_dir) = env::var("HOME") {
        let wallpaper_path = format!("{}/.dotfiles/wallpapers/{}", home_dir, image_name);

        match Command::new("gsettings")
            .args(&["set", "org.gnome.desktop.background", "picture-uri", &wallpaper_path])
            .output() {
                Ok(_) => {
                    println!("Set wallpaper to {}", image_name);
                },
                Err(e) => {
                    println!("Failed to set wallpaper: {}", e);
                }
            }
    }
}
fn set_apple_dark_mode(dark: bool) {

    if dark {
        // osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
        Command::new("osascript")
            .args(&["-e", "tell application \"System Events\" to tell appearance preferences to set dark mode to true"])
            .output()
            .expect("Failed to execute command");

    } else {
        // osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
        Command::new("osascript")
            .args(&["-e", "tell application \"System Events\" to tell appearance preferences to set dark mode to false"])
            .output()
            .expect("Failed to execute command");
    }
}

fn set_apple_wallpaper(dark: bool) {
    // wallpaper set ~/.dotfiles/wallpapers/dark.png
    //
    let image_name = if dark {
        "dark.png"
    } else {
        "light.jpg"
    };

   if let Ok(home_dir) = env::var("HOME") {
        let wallpaper_path = format!("{}/.dotfiles/wallpapers/{}", home_dir, image_name);

        match Command::new("wallpaper")
            .args(&["set", &wallpaper_path])
            .output() {
                Ok(_) => {
                    println!("Set wallpaper to {}", image_name);
                },
                Err(e) => {
                    println!("Failed to set wallpaper: {}", e);
                }
            }
    } else {
        println!("Could not find HOME directory");
    }}

fn main() {
    let is_dark_mode = get_is_dark_mode();
    println!("Is dark mode: {}", is_dark_mode);
    set_alacritty_theme(!is_dark_mode);
    if cfg!(target_os = "macos") {
        set_apple_dark_mode(!is_dark_mode);
        set_apple_wallpaper(!is_dark_mode);
    } else {
        set_gtk_theme(!is_dark_mode);
        set_gtk_wallpaper(!is_dark_mode);
    }
}
