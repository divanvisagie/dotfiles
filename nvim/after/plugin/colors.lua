function Trans()
	-- Set background transparent
	vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "none" })
	vim.api.nvim_set_hl(0, "Normal",{ bg = "none" })
end

-- vim.cmd.colorscheme("catpuccin")
function Dark()
    -- vim.cmd.colorscheme("everforest")
    -- vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_background = "medium"
    vim.cmd.colorscheme("gruvbox-material")
    vim.o.background = "dark"
end

function Light()
    vim.cmd.colorscheme("rose-pine")
    vim.o.background = "light"
end

local function isDarkModeEnabledMac()
    local darkModeOutput = os.execute("defaults read -g AppleInterfaceStyle 2>/dev/null")
    return darkModeOutput == 0
end


local function isDarkModeEnabledLinux()
    local commandString = "gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null"

    -- Attempt to open the command output
    local handle = io.popen(commandString)
    if not handle then
        print("Failed to execute command")
        return false
    end

    -- Get the output and ensure the file handle is closed
    local darkModeOutput = handle:read("*a")
    handle:close()

    -- Debugging the output
    -- print("'" .. darkModeOutput .. "'")

    -- Using pattern matching to search for 'Yaru-dark' within the output,
    -- ignoring leading/trailing quotes and whitespace
    local pattern = "'.*prefer%-dark.*'"
    local isDark = darkModeOutput:match(pattern) ~= nil
    return isDark
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
