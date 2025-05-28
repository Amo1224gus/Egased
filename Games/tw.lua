local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Egas X | Tower World 0.1",
    Icon = "rbxassetid://87134700438873",
    Author = "Egas",
    Folder = "TowerWorld",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = true
})

Window:EditOpenButton({
    Title = "Egas X!",
    Icon = "rbxassetid://87134700438873",
    CornerRadius = UDim.new(0, 10),
    StrokeThickness = 3,
    Color = ColorSequence.new(
        Color3.fromRGB(255, 15, 123), 
        Color3.fromRGB(248, 155, 41)
    )
})

-- Auto Tab
local AutoTab = Window:Tab({
    Title = "Auto",
    Icon = "play"
})

AutoTab:Section({ 
    Title = "Automation Features",
    TextSize = 30,
    TextXAlignment = "Center"
})

-- Collect All Bits (Lush Tower)
local collectBitsEnabled = false
local function getNearestBit()
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end
    local tower = workspace:FindFirstChild("Towers")
    local lushTower = tower and tower:FindFirstChild("Lush Tower")
    local bitsFolder = lushTower and lushTower:FindFirstChild("Bits")
    if not bitsFolder then
        warn("Collect Bits: Bits folder not found in workspace.Towers.Lush Tower!")
        return nil
    end
    local nearestBit = nil
    local minDistance = math.huge
    for _, model in pairs(bitsFolder:GetChildren()) do
        if model:IsA("Model") then
            local bitPart = model:FindFirstChild("Bit")
            if bitPart and bitPart:IsA("BasePart") then
                local distance = (humanoidRootPart.Position - bitPart.Position).Magnitude
                if distance < minDistance then
                    minDistance = distance
                    nearestBit = bitPart
                end
            end
        end
    end
    return nearestBit
end

local function collectBits()
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not (humanoid and humanoidRootPart) then
        warn("Collect Bits: No character or humanoid found!")
        collectBitsEnabled = false
        return
    end
    local originalSpeed = humanoid.WalkSpeed
    local originalJump = humanoid.JumpPower
    humanoid.WalkSpeed = 16
    humanoid.JumpPower = 50
    while collectBitsEnabled do
        local bitPart = getNearestBit()
        if bitPart then
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local goal = { CFrame = bitPart.CFrame + Vector3.new(0, 2, 0) }
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
            tween:Play()
            tween.Completed:Wait()
        else
            wait(0.1)
        end
    end
    humanoid.WalkSpeed = originalSpeed
    humanoid.JumpPower = originalJump
end

AutoTab:Toggle({
    Title = "Collect all bits (lush tower)",
    Callback = function(state)
        collectBitsEnabled = state
        if state then
            task.spawn(collectBits)
        else
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
            end
        end
    end
})

-- End Lush Tower
AutoTab:Button({
    Title = "End lush tower",
    Callback = function()
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not (humanoid and humanoidRootPart) then
            warn("End Lush Tower: No character or humanoid found!")
            return
        end
        local tower = workspace:FindFirstChild("Towers")
        local lushTower = tower and tower:FindFirstChild("Lush Tower")
        local stud = lushTower and lushTower:FindFirstChild("Stud")
        if not stud then
            warn("End Lush Tower: Stud not found in workspace.Towers.Lush Tower!")
            return
        end
        if not stud:IsA("BasePart") then
            warn("End Lush Tower: Stud is not a BasePart!")
            return
        end
        local originalSpeed = humanoid.WalkSpeed
        local originalJump = humanoid.JumpPower
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
        local goal = { CFrame = stud.CFrame + Vector3.new(0, 3, 0) }
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
        tween.Completed:Wait()
        humanoid.WalkSpeed = originalSpeed
        humanoid.JumpPower = originalJump
    end
})

-- Delete Stops (Lush Tower)
AutoTab:Button({
    Title = "Delete stops (lush tower)",
    Callback = function()
        local tower = workspace:FindFirstChild("Towers")
        local lushTower = tower and tower:FindFirstChild("Lush Tower")
        local clientObjects = lushTower and lushTower:FindFirstChild("ClientObjects")
        local resetables = clientObjects and clientObjects:FindFirstChild("Resetables")
        local powerUps = resetables and resetables:FindFirstChild("PowerUps")
        local faster = powerUps and powerUps:FindFirstChild("Faster")
        local stopsFolder = faster and faster:FindFirstChild("Stops")
        if not stopsFolder then
            warn("Delete Stops: Stops folder not found in workspace.Towers.Lush Tower.ClientObjects.Resetables.PowerUps.Faster!")
            return
        end
        for _, part in pairs(stopsFolder:GetChildren()) do
            if part:IsA("BasePart") then
                part:Destroy()
            end
        end
    end
})

