fn get_is_dark_mode() -> bool {
    //if linux
    if cfg!(target_os = "linux") {
        let output = std::process::Command::new("gsettings")
            .args(&["get", "org.gnome.desktop.interface", "gtk-theme"])
            .output()
            .expect("Failed to execute command");
        let theme = String::from_utf8_lossy(&output.stdout);
        return theme.contains("dark");
    }
    if cfg!(target_os = "macos") {
        let output = std::process::Command::new("defaults")
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
        std::process::Command::new("gsettings")
            .args(&["set", "org.gnome.desktop.interface", "gtk-theme", "Yaru-dark"])
            .output()
            .expect("Failed to execute command");
    } else {
        std::process::Command::new("gsettings")
            .args(&["set", "org.gnome.desktop.interface", "gtk-theme", "Yaru"])
            .output()
            .expect("Failed to execute command");
    }
}

fn set_apple_dark_mode(dark: bool) {
    if dark {
        std::process::Command::new("defaults")
            .args(&["write", "-g", "AppleInterfaceStyle", "Dark"])
            .output()
            .expect("Failed to execute command");
    } else {
        std::process::Command::new("defaults")
            .args(&["delete", "-g", "AppleInterfaceStyle"])
            .output()
            .expect("Failed to execute command");
    }
}

fn main() {
    let is_dark_mode = get_is_dark_mode();
    println!("Is dark mode: {}", is_dark_mode);
    set_alacritty_theme(!is_dark_mode);
    if cfg!(target_os = "macos") {
        set_apple_dark_mode(!is_dark_mode);
    } else {
        set_gtk_theme(!is_dark_mode);
    }
}
