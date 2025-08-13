-- Key System Bait Script with Discord Copy Button

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
    Size = UDim2.fromOffset(400, 200),
    Theme = "Plant"
})

local Tabs = {
    Main = Window:Section({ Title = "Key Check", Opened = true })
}

local TabHandles = {
    InputTab = Tabs.Main:Tab({ Title = "Key Input", Icon = "key" })
}

local enteredKey = ""
TabHandles.InputTab:Input({
    Title = "Please enter your key to continue",
    Value = "",
    Placeholder = "Enter key here",
    Callback = function(val)
        enteredKey = val
    end
})

TabHandles.InputTab:Button({
    Title = "Submit",
    Icon = "check",
    Variant = "Primary",
    Callback = function()
        if enteredKey == correctKey then
            -- bait message
            WindUI:Notify({
                Title = "Info",
                Content = "This script is actually a bait to join our Discord.\nDon't worry, we release all vulns faster than anyone, so stay with us!",
                Icon = "info",
                Duration = 6
            })

            -- Discord copy button
            TabHandles.InputTab:Button({
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