-- Helper Tab
local HelperTab = Window:Tab({
    Title = "Helper",
    Icon = "heart"
})

HelperTab:Section({ 
    Title = "Utility Features",
    TextSize = 30,
    TextXAlignment = "Center"
})

-- Enable Air Jump
local airJumpEnabled = false
local function enableAirJump()
    UserInputService.JumpRequest:Connect(function()
        if airJumpEnabled then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end

HelperTab:Toggle({
    Title = "Enable air jump",
    Callback = function(state)
        airJumpEnabled = state
        if state then
            enableAirJump()
        end
    end
})

-- Non-Killable Mode
local nonKillableEnabled = false
local function nonKillableMode()
    while nonKillableEnabled do
        local characterService = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CharacterService")
        local damageFunction = characterService:WaitForChild("RF"):WaitForChild("Damage")
        local args = { -100 }
        damageFunction:InvokeServer(unpack(args))
        wait(1)
    end
end

HelperTab:Toggle({
    Title = "Non-killable mode",
    Callback = function(state)
        nonKillableEnabled = state
        if state then
            task.spawn(nonKillableMode)
        end
    end
})

-- Heal (+100 HP)
HelperTab:Button({
    Title = "Heal (+100 HP)",
    Callback = function()
        local characterService = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CharacterService")
        local damageFunction = characterService:WaitForChild("RF"):WaitForChild("Damage")
        local args = { -100 }
        damageFunction:InvokeServer(unpack(args))
    end
})

-- Visual Tab
local VisualTab = Window:Tab({
    Title = "Visual",
    Icon = "eye"
})

VisualTab:Section({ 
    Title = "Visual Enhancements",
    TextSize = 30,
    TextXAlignment = "Center"
})

-- Change Size Everywhere
local sizeChangeEnabled = false
VisualTab:Toggle({
    Title = "Change size everywhere",
    Callback = function(state)
        sizeChangeEnabled = state
        local characterService = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CharacterService")
        if state then
            local scaleDown = characterService:WaitForChild("RF"):WaitForChild("ScaleDownCharacter")
            scaleDown:InvokeServer()
        else
            local resetScale = characterService:WaitForChild("RF"):WaitForChild("ResetCharacterScale")
            resetScale:InvokeServer()
        end
    end
})

-- ESP Bits (Lush Tower)
local espBitsEnabled = false
local function updateBitsESP()
    while espBitsEnabled do
        local tower = workspace:FindFirstChild("Towers")
        local lushTower = tower and tower:FindFirstChild("Lush Tower")
        local bitsFolder = lushTower and lushTower:FindFirstChild("Bits")
        if not bitsFolder then
            warn("ESP Bits: Bits folder not found in workspace.Towers.Lush Tower!")
            espBitsEnabled = false
            break
        end
        local count = 0
        for _, model in pairs(bitsFolder:GetChildren()) do
            if espBitsEnabled and model:IsA("Model") and count < 50 then
                local highlight = model:FindFirstChildOfClass("Highlight")
                if not highlight then
                    highlight = Instance.new("Highlight", model)
                end
                if model.Name == "1" then
                    highlight.FillColor = Color3.fromRGB(255, 0, 128) -- Light red
                    highlight.OutlineColor = Color3.fromRGB(200, 0, 100)
                elseif model.Name == "5" then
                    highlight.FillColor = Color3.fromRGB(0, 128, 255) -- Blue
                    highlight.OutlineColor = Color3.fromRGB(0, 100, 200)
                elseif model.Name == "25" then
                    highlight.FillColor = Color3.fromRGB(255, 182, 193) -- Light pink-purple
                    highlight.OutlineColor = Color3.fromRGB(200, 150, 150)
                elseif model.Name == "100" then
                    highlight.FillColor = Color3.fromRGB(128, 0, 128) -- Dark purple
                    highlight.OutlineColor = Color3.fromRGB(100, 0, 100)
                end
                count = count + 1
                wait(0.1)
            end
        end
        wait(3)
    end
    local bitsFolder = workspace:FindFirstChild("Towers") and workspace.Towers:FindFirstChild("Lush Tower") and workspace.Towers["Lush Tower"]:FindFirstChild("Bits")
    if bitsFolder then
        for _, model in pairs(bitsFolder:GetChildren()) do
            local highlight = model:FindFirstChildOfClass("Highlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
end

VisualTab:Toggle({
    Title = "ESP bits (lush tower)",
    Callback = function(state)
        espBitsEnabled = state
        if state then
            task.spawn(updateBitsESP)
        end
    end
})

wait(5)
WindUI:Notify({
    Title = "Discord copied to clipboard!",
    Content = "Thank you",
    Duration = 5
})

setclipboard("https://discord.gg/5g3h6HB6kK")
