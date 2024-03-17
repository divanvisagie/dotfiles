use dbus::blocking::Connection;
use input::event::keyboard::{KeyState, KeyboardEventTrait};
use input::{Event, Libinput, LibinputInterface};

use libc::{O_RDONLY, O_RDWR, O_WRONLY};
use std::collections::HashSet;
use std::fs::{File, OpenOptions};
use std::os::unix::{fs::OpenOptionsExt, io::OwnedFd};
use std::path::Path;
use std::time::Duration;

struct Interface;

impl LibinputInterface for Interface {
    fn open_restricted(&mut self, path: &Path, flags: i32) -> Result<OwnedFd, i32> {
        OpenOptions::new()
            .custom_flags(flags)
            .read((flags & O_RDONLY != 0) | (flags & O_RDWR != 0))
            .write((flags & O_WRONLY != 0) | (flags & O_RDWR != 0))
            .open(path)
            .map(|file| file.into())
            .map_err(|err| err.raw_os_error().unwrap())
    }
    fn close_restricted(&mut self, fd: OwnedFd) {
        drop(File::from(fd));
    }
}

fn key_to_string(key: u32) -> &'static str {
    match key {
        30 => "A",
        31 => "B",
        56 => "LeftAlt",
        125 => "LeftMod",
        _ => "Unknown",
    }
}

enum Keys {
    A = 30,
    B = 48,
    T = 20,
    G = 34,
    LeftAlt = 56,
    LeftMod = 125,
}
fn focus_window_via_extension(unique_name: &str) -> Result<(), Box<dyn std::error::Error>> {
    let conn = Connection::new_session()?;
    let proxy = conn.with_proxy(
        "org.gnome.Shell.Extension.FocusWindow", // Hypothetical D-Bus name
        "/org/gnome/Shell/Extension/FocusWindow", // Hypothetical object path
        Duration::from_millis(5000),
    );

    proxy.method_call(
        "org.gnome.Shell.Extension.FocusWindow", // Hypothetical interface
        "FocusWindowByName",                     // Hypothetical method
        (unique_name, ),
    )?;

    Ok(())
}
fn main() {
    let mut input = Libinput::new_with_udev(Interface);
    input.udev_assign_seat("seat0").unwrap();

    // create list of active keys in a Set
    let mut active_keys = HashSet::new();

    loop {
        input.dispatch().unwrap();
        for event in &mut input {
            match event {
                Event::Keyboard(kb_event) => {
                    let key = kb_event.key();
                    let state = kb_event.key_state();
                    // println!("Keyboard event: key {:?}, state {:?}", key, state);
                    // Here, you can add logic to handle specific keys and states
                    if key == Keys::LeftAlt as u32 && state == KeyState::Pressed {
                        active_keys.insert(key);
                    }
                    if key == Keys::LeftAlt as u32 && state == KeyState::Released {
                        active_keys.remove(&key);
                    }

                    if active_keys.contains(&(Keys::LeftAlt as u32))
                        && key == Keys::G as u32
                        && state == KeyState::Pressed
                    {
                        // wmctrl -a "Telegram" || telegram-desktop
                        let command = "wmctrl -a 'Telegram' || telegram-desktop";

                        let _ = std::process::Command::new("sh")
                            .arg("-c")
                            .arg(command)
                            .spawn()
                            .expect("failed to execute process");

                        println!("Launched Telegram in background");
                    }

                    if active_keys.contains(&(Keys::LeftAlt as u32))
                        && key == Keys::T as u32
                        && state == KeyState::Pressed
                    {
                        // wmctrl -a "Alacritty" || alacritty
                        let command = "wmctrl -a 'Alacritty' || alacritty";

                        let _ = std::process::Command::new("sh")
                            .arg("-c")
                            .arg(command)
                            .spawn()
                            .expect("failed to execute process");

                        println!("Launched Alacritty in background");
                    }

                    if active_keys.contains(&(Keys::LeftAlt as u32))
                        && key == Keys::B as u32
                        && state == KeyState::Pressed
                    {
                        println!("Alt + B pressed");

                        // launch or select firefox (wayland)
                        // wmctrl -a "Google Chrome" || google-chrome

                        // launch or select firefox (x11)
                        let command = "wmctrl -a 'Google Chrome' || google-chrome";
                        let _ = std::process::Command::new("sh")
                            .arg("-c")
                            .arg(command)
                            .spawn()
                            .expect("failed to execute process");

                        println!("Launched Browser in background");

                    }
                }
                _ => {} // Ignore non-keyboard events
            }
        }
    }
}
