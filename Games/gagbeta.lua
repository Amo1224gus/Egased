print("ready")
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local remote = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Plant_RE")

-- Localization
local localeId = player.LocaleId
local isRussian = localeId == "ru-ru"

local englishText = {
    windowTitle = "Egas X! [0.09Rewr]",
    windowNote = "Enter the key to access the script.\n\nNo key? Join our Discord: https://discord.gg/cRbced9G",
    homeTabTitle = "Home",
    autoFarmTabTitle = "Auto Farm",
    freeSeedsTabTitle = "Free Seeds",
    miscTabTitle = "Misc",
    guiTabTitle = "GUI",
    welcomeTitle = "Welcome to Egased Hub!",
    welcomeDesc = "This script helps you grow your garden efficiently.",
    discordButtonTitle = "Copy Discord Link",
    discordNotifyTitle = "Discord Link Copied",
    discordNotifyContent = "The Discord link has been copied to your clipboard.",
    themeDropdownTitle = "Select Theme",
    transparencyToggleTitle = "Toggle Window Transparency",
    errorTitle = "Error",
    errorDesc = "Could not find your farm. Ensure you own a farm.",
    collectPlantsTitle = "Collect Plants",
    autoSellTitle = "Auto Sell",
    autoSeedPlantsTitle = "Auto Seed Plants",
    autoBuySeedsTitle = "Auto Buy Rare Seeds",
    autoBuySeedsDesc = "Automatically buys rare seeds: Mushroom, Coconut, Cactus, Dragon Fruit, Grape, Mango.",
    autoSpendSeedPackTitle = "Auto Spend Seed Pack",
    hopServerTitle = "Hop to Old Server",
    get100SeedsTitle = "Get 100 Seeds",
    get100SeedsDesc = "Get ~100 seeds instead of 1. Hold the item you want an Angry Plant from!",
    freeSeedsPatchTitle = "FREE SEED PACKS WAS PATCHED. STAY TUNED.",
    autoBuyGearTitle = "Auto Buy Every Gear",
    characterSpeedTitle = "Character Speed",
    infJumpsTitle = "Infinite Jumps",
    boostFpsTitle = "Boost FPS",
    boostFpsNotifyTitle = "FPS Boost Disabled",
    boostFpsNotifyContent = "Please rejoin the game to restore other farms and player models.",
    disable3dRenderingTitle = "Disable 3D Rendering",
    hiddenGearButtonTitle = "Enable Hidden Gear Button",
    shopGUITitle = "Shop GUI",
    gearShopTitle = "Gear Shop",
    dailyQuestTitle = "Daily Quest",
    easterShopTitle = "Easter Shop",
    autoBuyEggsTitle = "Auto Buy All Eggs",
    autoMoonlitQuestTitle = "Auto Moonlit Quest",
    noclipTitle = "Noclip"
}

