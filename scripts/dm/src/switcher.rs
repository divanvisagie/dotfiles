use std::{env, process::Command};

pub trait Switcher {
    fn switch_wallpaper(&self, dark: bool);
    fn switch_theme(&self, dark: bool);
    fn switch_alacritty(&self, dark: bool) {
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
            r###"import = ["~/.config/alacritty/themes/themes/gruvbox_material_medium_dark.toml"]"###.to_string(),
            alacritty_config,
        ]
        .join("\n")
        } else {
            vec![
                r###"import = ["~/.config/alacritty/themes/themes/rose-pine-dawn.toml"]"###
                    .to_string(),
                alacritty_config,
            ]
            .join("\n")
        };

        std::fs::write(
            std::env::var("HOME").unwrap() + "/.config/alacritty/alacritty.toml",
            new_first_line,
        )
        .unwrap();
    }
    fn switch_all(&self, dark: bool) {
        self.switch_wallpaper(dark);
        self.switch_theme(dark);
    }
}

pub enum SwitcherImpl {
    Linux(LinuxSwitcher),
    Mac(MacSwitcher),
}

impl SwitcherImpl {
    pub fn new() -> Self {
        if cfg!(target_os = "linux") {
            Self::Linux(LinuxSwitcher::new())
        } else {
            Self::Mac(MacSwitcher::new())
        }
    }

    pub fn switch_all(&self, dark: bool) {
        match self {
            Self::Linux(switcher) => switcher.switch_all(dark),
            Self::Mac(switcher) => switcher.switch_all(dark),
        }
    }
}

pub struct LinuxSwitcher;

impl LinuxSwitcher {
    fn new() -> Self {
        Self
    }
}

impl Switcher for LinuxSwitcher {
    fn switch_wallpaper(&self, dark: bool) {
        let image_name = if dark { "dark.jpg" } else { "light.jpg" };

        if let Ok(home_dir) = env::var("HOME") {
            let wallpaper_path =
                format!("file:///{}/.dotfiles/wallpapers/{}", home_dir, image_name);

            match Command::new("gsettings")
                .args(&[
                    "set",
                    "org.gnome.desktop.background",
                    "picture-uri",
                    &wallpaper_path,
                ])
                .output()
            {
                Ok(_) => {
                    println!("Set wallpaper to {}", image_name);
                }
                Err(e) => {
                    println!("Failed to set wallpaper: {}", e);
                }
            }
        }
    }

    fn switch_theme(&self, dark: bool) {
        if dark {
            Command::new("gsettings")
                .args(&[
                    "set",
                    "org.gnome.desktop.interface",
                    "color-scheme",
                    "prefer-dark",
                ])
                .output()
                .expect("Failed to execute command");
        } else {
            Command::new("gsettings")
                .args(&[
                    "set",
                    "org.gnome.desktop.interface",
                    "color-scheme",
                    "default",
                ])
                .output()
                .expect("Failed to execute command");
        }
    }

    fn switch_all(&self, dark: bool) {
        self.switch_theme(dark);
    }
}

pub struct MacSwitcher;

impl MacSwitcher {
    fn new() -> Self {
        Self
    }
}

impl Switcher for MacSwitcher {
    fn switch_wallpaper(&self, dark: bool) {
        let image_name = if dark { "dark.jpg" } else { "light.jpg" };

        if let Ok(home_dir) = env::var("HOME") {
            let wallpaper_path = format!("{}/.dotfiles/wallpapers/{}", home_dir, image_name);

            match Command::new("wallpaper")
                .args(&["set", &wallpaper_path])
                .output()
            {
                Ok(_) => {
                    println!("Set wallpaper to {}", image_name);
                }
                Err(e) => {
                    println!("Failed to set wallpaper: {}", e);
                }
            }
        } else {
            println!("Could not find HOME directory");
        }
    }

    fn switch_theme(&self, dark: bool) {
        if dark {
            Command::new("osascript")
            .args(&["-e", "tell application \"System Events\" to tell appearance preferences to set dark mode to true"])
            .output()
            .expect("Failed to execute command");
        } else {
            Command::new("osascript")
            .args(&["-e", "tell application \"System Events\" to tell appearance preferences to set dark mode to false"])
            .output()
            .expect("Failed to execute command");
        }
    }
}
