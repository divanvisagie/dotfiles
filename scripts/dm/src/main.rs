use clap::Parser;
use std::process::Command;

use crate::switcher::SwitcherImpl;

mod switcher;

fn get_is_dark_mode() -> bool {
    if cfg!(target_os = "linux") {
        let output = Command::new("dconf")
            .args(&["read", "/org/gnome/desktop/interface/color-scheme"])
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

fn reload_tmux() {
    let home_dir = std::env::var("HOME").expect("Failed to get home path");
    let tmux_config = format!("{}/.tmux.conf", home_dir);

    Command::new("tmux")
        .args(&["source-file", &tmux_config])
        .output()
        .expect("Failed to execute command");
}

#[derive(clap::Parser, Debug)]
#[command(author, version, about)]
struct Args {
    /// Only prints the dark mode check, defaults to false
    #[clap(short, long)]
    check: bool,

    /// Force dark mode, set true to force darkmode or false to force light mode
    #[clap(short, long)]
    force_dark: Option<bool>,
}

fn main() {
    let is_dark_mode = get_is_dark_mode();
    println!("{}", is_dark_mode);
    let args = Args::parse();
    if args.check {
        return;
    }

    if let Some(force_dark) = args.force_dark {
        let switcher = SwitcherImpl::new();
        switcher.switch_all(force_dark);
        reload_tmux();
        return;
    }

    let switcher = SwitcherImpl::new();
    switcher.switch_all(!is_dark_mode);
    reload_tmux();
}