local russianText = {
    windowTitle = "EgasedHub:R [Grow a Garden]",
    windowNote = "Введите ключ для доступа к скрипту.\n\nНет ключа? Присоединяйтесь к Discord по кнопке.",
    homeTabTitle = "Главная",
    autoFarmTabTitle = "Автофарм",
    freeSeedsTabTitle = "Бесплатные семена",
    miscTabTitle = "Разное",
    guiTabTitle = "Интерфейс",
    welcomeTitle = "Добро пожаловать в Egased Hub!",
    welcomeDesc = "Этот скрипт помогает эффективно выращивать ваш сад.",
    discordButtonTitle = "Скопировать ссылку на Discord",
    discordNotifyTitle = "Ссылка на Discord скопирована",
    discordNotifyContent = "Ссылка на Discord скопирована в буфер обмена.",
    themeDropdownTitle = "Выбрать тему",
    transparencyToggleTitle = "Переключить прозрачность окна",
    errorTitle = "Ошибка",
    errorDesc = "Не удалось найти вашу ферму. Убедитесь, что вы владеете фермой.",
    collectPlantsTitle = "Собирать растения",
    autoSellTitle = "Автопродажа",
    autoSeedPlantsTitle = "Автопасадка семян",
    autoBuySeedsTitle = "Автопокупка редких семян",
    autoBuySeedsDesc = "Автоматически покупает редкие семена: Гриб, Кокос, Кактус, Драконий фрукт, Виноград, Манго.",
    autoSpendSeedPackTitle = "Автоиспользование набора семян",
    hopServerTitle = "Перейти на старый сервер",
    get100SeedsTitle = "Получить 100 семян",
    get100SeedsDesc = "Получите ~100 семян вместо 1. Держите предмет, из которого хотите получить Angry Plant!",
    freeSeedsPatchTitle = "БЕСПЛАТНЫЕ НАБОРЫ СЕМЯН БЫЛИ ЗАПАТЧЕНЫ. СЛЕДИТЕ ЗА ОБНОВЛЕНИЯМИ.",
    autoBuyGearTitle = "Автопокупка всего снаряжения",
    characterSpeedTitle = "Скорость персонажа",
    infJumpsTitle = "Бесконечные прыжки",
    boostFpsTitle = "Увеличить FPS",
    boostFpsNotifyTitle = "Увеличение FPS отключено",
    boostFpsNotifyContent = "Перезайдите в игру, чтобы восстановить фермы и модели других игроков.",
    disable3dRenderingTitle = "Отключить 3D-рендеринг",
    hiddenGearButtonTitle = "Включить скрытую кнопку снаряжения",
    shopGUITitle = "Магазин семян",
    gearShopTitle = "Магазин снаряжения",
    dailyQuestTitle = "Ежедневные квесты",
    easterShopTitle = "Пасхальный магазин",
    autoBuyEggsTitle = "Автопокупка всех яиц",
    autoMoonlitQuestTitle = "Автоматический квест Moonlit",
    noclipTitle = "Ноклип"
}

local text = isRussian and russianText or englishText

local Window = WindUI:CreateWindow({
    Title = text.windowTitle,
    Icon = "sprout",
    Author = "Egased",
    Folder = "EgasedHub",
    Size = UDim2.fromOffset(600, 400),
    Transparent = true,
    Theme = "Plant",
    UserEnabled = false,
    SideBarWidth = 200,
    HasOutline = true,
    KeySystem = {
        Key = { "idontknowhowtobefunnyanymore" },
        Note = text.windowNote,
        URL = "https://discord.gg/cRbced9G",
        SaveKey = true,
    },
})

local function findOurFarm()
    local playerName = player.Name
    for _, plot in pairs(workspace.Farm:GetChildren()) do
        local important = plot:FindFirstChild("Important") or plot:FindFirstChild("Importanert")
        if important then
            local data = important:FindFirstChild("Data")
            if data and data:FindFirstChild("Owner") and data.Owner.Value == playerName then
                return plot
            end
        end
    end
    return nil
end

-- Noclip Functions
local Noclip = nil
local Clip = nil

local function noclip()
    Clip = false
    local function Nocl()
        if Clip == false and game.Players.LocalPlayer.Character ~= nil then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
        task.wait(0.21) -- basic optimization
    end
    Noclip = RunService.Stepped:Connect(Nocl)
end

local function clip()
    if Noclip then
        Noclip:Disconnect()
        Noclip = nil
    end
    Clip = true
end

local HomeTab = Window:Tab({ Title = text.homeTabTitle, Icon = "home" })
local AutoFarmTab = Window:Tab({ Title = text.autoFarmTabTitle, Icon = "tractor" })
local MiscTab = Window:Tab({ Title = text.miscTabTitle, Icon = "settings" })
local GUITab = Window:Tab({ Title = text.guiTabTitle, Icon = "monitor" })
local FreeSeedsTab = Window:Tab({ Title = text.freeSeedsTabTitle, Icon = "leaf" })

HomeTab:Paragraph({
    Title = text.welcomeTitle,
    Image = "info",
})

HomeTab:Button({
    Title = text.discordButtonTitle,
    Icon = "copy",
    Callback = function()
        setclipboard("https://discord.gg/cRbced9G")
        WindUI:Notify({
            Title = text.discordNotifyTitle,
            Content = text.discordNotifyContent,
            Duration = 5,
        })
    end
})

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

HomeTab:Dropdown({
    Title = text.themeDropdownTitle,
    Multi = false,
    AllowNone = false,
    Value = WindUI:GetCurrentTheme(),
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})

