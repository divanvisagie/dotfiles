#InstallKeybdHook

$!b:: ; Alt + b
    IfWinExist ahk_exe chrome.exe ; class for Google Chrome
    {
        WinActivate
    }
    else
    {
        Run "C:\Program Files\Google\Chrome\Application\chrome.exe" ; specify the correct path to Chrome
    }
return

; Alt + T for Windows Terminal
$!t:: 
    IfWinExist ahk_exe WindowsTerminal.exe ; executable name for Windows Terminal
    {
        WinActivate
    }
    else
    {
        Run wt ; Windows Terminal should be in PATH after installation
    }
return

; Alt + G for Telegram
$!g::
    IfWinExist ahk_exe Telegram.exe; class for Telegram Desktop
    {
        WinActivate
    }
    else
    {
        Run "%APPDATA%\Telegram Desktop\Telegram.exe" ; dynamic path to Telegram
    }
return

; Alt + S for Steam
$!s::
    IfWinExist ahk_exe Steam.exe ; class for Steam
    {
        WinActivate
    }
    else
    {
        Run "C:\Program Files (x86)\Steam\Steam.exe" ; specify the correct path to Steam
    }
return

; Alt + D for Discord
$!d::
    IfWinExist ahk_exe Discord.exe ; class for Discord
    {
        WinActivate
    }
    else
    {
        Run % "C:\Users\" . A_UserName . "\AppData\Local\Discord\Update.exe --processStart Discord.exe" ; dynamic path to Discord
    }
return
