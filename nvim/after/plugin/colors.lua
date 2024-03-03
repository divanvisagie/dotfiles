function Trans()
	-- Set background transparent
	vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "none" })
	vim.api.nvim_set_hl(0, "Normal",{ bg = "none" })
end

function Dark()
    vim.o.background = "dark"
	vim.cmd.colorscheme("everforest")
end

function Light()
    vim.o.background = "light"
	vim.cmd.colorscheme("rose-pine")
end

local function isDarkModeEnabledMac()
    local darkModeOutput = os.execute("defaults read -g AppleInterfaceStyle 2>/dev/null")
    return darkModeOutput == 0
end

local function isDarkModeEnabledLinux()
    local darkModeOutput = os.execute("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null")
    return darkModeOutput == 0
end

local function isDarkModeEnabled()
    -- generic check for mac and linux
    -- first checkt if the os is mac
    if vim.fn.has("mac") == 1 then
        return isDarkModeEnabledMac()
    else
        return isDarkModeEnabledLinux()
    end
    return true
end

if isDarkModeEnabled() then
    Dark()
else
    Light()
end
