-- Key System Bait Script with Always-Visible Discord Copy Button

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

WindUI.TransparencyValue = 0.15
WindUI:SetTheme("Plant")

local correctKey = "thatjustnormalkeywhynot123"
local discordLink = "https://discord.gg/5kpxEgqQjc"

local Window = WindUI:CreateWindow({
    Title = "Enter Access Key",
    Icon = "lock",
    Author = "Key Verification",
    Folder = "GaG_Vulnerability_Key",
    Size = UDim2.fromOffset(450, 250),
    Theme = "Plant"
})

local Tabs = {
    Main = Window:Section({ Title = "Key System", Opened = true })
}

local TabHandles = {
    InfoTab = Tabs.Main:Tab({ Title = "Instructions", Icon = "info" })
}

-- Текст с инструкцией
TabHandles.InfoTab:Paragraph({
    Title = "How to get the key",
    Desc = "You can get the access key in our Discord server.\nJoin and check the key channel.",
    Image = "link",
    ImageSize = 18,
    Color = "White"
})

-- Кнопка для копирования Discord
TabHandles.InfoTab:Button({
    Title = "Copy Discord Link",
    Icon = "copy",
    Variant = "Primary",
    Callback = function()
        setclipboard(discordLink)
        WindUI:Notify({
            Title = "Copied!",
            Content = "Discord link copied to clipboard",
            Icon = "check",
            Duration = 3
        })
    end
})

-- Поле для ввода ключа
local enteredKey = ""
TabHandles.InfoTab:Input({
    Title = "Enter your key",
    Value = "",
    Placeholder = "Enter key here",
    Callback = function(val)
        enteredKey = val
    end
})

-- Кнопка проверки ключа
TabHandles.InfoTab:Button({
    Title = "Submit Key",
    Icon = "check",
    Variant = "Primary",
    Callback = function()
        if enteredKey == correctKey then
            WindUI:Notify({
                Title = "Info",
                Content = "This script is actually a bait to join our Discord.\nDon't worry, we release all vulns faster than anyone, so stay with us!",
                Icon = "info",
                Duration = 7
            })
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Invalid key!",
                Icon = "x",
                Duration = 3
            })
        end
    end
})
