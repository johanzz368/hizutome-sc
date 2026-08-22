-- HIZUTOME // MINIWAR AUTO FARM - SECURE EDITION
-- Build: Xeno Stable + Anti-Detection + UI Guaranteed
-- Version: 8.0 SECURE

-- ==================== SERVICES ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- ==================== SCRIPT IDENTITY ====================
local SCRIPT_ID = "HZ_" .. string.format("%08x", math.random(0, 0xFFFFFFFF))
local SCRIPT_VERSION = "8.0"
local SCRIPT_BUILD = "SECURE"
local SESSION_START = tick()
local RANDOM_KEY = tostring(math.random(10000000, 99999999))

-- ==================== MEMORY PROTECTION ====================
local MEMORY_KEY = "HZM_" .. tostring(math.random(99999999, 999999999))

_G[MEMORY_KEY] = {
    Created = tick(),
    ScriptID = SCRIPT_ID,
    Version = SCRIPT_VERSION,
    Protected = true,
    LastAction = tick(),
    ActionCount = 0,
    ItemsCollected = 0,
    ItemsSold = 0,
    AFKMoves = 0,
    LastPosition = nil,
    LastCheck = tick()
}

-- ==================== SECURE PRINT ====================
local function SecurePrint(msg)
    local timestamp = os.date("%H:%M:%S")
    pcall(function()
        print(string.format("[%s] [%s] %s", SCRIPT_ID:sub(1, 8), timestamp, tostring(msg)))
    end)
end

-- ==================== RATE LIMITER ====================
local RateLimit = {
    LastReset = tick(),
    Count = 0,
    MaxPerMinute = 20,
    MinInterval = 0.5
}

local function CanPerformAction()
    local currentTime = tick()
    
    -- Reset setiap 60 detik
    if currentTime - RateLimit.LastReset > 60 then
        RateLimit.LastReset = currentTime
        RateLimit.Count = 0
    end
    
    -- Cek interval minimum
    if _G[MEMORY_KEY] and _G[MEMORY_KEY].LastAction then
        if currentTime - _G[MEMORY_KEY].LastAction < RateLimit.MinInterval then
            return false
        end
    end
    
    -- Cek maksimum per menit
    if RateLimit.Count >= RateLimit.MaxPerMinute then
        return false
    end
    
    RateLimit.Count = RateLimit.Count + 1
    _G[MEMORY_KEY].LastAction = currentTime
    return true
end

-- ==================== HUMANIZER ====================
local function HumanizeHumanoid(humanoid)
    if not humanoid then return end
    
    pcall(function()
        humanoid.WalkSpeed = 14 + math.random() * 3
        humanoid.JumpPower = 45 + math.random() * 7
    end)
end

local function SimulateHumanInput()
    pcall(function()
        local keys = {"W", "A", "S", "D"}
        local key = keys[math.random(1, 4)]
        local holdTime = 0.1 + math.random() * 0.3
        
        VirtualInputManager:SendKeyEvent(true, key, false, nil)
        task.wait(holdTime)
        VirtualInputManager:SendKeyEvent(false, key, false, nil)
    end)
end

-- ==================== DETECTION PROTECTION ====================
local function CheckPositionSafety()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        -- Cek jatuh dari map
        if rootPart.Position.Y < -100 then
            rootPart.CFrame = CFrame.new(rootPart.Position.X, 10, rootPart.Position.Z)
            SecurePrint("WARNING: Fell through map, reset position")
        end
        
        -- Cek terlalu tinggi
        if rootPart.Position.Y > 2000 then
            rootPart.CFrame = CFrame.new(rootPart.Position.X, 50, rootPart.Position.Z)
            SecurePrint("WARNING: Too high, reset position")
        end
        
        -- Cek teleport tiba-tiba
        if _G[MEMORY_KEY].LastPosition then
            local distance = (rootPart.Position - _G[MEMORY_KEY].LastPosition).Magnitude
            if distance > 200 then
                SecurePrint("WARNING: Large movement: " .. math.floor(distance) .. " studs")
            end
        end
        _G[MEMORY_KEY].LastPosition = rootPart.Position
    end)
end

local function CheckSpeedSafety()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.WalkSpeed > 30 then
            humanoid.WalkSpeed = 16
            SecurePrint("WARNING: Speed too high, reset")
        end
    end)
