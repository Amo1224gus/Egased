
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local HttpService = game:GetService("HttpService")

-- Таблица поддерживаемых игр
local gameScripts = {
    ["126884695634066"] = {
        loadstringUrl = "https://raw.githubusercontent.com/Amo1224gus/Egased/refs/heads/main/Games/GrowAGarden",
        fallbackName = "Grow a Garden"
    },
    Пример добавления других игр
    ["18687417158"] = {
         loadstringUrl = "https://raw.githubusercontent.com/Amo1224gus/Egased/refs/heads/main/Games/forsakenk",
         fallbackName = "Forsaken"
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
    Content = "This hub supports: " .. supportedGamesText,
    Duration = 10,
})

-- Проверка текущей игры и загрузка скрипта
local currentGameId = tostring(game.PlaceId)
local scriptInfo = gameScripts[currentGameId]

if scriptInfo then
    -- Загрузка скрипта для текущей игры
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
else
    -- Уведомление, если игра не поддерживается
    WindUI:Notify({
        Title = "Unsupported Game",
        Content = "You are not in supported game!",
        Duration = 10,
    })
end
