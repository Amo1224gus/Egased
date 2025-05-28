local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- Таблица поддерживаемых игр
local gameScripts = {
    ["126884695634066"] = {
        loadstringUrl = "https://raw.githubusercontent.com/Amo1224gus/Egased/refs/heads/main/Games/GrowAGarden",
        fallbackName = "Grow a Garden"
    },

    ["7534035522"] = {
        loadstringUrl = "https://raw.githubusercontent.com/Amo1224gus/Egased/refs/heads/main/Games/tw.lua",
        fallbackName = "Tower World"
    },

    ["18687417158"] = {
        loadstringUrl = "https://raw.githubusercontent.com/Amo1224gus/Egased/refs/heads/main/Games/forsakenk",
        fallbackName = "Forsaken"
    },
    ["16552821455"] = {
        loadstringUrl = "https://raw.githubusercontent.com/Amo1224gus/iriska/refs/heads/main/english.lua",
        fallbackName = "Dandy's World"
    },
}

-- Функция для получения названия игры по ID через Roblox API
local function getGameNameById(gameId)
    local success, response = pcall(function()
        local url = "https://games.roblox.com/v1/games?universeIds=" .. gameId
        local data = HttpService:JSONDecode(game:HttpGet(url))
        if data and data.data and data.data[1] and data.data[1].name then
            return data.data[1].name
        end
        return nil
    end)
    if success and response then
        return response
    else
        return gameScripts[gameId] and gameScripts[gameId].fallbackName or "Unknown Game"
    end
end

-- Формирование списка поддерживаемых игр
local supportedGames = {}
for gameId, scriptInfo in pairs(gameScripts) do
    local gameName = getGameNameById(gameId)
    table.insert(supportedGames, gameName)
end
local supportedGamesText = table.concat(supportedGames, ", ")

-- Показ уведомления о поддерживаемых играх
WindUI:Notify({
    Title = "Supported Games",
    Content = "This script supports: " .. supportedGamesText,
    Duration = 10
})

-- Настройка начальной анимации
local IriXa = Instance.new("ScreenGui")
IriXa.Name = "IriXa"
IriXa.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
IriXa.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local IriXaLogo = Instance.new("ImageLabel")
IriXaLogo.Name = "IriXaLogo"
IriXaLogo.Parent = IriXa
IriXaLogo.AnchorPoint = Vector2.new(0.5, 0.5)
IriXaLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IriXaLogo.BackgroundTransparency = 1.000
IriXaLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
IriXaLogo.BorderSizePixel = 0
IriXaLogo.Position = UDim2.new(0.439733922, 0, 0.5, 0)
IriXaLogo.Size = UDim2.new(0.095238097, 0, 0.147699744, 0)
IriXaLogo.Visible = false
IriXaLogo.Image = "rbxassetid://87134700438873"
IriXaLogo.ImageTransparency = 1.000

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Parent = IriXaLogo
UIAspectRatioConstraint.AspectRatio = 1.164

local One = Instance.new("TextLabel")
One.Name = "One"
One.Parent = IriXa
One.AnchorPoint = Vector2.new(0.5, 0.5)
One.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
One.BackgroundTransparency = 1.000
One.BorderColor3 = Color3.fromRGB(0, 0, 0)
One.BorderSizePixel = 0
One.Position = UDim2.new(0.547347248, 0, 0.465496361, 0)
One.Size = UDim2.new(0.134138167, 0, 0.0302663445, 0)
One.Visible = false
One.Font = Enum.Font.Michroma
One.RichText = true
One.Text = "<b>Egas X!</b>"
One.TextColor3 = Color3.fromRGB(255, 255, 255)
One.TextSize = 49.000
One.TextTransparency = 1.000
One.TextXAlignment = Enum.TextXAlignment.Left

local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint_2.Parent = One
UIAspectRatioConstraint_2.AspectRatio = 8.000

local Divider = Instance.new("TextLabel")
Divider.Name = "Divider"
Divider.Parent = IriXa
Divider.AnchorPoint = Vector2.new(0.5, 0.5)
Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Divider.BackgroundTransparency = 1.000
Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
Divider.BorderSizePixel = 0
Divider.Position = UDim2.new(0.547347248, 0, 0.481234878, 0)
Divider.Size = UDim2.new(0.134138167, 0, 0.0302663445, 0)
Divider.Visible = false
Divider.Font = Enum.Font.Michroma
Divider.RichText = true
Divider.Text = "<b>______</b>"
Divider.TextColor3 = Color3.fromRGB(255, 255, 255)
Divider.TextSize = 49.000
Divider.TextTransparency = 1.000
Divider.TextXAlignment = Enum.TextXAlignment.Left