end

local function CheckVelocitySafety()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart and rootPart.Velocity.Magnitude > 200 then
            rootPart.Velocity = Vector3.new(0, 0, 0)
            SecurePrint("WARNING: Velocity too high, reset")
        end
    end)
end

local function RunSafetyChecks()
    CheckPositionSafety()
    CheckSpeedSafety()
    CheckVelocitySafety()
end

-- ==================== UI SYSTEM - DIBUAT PERTAMA ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HizutomeUI"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 150, 255)
MainFrame.Active = true
MainFrame.Draggable = true

local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
TitleBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.Size = UDim2.new(1, -35, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(50, 180, 255)
Title.Text = "HIZUTOME // SECURE v" .. SCRIPT_VERSION
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 0, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 12
CloseButton.BorderSizePixel = 0

local StartButton = Instance.new("TextButton")
StartButton.Parent = MainFrame
StartButton.Size = UDim2.new(1, -20, 0, 35)
StartButton.Position = UDim2.new(0, 10, 0, 45)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.Text = "START"
StartButton.Font = Enum.Font.GothamBold
StartButton.TextSize = 13
StartButton.BorderSizePixel = 0

local CollectButton = Instance.new("TextButton")
CollectButton.Parent = MainFrame
CollectButton.Size = UDim2.new(1, -20, 0, 30)
CollectButton.Position = UDim2.new(0, 10, 0, 90)
CollectButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
CollectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectButton.Text = "AUTO COLLECT: ON"
CollectButton.Font = Enum.Font.Gotham
CollectButton.TextSize = 11
CollectButton.BorderSizePixel = 0

local SellButton = Instance.new("TextButton")
SellButton.Parent = MainFrame
SellButton.Size = UDim2.new(1, -20, 0, 30)
SellButton.Position = UDim2.new(0, 10, 0, 130)
SellButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
SellButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SellButton.Text = "AUTO SELL: ON"
SellButton.Font = Enum.Font.Gotham
SellButton.TextSize = 11
SellButton.BorderSizePixel = 0

local AFKButton = Instance.new("TextButton")
AFKButton.Parent = MainFrame
AFKButton.Size = UDim2.new(1, -20, 0, 30)
AFKButton.Position = UDim2.new(0, 10, 0, 170)
AFKButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
AFKButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AFKButton.Text = "ANTI AFK: ON"
AFKButton.Font = Enum.Font.Gotham
AFKButton.TextSize = 11
AFKButton.BorderSizePixel = 0

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 210)
StatusLabel.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
StatusLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
StatusLabel.Text = "STATUS: READY"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.BorderSizePixel = 0

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Parent = MainFrame
StatsLabel.Size = UDim2.new(1, -20, 0, 50)
StatsLabel.Position = UDim2.new(0, 10, 0, 250)
StatsLabel.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
StatsLabel.TextColor3 = Color3.fromRGB(150, 170, 200)
StatsLabel.Text = "Collected: 0\nSold: 0\nAFK Moves: 0"
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.TextSize = 10
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.BorderSizePixel = 0

local SecurityLabel = Instance.new("TextLabel")
SecurityLabel.Parent = MainFrame
SecurityLabel.Size = UDim2.new(1, -20, 0, 30)
SecurityLabel.Position = UDim2.new(0, 10, 0, 310)
SecurityLabel.BackgroundTransparency = 1
SecurityLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
SecurityLabel.Text = "SECURITY: ACTIVE"
SecurityLabel.Font = Enum.Font.GothamBold
SecurityLabel.TextSize = 10

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = MainFrame
InfoLabel.Size = UDim2.new(1, -20, 0, 80)
InfoLabel.Position = UDim2.new(0, 10, 0, 340)
InfoLabel.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
InfoLabel.TextColor3 = Color3.fromRGB(100, 120, 150)
InfoLabel.Text = "F6 - Start/Stop\nF7 - Collect Toggle\nF8 - Sell Toggle\nF9 - Anti AFK Toggle\nRightCtrl - Hide UI"
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 9
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.BorderSizePixel = 0

SecurePrint("UI CREATED - VISIBLE")

