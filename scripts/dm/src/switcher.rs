use std::process::Command;

pub trait Switcher {
    fn switch_theme(&self, dark: bool);
    fn switch_all(&self, dark: bool) {
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

    fn switch_theme(&self, dark: bool) {
        let output = if dark {
            Command::new("dconf")
                .args(&[
                    "write",
                    "/org/gnome/desktop/interface/color-scheme",
                    "'prefer-dark'",
                ])
                .output()
        } else {
            Command::new("dconf")
                .args(&[
                    "write",
                    "/org/gnome/desktop/interface/color-scheme",
                    "'default'",
                ])
                .output()
        }
        .expect("Failed to execute command");

        if !output.status.success() {
            eprintln!("Command failed with status: {}", output.status);
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
