use std::process::Command;

#[allow(unused)]
enum Browser {
    Chrome(String, String),
    Firefox(String, String),
    Safari(String, String),
}

fn get_default_browser() -> std::io::Result<Browser> {
    match Command::new("sh")
        .arg("-c")
        .arg("defaults read com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers | grep -B 1 -A 3 \"https\" | grep -m 1 \"LSHandlerRoleAll\"")
        .output() {
        Ok(output) => {
            let stdout = String::from_utf8_lossy(&output.stdout);
            let bundle_id = stdout.trim();
            // trim out 'LSHandlerRoleAll = '
            let bundle_id = bundle_id.trim_start_matches("LSHandlerRoleAll = ");
            // get the value between the double quotes
            let bundle_id = bundle_id.trim_matches('"');
            // remove everythig after the " quotes
            let bundle_id = bundle_id.split('"').collect::<Vec<&str>>()[0];
            
            println!("bundle_id: '{}'", bundle_id);
            match bundle_id {
                "org.mozilla.firefox" => Ok(Browser::Firefox("Firefox".to_string(), bundle_id.to_string())),
                "com.google.chrome" => Ok(Browser::Chrome("Google Chrome".to_string(), bundle_id.to_string())),
                "com.apple.Safari" => Ok(Browser::Safari("Safari".to_string(), bundle_id.to_string())),
                _ => Err(std::io::Error::new(std::io::ErrorKind::Other, "Unknown browser")),
            }
        }
        Err(e) => Err(e),
        }
}

fn focus_browser(browser: &Browser) {
    // osascript -e 'tell application "Google Chrome" to activate'
    match browser {
        Browser::Chrome(_, _) => {
            Command::new("osascript")
                .arg("-e")
                .arg("tell application \"Google Chrome\" to activate")
                .output()
                .expect("failed to execute process");
        }
        Browser::Firefox(_, _) => {
            Command::new("osascript")
                .arg("-e")
                .arg("tell application \"Firefox\" to activate")
                .output()
                .expect("failed to execute process");
        }
        Browser::Safari(_, _) => {
            Command::new("osascript")
                .arg("-e")
                .arg("tell application \"Safari\" to activate")
                .output()
                .expect("failed to execute process");
        }
    }
}
fn main() {
    match get_default_browser() {
        Ok(output) => {
            focus_browser(&output);
            let name = match output {
                Browser::Chrome(name, _) => name,
                Browser::Firefox(name, _) => name,
                Browser::Safari(name, _) => name,
            };
            println!("Default browser bundle identifier: {}",name);
        }
        Err(e) => println!("Failed to get default browser: {}", e),
    }
}