-- ==================== STATE ====================
local isRunning = false
local collectEnabled = true
local sellEnabled = true
local antiAFKEnabled = true
local currentDelay = 0.3
local uiVisible = true

-- ==================== REMOTE SCAN ====================
local RemoteEvents = {
    Collect = {},
    Sell = {},
    Interact = {}
}

local function ScanRemotes()
    pcall(function()
        for _, item in pairs(ReplicatedStorage:GetDescendants()) do
            if item:IsA("RemoteEvent") then
                local name = item.Name:lower()
                
                if name:find("collect") or name:find("pickup") or name:find("gather") or name:find("take") then
                    table.insert(RemoteEvents.Collect, item)
                    SecurePrint("Collect remote: " .. item.Name)
                end
                
                if name:find("sell") or name:find("shop") or name:find("trade") or name:find("exchange") then
                    table.insert(RemoteEvents.Sell, item)
                    SecurePrint("Sell remote: " .. item.Name)
                end
                
                if name:find("interact") or name:find("use") or name:find("click") or name:find("activate") then
                    table.insert(RemoteEvents.Interact, item)
                    SecurePrint("Interact remote: " .. item.Name)
                end
            end
        end
    end)
    
    pcall(function()
        if LocalPlayer.PlayerGui then
            for _, item in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                if item:IsA("RemoteEvent") then
                    local name = item.Name:lower()
                    
                    if name:find("collect") or name:find("pickup") then
                        table.insert(RemoteEvents.Collect, item)
                    end
                    
                    if name:find("sell") or name:find("shop") then
                        table.insert(RemoteEvents.Sell, item)
                    end
                end
            end
        end
    end)
    
    StatusLabel.Text = string.format("STATUS: %d collect | %d sell | %d interact", 
        #RemoteEvents.Collect, #RemoteEvents.Sell, #RemoteEvents.Interact)
end

-- ==================== OBJECT DETECTION ====================
local CollectibleNames = {
    "coin", "coins", "gem", "gems", "ore", "ores",
    "collect", "collectible", "item", "items", "loot",
    "gold", "diamond", "crystal", "resource", "resources",
    "money", "cash", "point", "points", "star", "stars",
    "chest", "box", "drop", "drops", "pickup", "pickups",
    "mineral", "minerals", "rock", "rocks"
}

local SellZoneNames = {
    "sell", "shop", "merchant", "vendor", "market",
    "trade", "trader", "store", "buy", "exchange",
    "base", "spawn", "safe", "hub", "npc"
}

local function IsCollectible(item)
    local name = item.Name:lower()
    
    for _, keyword in pairs(CollectibleNames) do
        if name:find(keyword) then
            return true
        end
    end
    
    if item.Parent then
        local parentName = item.Parent.Name:lower()
        for _, keyword in pairs(CollectibleNames) do
            if parentName:find(keyword) then
                return true
            end
        end
    end
    
    return false
end

local function IsSellZone(part)
    local name = part.Name:lower()
    
    for _, keyword in pairs(SellZoneNames) do
        if name:find(keyword) then
            return true
        end
    end
    
    if part.Parent then
        local parentName = part.Parent.Name:lower()
        for _, keyword in pairs(SellZoneNames) do
            if parentName:find(keyword) then
                return true
            end
        end
    end
    
    return false
end

local function FindNearestCollectible()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    
    local nearest = nil
    local nearestDistance = 100
    
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("BasePart") and IsCollectible(item) then
            local isPlayerPart = false
            local parent = item.Parent
            
            while parent do
                if parent:IsA("Model") and Players:GetPlayerFromCharacter(parent) then
                    isPlayerPart = true
                    break
                end
                parent = parent.Parent
            end
            
            if not isPlayerPart then
                local distance = (rootPart.Position - item.Position).Magnitude
                if distance < nearestDistance then
                    nearest = item
                    nearestDistance = distance
                end
            end
        end
    end
    
    return nearest
end

local function FindSellZone()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    
    local sellZone = nil
    local sellDistance = 50
    
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and IsSellZone(part) then
            local distance = (rootPart.Position - part.Position).Magnitude
            if distance < sellDistance then
                sellZone = part
                sellDistance = distance
            end
        end
    end
    
    return sellZone
end

-- ==================== CORE FUNCTIONS ====================
local function FireRemoteSafely(remoteList, ...)
    local args = {...}
    local fired = false
    
    for _, remote in pairs(remoteList) do
        if CanPerformAction() then
            pcall(function()
                remote:FireServer(unpack(args))
                fired = true
            end)
        end
        
        if fired then break end
    end
    
    return fired
end

local function AutoCollect()
    if not isRunning or not collectEnabled then return end
    
    local nearest = FindNearestCollectible()
    if not nearest then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    HumanizeHumanoid(humanoid)
    humanoid:MoveTo(nearest.Position)
    task.wait(currentDelay)
    
    RunSafetyChecks()
    SimulateHumanInput()
    
    local fired = FireRemoteSafely(RemoteEvents.Collect, nearest)
    
    if not fired then
        fired = FireRemoteSafely(RemoteEvents.Interact, nearest)
    end
    
    if not fired then
        pcall(function()
            rootPart.CFrame = nearest.CFrame * CFrame.new(0, 2, 0)
        end)
    end
    
    _G[MEMORY_KEY].ItemsCollected = (_G[MEMORY_KEY].ItemsCollected or 0) + 1
    StatusLabel.Text = "STATUS: COLLECTING"
end

local function AutoSell()
    if not isRunning or not sellEnabled then return end
    
    local sellZone = FindSellZone()
    if not sellZone then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    HumanizeHumanoid(humanoid)
    humanoid:MoveTo(sellZone.Position)
    task.wait(currentDelay)
    
    RunSafetyChecks()
    
    local fired = FireRemoteSafely(RemoteEvents.Sell)
    
    if not fired then
        fired = FireRemoteSafely(RemoteEvents.Interact, sellZone)
    end
    
    if not fired then
        pcall(function()
            rootPart.CFrame = sellZone.CFrame * CFrame.new(0, 2, 0)
        end)
    end
    
    _G[MEMORY_KEY].ItemsSold = (_G[MEMORY_KEY].ItemsSold or 0) + 1
    StatusLabel.Text = "STATUS: SELLING"
end

local function MainLoop()
    while isRunning do
        if collectEnabled then
            task.spawn(AutoCollect)
        end
        
        task.wait(currentDelay)
        
        if sellEnabled then
            task.spawn(AutoSell)
        end
        
        task.wait(currentDelay)
        
        RunSafetyChecks()
    end
end

-- ==================== ANTI AFK ====================
local nextAFKTime = tick() + 900

local function AntiAFKMove()
    if not antiAFKEnabled then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    local angle = math.random() * math.pi * 2
    local distance = 5 + math.random() * 3
    local targetPosition = rootPart.Position + Vector3.new(math.cos(angle) * distance, 0, math.sin(angle) * distance)
    
    HumanizeHumanoid(humanoid)
    SimulateHumanInput()
    humanoid:MoveTo(targetPosition)
    
    task.wait(3)
    
    RunSafetyChecks()
    humanoid:MoveTo(rootPart.Position)
    
    _G[MEMORY_KEY].AFKMoves = (_G[MEMORY_KEY].AFKMoves or 0) + 1
    SecurePrint("Anti AFK: Moved " .. math.floor(distance) .. " studs")
end

local function AntiAFKLoop()
    while antiAFKEnabled do
        local waitTime = nextAFKTime - tick()
        
        if waitTime <= 0 then
            AntiAFKMove()
            nextAFKTime = tick() + 900
        else
            task.wait(math.min(waitTime, 1))
        end
    end
end

-- ==================== STATS UPDATER ====================
task.spawn(function()
    while true do
        task.wait(1)
        
        pcall(function()
            if _G[MEMORY_KEY] then
                StatsLabel.Text = string.format(
                    "Collected: %d\nSold: %d\nAFK Moves: %d",
                    _G[MEMORY_KEY].ItemsCollected or 0,
                    _G[MEMORY_KEY].ItemsSold or 0,
                    _G[MEMORY_KEY].AFKMoves or 0
                )
            end
        end)
    end
end)

-- ==================== PERIODIC SAFETY CHECK ====================
task.spawn(function()
    while true do
        task.wait(30)
        
        RunSafetyChecks()
        SecurePrint("Periodic safety check complete")
    end
end)

-- ==================== BUTTON FUNCTIONS ====================
StartButton.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    
    if isRunning then
        StartButton.Text = "STOP"
        StartButton.BackgroundColor3 = Color3.fromRGB(180, 0, 40)
        StatusLabel.Text = "STATUS: RUNNING"
        task.spawn(MainLoop)
    else
        StartButton.Text = "START"
        StartButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        StatusLabel.Text = "STATUS: STOPPED"
    end
end)

