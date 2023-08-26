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