HomeTab:Toggle({
    Title = text.transparencyToggleTitle,
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

local ourFarm = findOurFarm()
if not ourFarm then
    AutoFarmTab:Paragraph({
        Title = text.errorTitle,
        Desc = text.errorDesc,
        Image = "alert-triangle",
        Color = "Red",
    })
else
    local collectPlantsEnabled = false
    local autoSellingEnabled = false
    local autoSeedPlantsEnabled = false
    local autoBuySeedsEnabled = false
    local autoSpendSeedPackEnabled = false
    local autoBuyEggsEnabled = false
    local autoMoonlitQuestEnabled = false
    local isBusy = false

    -- Calculate a safe return position based on the farm
    local function getFarmReturnPosition()
        local farmBase = ourFarm:FindFirstChild("Base") or ourFarm:FindFirstChild("Important")
        if farmBase then
            return farmBase.CFrame * CFrame.new(0, 5, 0) -- Slightly above the farm base
        end
        return CFrame.new(27.028656, 4.61500359, -81.4960098) -- Fallback position
    end

    AutoFarmTab:Toggle({
        Title = text.collectPlantsTitle,
        Default = false,
        Callback = function(state)
            collectPlantsEnabled = state
            if state then
                spawn(function()
                    local processedPrompts = {}
                    while collectPlantsEnabled do
                        if not isBusy then
                            local farm = ourFarm:FindFirstChild("Important"):FindFirstChild("Plants_Physical")
                            if farm then
                                for _, prompt in ipairs(farm:GetDescendants()) do
                                    if not collectPlantsEnabled then break end
                                    if prompt:IsA("ProximityPrompt") and not processedPrompts[prompt] then
                                        local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                        if playerRoot then
                                            local dist = (playerRoot.Position - prompt.Parent.Position).Magnitude
                                            if dist <= 20 then
                                                prompt.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow
                                                prompt.MaxActivationDistance = 100
                                                prompt.RequiresLineOfSight = false
                                                prompt.Enabled = true
                                                fireproximityprompt(prompt, 1, true)
                                                processedPrompts[prompt] = true
                                            else
                                                playerRoot.CFrame = prompt.Parent.CFrame
                                            end
                                            task.wait(0.2)
                                        end
                                    end
                                end
                            end
                            task.wait(0.5)
                        elseif autoSellingEnabled then
                            local startTime = tick()
                            while collectPlantsEnabled and autoSellingEnabled and tick() - startTime < 10 and not isBusy do
                                local farm = ourFarm:FindFirstChild("Important"):FindFirstChild("Plants_Physical")
                                if farm then
                                    for _, prompt in ipairs(farm:GetDescendants()) do
                                        if not collectPlantsEnabled then break end
                                        if prompt:IsA("ProximityPrompt") and not processedPrompts[prompt] then
                                            local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                            if playerRoot then
                                                local dist = (playerRoot.Position - prompt.Parent.Position).Magnitude
                                                if dist <= 20 then
                                                    prompt.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow
                                                    prompt.MaxActivationDistance = 100
                                                    prompt.RequiresLineOfSight = false
                                                    prompt.Enabled = true
                                                    fireproximityprompt(prompt, 1, true)
                                                    processedPrompts[prompt] = true
                                                else
                                                    playerRoot.CFrame = prompt.Parent.CFrame
                                                end
                                                task.wait(0.2)
                                            end
                                        end
                                    end
                                end
                                task.wait(0.5)
                            end
                        end
                        processedPrompts = {}
                    end
                end)
            end
        end
    })

    AutoFarmTab:Toggle({
        Title = text.autoSellTitle,
        Default = false,
        Callback = function(state)
            autoSellingEnabled = state
            if state then
                spawn(function()
                    while autoSellingEnabled do
                        local character = player.Character or player.CharacterAdded:Wait()
                        local root = character:WaitForChild("HumanoidRootPart")
                        local inventory = backpack:GetChildren()
                        if #inventory >= 10 then
                            isBusy = true
                            local originalPosition = getFarmReturnPosition()
                            local shopStand = workspace.NPCS:FindFirstChild("Sell Stands") and workspace.NPCS["Sell Stands"]:FindFirstChild("Shop Stand")
                            if shopStand then
                                root.CFrame = shopStand.CFrame * CFrame.new(0, 5, 3) -- Adjusted position
                                task.wait(0.3) -- Wait for server to register position
                                local success, err = pcall(function()
                                    ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
                                end)
                                if not success then
                                    warn("Failed to sell inventory: " .. tostring(err))
                                end
                                task.wait(0.6) -- Wait for sell to process
                                root.CFrame = originalPosition
                            else
                                warn("Shop Stand not found")
                            end
                            isBusy = false
                        end
                        task.wait(15) -- Changed to 15 seconds
                    end
                end)
            end
        end
    })

    AutoFarmTab:Toggle({
        Title = text.autoSeedPlantsTitle,
        Default = false,
        Callback = function(state)
            autoSeedPlantsEnabled = state
            if state then
                spawn(function()
                    while autoSeedPlantsEnabled do
                        local character = player.Character or player.CharacterAdded:Wait()
                        local root = character:WaitForChild("HumanoidRootPart")
                        local pos = Vector3.new(math.floor(root.Position.X), 0.1, math.floor(root.Position.Z))
                        local tool, seedType = nil, nil
                        for _, item in ipairs(character:GetChildren()) do
                            if item:IsA("Tool") and item.Name:find("Seed") then
                                seedType = item.Name:match("^(.-) Seed")
                                tool = item
                                break
                            end
                        end
                        if not tool then
                            for _, item in ipairs(backpack:GetChildren()) do
                                if item:IsA("Tool") and item.Name:find("Seed") then
                                    seedType = item.Name:match("^(.-) Seed")
                                    tool = item
                                    break
                                end
                            end
                        end
                        if tool and seedType then
                            if tool.Parent == backpack then
                                character:WaitForChild("Humanoid"):EquipTool(tool)
                                repeat task.wait() until tool.Parent == character
                            end
                            remote:FireServer(pos, seedType)
                        end
                        task.wait(0.1)
                    end
                end)
            end
        end
    })

    AutoFarmTab:Toggle({
        Title = text.autoBuySeedsTitle,
        Desc = text.autoBuySeedsDesc,
        Default = false,
        Callback = function(state)
            autoBuySeedsEnabled = state
            if state then
                spawn(function()
                    local rareSeeds = {"Mushroom", "Coconut", "Cactus", "Dragon Fruit", "Grape", "Mango"}
                    while autoBuySeedsEnabled do
                        for _, seed in pairs(rareSeeds) do
                            local args = { seed }
                            ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(unpack(args))
                        end
                        task.wait(5)
                    end
                end)
            end
        end
    })

    AutoFarmTab:Toggle({
        Title = text.autoSpendSeedPackTitle,
        Default = false,
        Callback = function(state)
            autoSpendSeedPackEnabled = state
            if state then
                spawn(function()
                    while autoSpendSeedPackEnabled do
                        local character = player.Character or player.CharacterAdded:Wait()
                        local tool = character:FindFirstChildOfClass("Tool")
                        if tool and tool.Name:lower():find("seed pack") then
                            for i = 1, 10 do
                                tool:Activate()
                                task.wait(0.1)
                            end
                        end
                        local rollCrateUI = player.PlayerGui:FindFirstChild("RollCrate_UI")
                        if rollCrateUI then
                            local frame = rollCrateUI:FindFirstChild("Frame")
                            if frame then
                                frame.Visible = false
                            end
                        end
                        task.wait(0.1)
                    end
                end)
            end
        end
    })

    AutoFarmTab:Toggle({
        Title = text.autoBuyEggsTitle,
        Default = false,
        Callback = function(state)
            autoBuyEggsEnabled = state
            if state then
                spawn(function()
                    while autoBuyEggsEnabled do
                        for i = 1, 3 do
                            local args = { i }
                            ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(unpack(args))
                        end
                        task.wait(10)
                    end
                end)
            end
        end
    })

    AutoFarmTab:Toggle({
        Title = text.autoMoonlitQuestTitle,
        Default = false,
        Callback = function(state)
            autoMoonlitQuestEnabled = state
            if state then
                spawn(function()
                    while autoMoonlitQuestEnabled do
                        local hasMoonlit = false
                        for _, item in pairs(backpack:GetChildren()) do
                            if item:IsA("Tool") and item.Name:find("Moonlit") then
                                hasMoonlit = true
                                break
                            end
                        end
                        if hasMoonlit then
                            local args = { "SubmitAllPlants" }
                            ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer(unpack(args))
                            task.wait(5)
                        end
                        task.wait(2)
                    end
                end)
            end
        end
    })
end

FreeSeedsTab:Paragraph({
    Title = text.freeSeedsPatchTitle,
    Image = "alert-triangle",
    Color = "Red",
})

MiscTab:Slider({
    Title = text.characterSpeedTitle,
    Value = {
        Min = 16,
        Max = 100,
        Default = 16,
    },
    Callback = function(value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        character:WaitForChild("Humanoid").WalkSpeed = value
    end
})

local infJumpsEnabled = false
MiscTab:Toggle({
    Title = text.infJumpsTitle,
    Default = false,
    Callback = function(state)
        infJumpsEnabled = state
        if state then
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if infJumpsEnabled then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end)
        end
    end
})

local boostFpsEnabled = false
MiscTab:Toggle({
    Title = text.boostFpsTitle,
    Default = false,
    Callback = function(state)
        boostFpsEnabled = state
        if state then
            for _, farm in pairs(workspace.Farm:GetChildren()) do
                if farm ~= ourFarm then
                    farm:Destroy()
                end
            end
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Plastic
                    if part:IsA("Texture") then
                        part:Destroy()
                    else
                        part.TextureID = ""
                    end
                end
            end
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    local character = player.Character
                    if character then
                        character:Destroy()
                    end
                end
            end
        else
            WindUI:Notify({
                Title = text.boostFpsNotifyTitle,
                Content = text.boostFpsNotifyContent,
                Duration = 5,
            })
        end
    end
})

local disable3dRenderingEnabled = false
MiscTab:Toggle({
    Title = text.disable3dRenderingTitle,
    Default = false,
    Callback = function(state)
        disable3dRenderingEnabled = state
        game:GetService("RunService"):Set3dRenderingEnabled(not state)
    end
})

local noclipEnabled = true
MiscTab:Toggle({
    Title = text.noclipTitle,
    Default = true,
    Callback = function(state)
        noclipEnabled = state
        if state then
            noclip()
        else
            clip()
        end
    end
})

-- Enable noclip by default
noclip()

local hiddenGearButtonEnabled = false
GUITab:Toggle({
    Title = text.hiddenGearButtonTitle,
    Default = false,
    Callback = function(state)
        hiddenGearButtonEnabled = state
        local teleportUI = player.PlayerGui:FindFirstChild("Teleport_UI")
        if teleportUI then
            local frame = teleportUI:FindFirstChild("Frame")
            if frame then
                local gear = frame:FindFirstChild("Gear")
                if gear then
                    gear.Visible = state
                end
            end
        end
    end
})

local shopGUIEnabled = false
GUITab:Toggle({
    Title = text.shopGUITitle,
    Default = false,
    Callback = function(state)
        shopGUIEnabled = state
        local seedShop = player.PlayerGui:FindFirstChild("Seed_Shop")
        if seedShop then
            seedShop.Enabled = state
        end
    end
})

local gearShopEnabled = false
GUITab:Toggle({
    Title = text.gearShopTitle,
    Default = false,
    Callback = function(state)
        gearShopEnabled = state
        local gearShop = player.PlayerGui:FindFirstChild("Gear_Shop")
        if gearShop then
 backlash gearShop.Enabled = state
        end
    end
})

local dailyQuestEnabled = false
GUITab:Toggle({
    Title = text.dailyQuestTitle,
    Default = false,
    Callback = function(state)
        dailyQuestEnabled = state
        local dailyQuestsUI = player.PlayerGui:FindFirstChild("DailyQuests_UI")
        if dailyQuestsUI then
            dailyQuestsUI.Enabled = state
        end
    end
})

GUITab:Toggle({
    Title = text.easterShopTitle,
    Default = false,
    Callback = function(state)
        local head = workspace:WaitForChild("NightEvent"):WaitForChild("Prompt"):WaitForChild("Head")
        local prompt = head:FindFirstChildWhichIsA("ProximityPrompt")
        if prompt then
            prompt.Enabled = state
        else
            warn("ProximityPrompt not found in NightEvent.Prompt.Head")
        end
    end
})

Window:SelectTab(1)