CollectButton.MouseButton1Click:Connect(function()
    collectEnabled = not collectEnabled
    
    if collectEnabled then
        CollectButton.Text = "AUTO COLLECT: ON"
        CollectButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    else
        CollectButton.Text = "AUTO COLLECT: OFF"
        CollectButton.BackgroundColor3 = Color3.fromRGB(40, 55, 80)
    end
end)

SellButton.MouseButton1Click:Connect(function()
    sellEnabled = not sellEnabled
    
    if sellEnabled then
        SellButton.Text = "AUTO SELL: ON"
        SellButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    else
        SellButton.Text = "AUTO SELL: OFF"
        SellButton.BackgroundColor3 = Color3.fromRGB(40, 55, 80)
    end
end)

AFKButton.MouseButton1Click:Connect(function()
    antiAFKEnabled = not antiAFKEnabled
    
    if antiAFKEnabled then
        AFKButton.Text = "ANTI AFK: ON"
        AFKButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        nextAFKTime = tick() + 900
        task.spawn(AntiAFKLoop)
    else
        AFKButton.Text = "ANTI AFK: OFF"
        AFKButton.BackgroundColor3 = Color3.fromRGB(40, 55, 80)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    uiVisible = false
    MainFrame.Visible = false
end)

-- ==================== KEYBINDS ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.F6 then
            isRunning = not isRunning
            
            if isRunning then
                StartButton.Text = "STOP"
                StartButton.BackgroundColor3 = Color3.fromRGB(180, 0, 40)
                StatusLabel.Text = "STATUS: RUNNING"
                task.spawn(MainLoop)
            else
                StartButton.Text = "START"
                StartButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                StatusLabel.Text = "STATUS: STOPPED"
            end
            
            SecurePrint("Main: " .. (isRunning and "ON" or "OFF"))
            
        elseif input.KeyCode == Enum.KeyCode.F7 then
            collectEnabled = not collectEnabled
            CollectButton.Text = collectEnabled and "AUTO COLLECT: ON" or "AUTO COLLECT: OFF"
            CollectButton.BackgroundColor3 = collectEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(40, 55, 80)
            SecurePrint("Collect: " .. (collectEnabled and "ON" or "OFF"))
            
        elseif input.KeyCode == Enum.KeyCode.F8 then
            sellEnabled = not sellEnabled
            SellButton.Text = sellEnabled and "AUTO SELL: ON" or "AUTO SELL: OFF"
            SellButton.BackgroundColor3 = sellEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(40, 55, 80)
            SecurePrint("Sell: " .. (sellEnabled and "ON" or "OFF"))
            
        elseif input.KeyCode == Enum.KeyCode.F9 then
            antiAFKEnabled = not antiAFKEnabled
            AFKButton.Text = antiAFKEnabled and "ANTI AFK: ON" or "ANTI AFK: OFF"
            AFKButton.BackgroundColor3 = antiAFKEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(40, 55, 80)
            
            if antiAFKEnabled then
                nextAFKTime = tick() + 900
                task.spawn(AntiAFKLoop)
            end
            
            SecurePrint("Anti AFK: " .. (antiAFKEnabled and "ON" or "OFF"))
            
        elseif input.KeyCode == Enum.KeyCode.RightControl then
            uiVisible = not uiVisible
            MainFrame.Visible = uiVisible
        end
    end
end)

-- ==================== INITIALIZATION ====================
SecurePrint("========================================")
SecurePrint("HIZUTOME // SECURE EDITION")
SecurePrint("Version: " .. SCRIPT_VERSION)
SecurePrint("Build: " .. SCRIPT_BUILD)
SecurePrint("Session: " .. SCRIPT_ID)
SecurePrint("========================================")

ScanRemotes()
task.spawn(AntiAFKLoop)
RunSafetyChecks()

SecurePrint("Script loaded successfully")
SecurePrint("Security systems active")
SecurePrint("========================================")