local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint_3.Parent = Divider
UIAspectRatioConstraint_3.AspectRatio = 8.000

local Two = Instance.new("TextLabel")
Two.Name = "Two"
Two.Parent = IriXa
Two.AnchorPoint = Vector2.new(0.5, 0.5)
Two.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Two.BackgroundTransparency = 1.000
Two.BorderColor3 = Color3.fromRGB(0, 0, 0)
Two.BorderSizePixel = 0
Two.Position = UDim2.new(0.547347248, 0, 0.534503639, 0)
Two.Size = UDim2.new(0.134138167, 0, 0.0302663445, 0)
Two.Visible = false
Two.Font = Enum.Font.RobotoMono
Two.RichText = true
Two.Text = "<b>" .. (tostring(game.PlaceId) == "18984416148" and "By Egas (feat. Rode)" or "By Egas") .. "</b>"
Two.TextColor3 = Color3.fromRGB(255, 255, 255)
Two.TextSize = 23.000
Two.TextTransparency = 1.000
Two.TextXAlignment = Enum.TextXAlignment.Left

local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint_4.Parent = Two
UIAspectRatioConstraint_4.AspectRatio = 8.000

-- Анимация загрузки
local function runSplashAnimation()
    local Blur = Instance.new("BlurEffect")
    local Logo = IriXaLogo
    
    local LogoStartPosition = UDim2.new(0.499, 0, 0.5, 0)
    local LogoEndPosition = UDim2.new(0.44, 0, 0.5, 0)
    
    Blur.Parent = game:GetService("Lighting")
    Blur.Size = 0
    Blur.Enabled = true
    
    Logo.ImageTransparency = 1
    Logo.Position = LogoStartPosition
    Logo.Visible = true
    
    One.Visible = true
    Two.Visible = true
    Divider.Visible = true
    
    coroutine.wrap(function()
        for step=0, 15, 1 do
            Blur.Size = step
            wait()
        end
    end)()
    
    coroutine.wrap(function()
        for step=1, 0, -0.1 do
            Logo.ImageTransparency = step
            wait()
        end
    end)()
    
    local TweenDetails = {Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 1}
    
    Logo:TweenPosition(LogoEndPosition, table.unpack(TweenDetails))
    
    coroutine.wrap(function()
        for step=1, 0, -0.1 do
            One.TextTransparency = step
            Divider.TextTransparency = step
            Two.TextTransparency = step
            wait()
        end
    end)()
    
    wait(5)
    
    coroutine.wrap(function()
        for step=15, 0, -1 do
            Blur.Size = step
            wait()
        end
    end)()
    
    coroutine.wrap(function()
        for step=0, 1, 0.1 do
            Logo.ImageTransparency = step
            wait()
        end
    end)()
    
    Logo:TweenPosition(LogoStartPosition, table.unpack(TweenDetails))
    
    coroutine.wrap(function()
        for step=0, 1, 0.1 do
            One.TextTransparency = step
            Divider.TextTransparency = step
            Two.TextTransparency = step
            wait()
        end
    end)()
    
    wait(5)
    
    IriXa:Destroy()
    Blur:Destroy()
end

-- Проверка текущей игры и загрузка скрипта
local currentGameId = tostring(game.PlaceId)
local scriptInfo = gameScripts[currentGameId]

runSplashAnimation()

-- Показ уведомления о текущей игре
WindUI:Notify({
    Title = "Game Status",
    Content = scriptInfo and "Loading: " .. getGameNameById(currentGameId) or "Not supported game!",
    Duration = 10
})

if scriptInfo then
    local success, result = pcall(function()
        return loadstring(game:HttpGet(scriptInfo.loadstringUrl))()
    end)
    if not success then
        WindUI:Notify({
            Title = "Script Load Error",
            Content = "Failed to load script for " .. getGameNameById(currentGameId) .. ": " .. result,
            Duration = 10,
        })
    end
end
