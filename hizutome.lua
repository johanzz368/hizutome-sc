-- HIZUTOME // MINIWAR AUTO FARM - 1000 LINE STABLE
-- Build: Xeno Optimized, 1000+ Lines Protection
-- Version: 6.0 MEGA

-- ==================== SERVICES ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- ==================== SCRIPT IDENTITY ====================
local SCRIPT_NAME = "HIZUTOME"
local SCRIPT_VERSION = "6.0"
local SCRIPT_BUILD = "MEGA-1000"
local SCRIPT_ID = "HZ_" .. string.format("%08x", math.random(0, 0xFFFFFFFF))
local EXECUTION_TIME = tick()
local RANDOM_SEED = math.random(100000, 999999)
local ENCRYPTION_KEY = tostring(math.random(10000000, 99999999))

-- ==================== MEMORY PROTECTION ====================
local MEMORY_KEY = "HZM_" .. tostring(math.random(99999999, 999999999))

_G[MEMORY_KEY] = {
    Created = tick(),
    ScriptID = SCRIPT_ID,
    Version = SCRIPT_VERSION,
    Protected = true,
    SessionData = {
        ItemsCollected = 0,
        ItemsSold = 0,
        AFKMoves = 0,
        RemoteFires = 0,
        StartTime = EXECUTION_TIME,
        LastCheck = tick()
    },
    Settings = {
        AutoCollect = true,
        AutoSell = true,
        AntiAFK = true,
        Delay = 0.3,
        CollectRadius = 100,
        SellRadius = 50
    }
}

-- ==================== SECURE LOGGING ====================
local LogQueue = {}
local MaxLogEntries = 500

local function SecurePrint(message)
    local timestamp = os.date("%H:%M:%S")
    local formatted = string.format("[%s] [%s] %s", SCRIPT_ID:sub(1, 8), timestamp, tostring(message))
    
    pcall(function()
        print(formatted)
    end)
    
    -- Simpan ke memory
    pcall(function()
        if _G[MEMORY_KEY] then
            table.insert(LogQueue, {
                Time = os.time(),
                Message = tostring(message),
                Session = SCRIPT_ID
            })
            
            -- Batasi log
            if #LogQueue > MaxLogEntries then
                table.remove(LogQueue, 1)
            end
            
            _G[MEMORY_KEY].LastLog = formatted
        end
    end)
end

-- ==================== RATE LIMITER ====================
local RateLimiter = {
    LastAction = tick(),
    ActionCount = 0,
    MaxActions = 20,
    Window = 60
}

local function CheckRateLimit()
    local currentTime = tick()
    local timeDiff = currentTime - RateLimiter.LastAction
    
    if timeDiff > RateLimiter.Window then
        RateLimiter.ActionCount = 0
        RateLimiter.LastAction = currentTime
        return true
    end
    
    if RateLimiter.ActionCount >= RateLimiter.MaxActions then
        return false
    end
    
    RateLimiter.ActionCount = RateLimiter.ActionCount + 1
    return true
end

local function ResetRateLimiter()
    RateLimiter.LastAction = tick()
    RateLimiter.ActionCount = 0
end

-- ==================== HUMANIZER ====================
local Humanizer = {
    Enabled = true,
    WalkSpeedMin = 13,
    WalkSpeedMax = 17,
    JumpPowerMin = 42,
    JumpPowerMax = 52,
    MovementVariance = 0.3,
    ClickVariance = 0.2
}

local function HumanizeHumanoid(humanoid)
    if not Humanizer.Enabled or not humanoid then return end
    
    pcall(function()
        local speed = Humanizer.WalkSpeedMin + math.random() * (Humanizer.WalkSpeedMax - Humanizer.WalkSpeedMin)
        local jump = Humanizer.JumpPowerMin + math.random() * (Humanizer.JumpPowerMax - Humanizer.JumpPowerMin)
        
        humanoid.WalkSpeed = speed
        humanoid.JumpPower = jump
    end)
end

local function GenerateMovementPattern()
    local patterns = {
        {"W"}, {"A"}, {"S"}, {"D"},
        {"W", "A"}, {"W", "D"}, {"S", "A"}, {"S", "D"},
        {"W", "W"}, {"S", "S"}, {"A", "A"}, {"D", "D"},
        {"W", "A", "W"}, {"D", "S", "D"}, {"A", "W", "A"}, {"S", "D", "S"},
        {"W", "W", "A"}, {"S", "S", "D"}, {"D", "D", "W"}, {"A", "A", "S"}
    }
    
    return patterns[math.random(1, #patterns)]
end

local function SimulateHumanMovement()
    pcall(function()
        local pattern = GenerateMovementPattern()
        local holdTime = 0.1 + math.random() * 0.3
        
        for _, key in ipairs(pattern) do
            VirtualInputManager:SendKeyEvent(true, key, false, nil)
            task.wait(0.05 + math.random() * 0.1)
        end
        
        task.wait(holdTime)
        
        for i = #pattern, 1, -1 do
            VirtualInputManager:SendKeyEvent(false, pattern[i], false, nil)
            task.wait(0.02 + math.random() * 0.05)
        end
    end)
end

-- ==================== ANTI-DETECTION ====================
local DetectionProtection = {
    TeleportCheck = true,
    VelocityCheck = true,
    GravityCheck = true,
    PositionCheck = true,
    SpeedCheck = true,
    JumpCheck = true,
    NoclipCheck = true,
    FlyCheck = true
}

local function CheckTeleportDetection()
    if not DetectionProtection.TeleportCheck then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                if _G[MEMORY_KEY] and _G[MEMORY_KEY].LastPosition then
                    local distance = (rootPart.Position - _G[MEMORY_KEY].LastPosition).Magnitude
                    if distance > 100 then
                        SecurePrint("WARNING: Large movement detected: " .. math.floor(distance) .. " studs")
                    end
                end
                _G[MEMORY_KEY].LastPosition = rootPart.Position
            end
        end
    end)
end

local function CheckVelocityDetection()
    if not DetectionProtection.VelocityCheck then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart.Velocity.Magnitude > 150 then
                rootPart.Velocity = Vector3.new(0, 0, 0)
                SecurePrint("WARNING: Velocity exceeded limit, reset")
            end
        end
    end)
end

local function CheckGravityDetection()
    if not DetectionProtection.GravityCheck then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart.Position.Y < -100 then
                rootPart.CFrame = CFrame.new(rootPart.Position.X, 10, rootPart.Position.Z)
                SecurePrint("WARNING: Fell through map, teleported to safety")
            end
        end
    end)
end

local function CheckPositionDetection()
    if not DetectionProtection.PositionCheck then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart.Position.Y > 2000 then
                rootPart.CFrame = CFrame.new(rootPart.Position.X, 50, rootPart.Position.Z)
                SecurePrint("WARNING: Unusual height detected")
            end
        end
    end)
end

local function CheckSpeedDetection()
    if not DetectionProtection.SpeedCheck then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed > 50 then
                humanoid.WalkSpeed = 16
                SecurePrint("WARNING: Speed hack detected, reset")
            end
        end
    end)
end

local function CheckJumpDetection()
    if not DetectionProtection.JumpCheck then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.JumpPower > 100 then
                humanoid.JumpPower = 50
                SecurePrint("WARNING: Jump hack detected, reset")
            end
        end
    end)
end

local function CheckNoclipDetection()
    if not DetectionProtection.NoclipCheck then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart.CanCollide == false then
                rootPart.CanCollide = true
                SecurePrint("WARNING: Noclip detected, reset")
            end
        end
    end)
end

local function CheckFlyDetection()
    if not DetectionProtection.FlyCheck then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart.Position.Y > 100 and rootPart.Velocity.Y == 0 then
                SecurePrint("WARNING: Fly hack detected")
            end
        end
    end)
end

local function RunAllDetectionChecks()
    CheckTeleportDetection()
    CheckVelocityDetection()
    CheckGravityDetection()
    CheckPositionDetection()
    CheckSpeedDetection()
    CheckJumpDetection()
    CheckNoclipDetection()
    CheckFlyDetection()
end

-- ==================== AUTO-DETECT SYSTEM ====================
local RemoteEvents = {
    Collect = {},
    Sell = {},
    Interact = {},
    Touch = {},
    Proximity = {},
    Action = {},
    Use = {},
    Click = {},
    Activate = {},
    Pickup = {}
}

local function AddRemoteToList(list, remote, label)
    if remote and remote:IsA("RemoteEvent") then
        table.insert(list, remote)
        SecurePrint(label .. " detected: " .. remote.Name)
        return true
    end
    return false
end

local function ScanReplicatedStorage()
    local count = 0
    
    pcall(function()
        for _, item in pairs(ReplicatedStorage:GetDescendants()) do
            if item:IsA("RemoteEvent") then
                count = count + 1
                local name = item.Name:lower()
                
                if name:find("collect") or name:find("pickup") or name:find("gather") or name:find("take") or name:find("getitem") or name:find("farm") then
                    AddRemoteToList(RemoteEvents.Collect, item, "Collect")
                    AddRemoteToList(RemoteEvents.Pickup, item, "Pickup")
                end
                
                if name:find("sell") or name:find("shop") or name:find("trade") or name:find("exchange") or name:find("vendor") or name:find("merchant") then
                    AddRemoteToList(RemoteEvents.Sell, item, "Sell")
                end
                
                if name:find("interact") or name:find("interaction") then
                    AddRemoteToList(RemoteEvents.Interact, item, "Interact")
                end
                
                if name:find("touch") or name:find("hit") or name:find("contact") then
                    AddRemoteToList(RemoteEvents.Touch, item, "Touch")
                end
                
                if name:find("proximity") or name:find("near") or name:find("close") then
                    AddRemoteToList(RemoteEvents.Proximity, item, "Proximity")
                end
                
                if name:find("action") or name:find("perform") or name:find("execute") then
                    AddRemoteToList(RemoteEvents.Action, item, "Action")
                end
                
                if name:find("use") or name:find("utilize") then
                    AddRemoteToList(RemoteEvents.Use, item, "Use")
                end
                
                if name:find("click") or name:find("tap") then
                    AddRemoteToList(RemoteEvents.Click, item, "Click")
                end
                
                if name:find("activate") or name:find("trigger") then
                    AddRemoteToList(RemoteEvents.Activate, item, "Activate")
                end
            end
        end
    end)
    
    return count
end

local function ScanPlayerGui()
    local count = 0
    
    pcall(function()
        if LocalPlayer.PlayerGui then
            for _, item in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                if item:IsA("RemoteEvent") then
                    count = count + 1
                    local name = item.Name:lower()
                    
                    if name:find("collect") or name:find("pickup") then
                        AddRemoteToList(RemoteEvents.Collect, item, "Collect (GUI)")
                    end
                    
                    if name:find("sell") or name:find("shop") then
                        AddRemoteToList(RemoteEvents.Sell, item, "Sell (GUI)")
                    end
                end
            end
        end
    end)
    
    return count
end

local function ScanPlayerScripts()
    local count = 0
    
    pcall(function()
        if LocalPlayer.PlayerScripts then
            for _, item in pairs(LocalPlayer.PlayerScripts:GetDescendants()) do
                if item:IsA("RemoteEvent") then
                    count = count + 1
                    local name = item.Name:lower()
                    
                    if name:find("collect") or name:find("pickup") then
                        AddRemoteToList(RemoteEvents.Collect, item, "Collect (Scripts)")
                    end
                end
            end
        end
    end)
    
    return count
end

local function FullRemoteScan()
    local totalCount = 0
    
    totalCount = totalCount + ScanReplicatedStorage()
    totalCount = totalCount + ScanPlayerGui()
    totalCount = totalCount + ScanPlayerScripts()
    
    SecurePrint("Scan complete: " .. totalCount .. " remotes found")
    SecurePrint("Collect: " .. #RemoteEvents.Collect)
    SecurePrint("Sell: " .. #RemoteEvents.Sell)
    SecurePrint("Interact: " .. #RemoteEvents.Interact)
    SecurePrint("Touch: " .. #RemoteEvents.Touch)
    
    return totalCount
end

-- ==================== OBJECT DETECTION ====================
local CollectibleNames = {
    "coin", "coins", "gem", "gems", "ore", "ores",
    "collect", "collectible", "item", "items", "loot",
    "gold", "diamond", "crystal", "resource", "resources",
    "money", "cash", "point", "points", "star", "stars",
    "chest", "box", "drop", "drops", "pickup", "pickups",
    "mineral", "minerals", "rock", "rocks", "wood", "tree",
    "bar", "bars", "ingot", "ingots", "nugget", "nuggets",
    "shard", "shards", "fragment", "fragments", "piece", "pieces",
    "crystal", "crystals", "jewel", "jewels", "treasure", "treasures"
}

local SellZoneNames = {
    "sell", "shop", "merchant", "vendor", "market",
    "trade", "trader", "store", "buy", "exchange",
    "base", "spawn", "safe", "hub", "npc",
    "counter", "desk", "register", "checkout",
    "sales", "selling", "purchase", "purchasing"
}

local function IsCollectibleObject(item)
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
    
    pcall(function()
        if item:GetAttribute("Collectible") or item:GetAttribute("CanCollect") or item:GetAttribute("IsItem") then
            return true
        end
    end)
    
    return false
end

local function IsSellZoneObject(part)
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
    
    pcall(function()
        if part:GetAttribute("SellZone") or part:GetAttribute("Shop") or part:GetAttribute("CanSell") then
            return true
        end
    end)
    
    return false
end

local function FindNearestCollectible()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    
    local nearest = nil
    local nearestDistance = _G[MEMORY_KEY].Settings.CollectRadius or 100
    
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("BasePart") and IsCollectibleObject(item) then
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
    local sellDistance = _G[MEMORY_KEY].Settings.SellRadius or 50
    
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and IsSellZoneObject(part) then
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
local isRunning = false
local collectEnabled = true
local sellEnabled = true
local antiAFKEnabled = true
local currentDelay = 0.3
local uiVisible = true
local nextAFKTime = tick() + 900

local function FireRemoteSafely(remoteList, ...)
    local args = {...}
    local fired = false
    
    for _, remote in pairs(remoteList) do
        if CheckRateLimit() then
            pcall(function()
                remote:FireServer(unpack(args))
                fired = true
                
                if _G[MEMORY_KEY] then
                    _G[MEMORY_KEY].SessionData.RemoteFires = (_G[MEMORY_KEY].SessionData.RemoteFires or 0) + 1
                end
            end)
        end
        
        if fired then break end
    end
    
    return fired
end

local function AutoCollectFunction()
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
    
    SimulateHumanMovement()
    CheckTeleportDetection()
    CheckVelocityDetection()
    
    local fired = FireRemoteSafely(RemoteEvents.Collect, nearest)
    
    if not fired then
        fired = FireRemoteSafely(RemoteEvents.Interact, nearest)
    end
    
    if not fired then
        fired = FireRemoteSafely(RemoteEvents.Touch, nearest)
    end
    
    if not fired then
        fired = FireRemoteSafely(RemoteEvents.Pickup, nearest)
    end
    
    if not fired then
        pcall(function()
            rootPart.CFrame = nearest.CFrame * CFrame.new(0, 2, 0)
        end)
    end
    
    if _G[MEMORY_KEY] then
        _G[MEMORY_KEY].SessionData.ItemsCollected = (_G[MEMORY_KEY].SessionData.ItemsCollected or 0) + 1
    end
end

local function AutoSellFunction()
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
    
    CheckTeleportDetection()
    CheckVelocityDetection()
    
    local fired = FireRemoteSafely(RemoteEvents.Sell)
    
    if not fired then
        fired = FireRemoteSafely(RemoteEvents.Interact, sellZone)
    end
    
    if not fired then
        pcall(function()
            rootPart.CFrame = sellZone.CFrame * CFrame.new(0, 2, 0)
        end)
    end
    
    if _G[MEMORY_KEY] then
        _G[MEMORY_KEY].SessionData.ItemsSold = (_G[MEMORY_KEY].SessionData.ItemsSold or 0) + 1
    end
end

local function AntiAFKFunction()
    if not antiAFKEnabled then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    local angle = math.random() * math.pi * 2
    local distance = 5 + math.random() * 3
    local offsetX = math.cos(angle) * distance
    local offsetZ = math.sin(angle) * distance
    local targetPosition = rootPart.Position + Vector3.new(offsetX, 0, offsetZ)
    
    HumanizeHumanoid(humanoid)
    SimulateHumanMovement()
    humanoid:MoveTo(targetPosition)
    
    local startTime = tick()
    
    while tick() - startTime < 5 do
        if not rootPart or not rootPart.Parent then break end
        if (rootPart.Position - targetPosition).Magnitude < 2 then break end
        
        CheckTeleportDetection()
        CheckVelocityDetection()
        CheckGravityDetection()
        
        task.wait(0.1)
    end
    
    humanoid:MoveTo(rootPart.Position)
    
    if _G[MEMORY_KEY] then
        _G[MEMORY_KEY].SessionData.AFKMoves = (_G[MEMORY_KEY].SessionData.AFKMoves or 0) + 1
    end
    
    SecurePrint("Anti AFK: Moved " .. math.floor(distance) .. " studs")
end

local function AntiAFKLoop()
    while antiAFKEnabled do
        local waitTime = nextAFKTime - tick()
        
        if waitTime <= 0 then
            AntiAFKFunction()
            nextAFKTime = tick() + 900
        else
            task.wait(math.min(waitTime, 1))
        end
    end
end

local function MainLoop()
    while isRunning do
        if collectEnabled then
            task.spawn(AutoCollectFunction)
        end
        
        task.wait(currentDelay)
        
        if sellEnabled then
            task.spawn(AutoSellFunction)
        end
        
        task.wait(currentDelay)
        
        RunAllDetectionChecks()
    end
end

-- ==================== KEYBINDS ====================
local KEYBINDS = {
    MainToggle = Enum.KeyCode.F6,
    CollectToggle = Enum.KeyCode.F7,
    SellToggle = Enum.KeyCode.F8,
    AntiAFKToggle = Enum.KeyCode.F9,
    UIKey = Enum.KeyCode.RightControl
}

local function GetKeyName(keyCode)
    return tostring(keyCode):gsub("Enum.KeyCode.", "")
end

-- ==================== THEME ====================
local THEME = {
    Background = Color3.fromRGB(10, 15, 30),
    SecondaryBackground = Color3.fromRGB(15, 25, 50),
    Accent = Color3.fromRGB(0, 150, 255),
    AccentDark = Color3.fromRGB(0, 80, 160),
    AccentLight = Color3.fromRGB(50, 180, 255),
    Text = Color3.fromRGB(200, 220, 255),
    TextBright = Color3.fromRGB(255, 255, 255),
    ButtonGreen = Color3.fromRGB(0, 100, 200),
    ButtonRed = Color3.fromRGB(180, 0, 40),
    ButtonGray = Color3.fromRGB(40, 55, 80),
    ButtonOrange = Color3.fromRGB(255, 140, 0),
    Slider = Color3.fromRGB(20, 35, 60),
    SliderFill = Color3.fromRGB(0, 150, 255),
    Border = Color3.fromRGB(0, 120, 220)
}

-- ==================== UI SYSTEM ====================
local function CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = CoreGui
    ScreenGui.Name = "HizutomeUI"
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 320, 0, 450)
    MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
    MainFrame.BackgroundColor3 = THEME.Background
    MainFrame.BorderSizePixel = 1
    MainFrame.BorderColor3 = THEME.Border
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = THEME.SecondaryBackground
    TitleBar.BorderSizePixel = 0
    
    local Title = Instance.new("TextLabel")
    Title.Parent = TitleBar
    Title.Size = UDim2.new(1, -35, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = THEME.AccentLight
    Title.Text = "HIZUTOME // 1000 LINE"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TitleBar
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.BackgroundColor3 = THEME.ButtonRed
    CloseButton.TextColor3 = THEME.TextBright
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 12
    CloseButton.BorderSizePixel = 0
    
    local MainToggle = Instance.new("TextButton")
    MainToggle.Parent = MainFrame
    MainToggle.Size = UDim2.new(1, -20, 0, 35)
    MainToggle.Position = UDim2.new(0, 10, 0, 45)
    MainToggle.BackgroundColor3 = THEME.ButtonGreen
    MainToggle.TextColor3 = THEME.TextBright
    MainToggle.Text = "START"
    MainToggle.Font = Enum.Font.GothamBold
    MainToggle.TextSize = 13
    MainToggle.BorderSizePixel = 0
    
    local CollectToggle = Instance.new("TextButton")
    CollectToggle.Parent = MainFrame
    CollectToggle.Size = UDim2.new(1, -20, 0, 30)
    CollectToggle.Position = UDim2.new(0, 10, 0, 90)
    CollectToggle.BackgroundColor3 = THEME.ButtonGreen
    CollectToggle.TextColor3 = THEME.TextBright
    CollectToggle.Text = "AUTO COLLECT: ON"
    CollectToggle.Font = Enum.Font.Gotham
    CollectToggle.TextSize = 11
    CollectToggle.BorderSizePixel = 0
    
    local SellToggle = Instance.new("TextButton")
    SellToggle.Parent = MainFrame
    SellToggle.Size = UDim2.new(1, -20, 0, 30)
    SellToggle.Position = UDim2.new(0, 10, 0, 130)
    SellToggle.BackgroundColor3 = THEME.ButtonGreen
    SellToggle.TextColor3 = THEME.TextBright
    SellToggle.Text = "AUTO SELL: ON"
    SellToggle.Font = Enum.Font.Gotham
    SellToggle.TextSize = 11
    SellToggle.BorderSizePixel = 0
    
    local AntiAFKToggle = Instance.new("TextButton")
    AntiAFKToggle.Parent = MainFrame
    AntiAFKToggle.Size = UDim2.new(1, -20, 0, 30)
    AntiAFKToggle.Position = UDim2.new(0, 10, 0, 170)
    AntiAFKToggle.BackgroundColor3 = THEME.ButtonGreen
    AntiAFKToggle.TextColor3 = THEME.TextBright
    AntiAFKToggle.Text = "ANTI AFK: ON"
    AntiAFKToggle.Font = Enum.Font.Gotham
    AntiAFKToggle.TextSize = 11
    AntiAFKToggle.BorderSizePixel = 0
    
    local DelayLabel = Instance.new("TextLabel")
    DelayLabel.Parent = MainFrame
    DelayLabel.Size = UDim2.new(1, -20, 0, 20)
    DelayLabel.Position = UDim2.new(0, 10, 0, 210)
    DelayLabel.BackgroundTransparency = 1
    DelayLabel.TextColor3 = THEME.Text
    DelayLabel.Text = "DELAY: 0.3s"
    DelayLabel.Font = Enum.Font.Gotham
    DelayLabel.TextSize = 11
    
    local MinusButton = Instance.new("TextButton")
    MinusButton.Parent = MainFrame
    MinusButton.Size = UDim2.new(0, 35, 0, 25)
    MinusButton.Position = UDim2.new(0, 10, 0, 235)
    MinusButton.BackgroundColor3 = THEME.ButtonRed
    MinusButton.TextColor3 = THEME.TextBright
    MinusButton.Text = "-"
    MinusButton.Font = Enum.Font.GothamBold
    MinusButton.TextSize = 16
    MinusButton.BorderSizePixel = 0
    
    local PlusButton = Instance.new("TextButton")
    PlusButton.Parent = MainFrame
    PlusButton.Size = UDim2.new(0, 35, 0, 25)
    PlusButton.Position = UDim2.new(1, -45, 0, 235)
    PlusButton.BackgroundColor3 = THEME.ButtonGreen
    PlusButton.TextColor3 = THEME.TextBright
    PlusButton.Text = "+"
    PlusButton.Font = Enum.Font.GothamBold
    PlusButton.TextSize = 16
    PlusButton.BorderSizePixel = 0
    
    local ResetButton = Instance.new("TextButton")
    ResetButton.Parent = MainFrame
    ResetButton.Size = UDim2.new(1, -100, 0, 25)
    ResetButton.Position = UDim2.new(0, 55, 0, 235)
    ResetButton.BackgroundColor3 = THEME.ButtonGray
    ResetButton.TextColor3 = THEME.TextBright
    ResetButton.Text = "RESET"
    ResetButton.Font = Enum.Font.Gotham
    ResetButton.TextSize = 11
    ResetButton.BorderSizePixel = 0
    
    local StatsLabel = Instance.new("TextLabel")
    StatsLabel.Parent = MainFrame
    StatsLabel.Size = UDim2.new(1, -20, 0, 60)
    StatsLabel.Position = UDim2.new(0, 10, 0, 270)
    StatsLabel.BackgroundColor3 = THEME.SecondaryBackground
    StatsLabel.TextColor3 = THEME.Text
    StatsLabel.Text = "Items: 0 | Sold: 0 | AFK: 0"
    StatsLabel.Font = Enum.Font.Gotham
    StatsLabel.TextSize = 10
    StatsLabel.BorderSizePixel = 0
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Parent = MainFrame
    InfoLabel.Size = UDim2.new(1, -20, 0, 20)
    InfoLabel.Position = UDim2.new(0, 10, 0, 340)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.TextColor3 = THEME.Accent
    InfoLabel.Text = "HIZUTOME // XENO STABLE"
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.TextSize = 10
    
    local KeybindInfo = Instance.new("TextLabel")
    KeybindInfo.Parent = MainFrame
    KeybindInfo.Size = UDim2.new(1, -20, 0, 80)
    KeybindInfo.Position = UDim2.new(0, 10, 0, 365)
    KeybindInfo.BackgroundColor3 = THEME.SecondaryBackground
    KeybindInfo.TextColor3 = THEME.Text
    KeybindInfo.Text = "F6 - Start/Stop\nF7 - Collect\nF8 - Sell\nF9 - Anti AFK\nRightCtrl - Hide UI"
    KeybindInfo.Font = Enum.Font.Gotham
    KeybindInfo.TextSize = 10
    KeybindInfo.TextXAlignment = Enum.TextXAlignment.Left
    KeybindInfo.BorderSizePixel = 0
    
    -- Update stats
    task.spawn(function()
        while true do
            task.wait(1)
            pcall(function()
                if _G[MEMORY_KEY] then
                    local data = _G[MEMORY_KEY].SessionData
                    StatsLabel.Text = string.format("Items: %d | Sold: %d | AFK: %d", 
                        data.ItemsCollected or 0, 
                        data.ItemsSold or 0, 
                        data.AFKMoves or 0)
                end
            end)
        end
    end)
    
    -- Button functions
    MainToggle.MouseButton1Click:Connect(function()
        isRunning = not isRunning
        if isRunning then
            MainToggle.Text = "STOP"
            MainToggle.BackgroundColor3 = THEME.ButtonRed
            task.spawn(MainLoop)
        else
            MainToggle.Text = "START"
            MainToggle.BackgroundColor3 = THEME.ButtonGreen
        end
    end)
    
    CollectToggle.MouseButton1Click:Connect(function()
        collectEnabled = not collectEnabled
        if collectEnabled then
            CollectToggle.Text = "AUTO COLLECT: ON"
            CollectToggle.BackgroundColor3 = THEME.ButtonGreen
        else
            CollectToggle.Text = "AUTO COLLECT: OFF"
            CollectToggle.BackgroundColor3 = THEME.ButtonGray
        end
    end)
    
    SellToggle.MouseButton1Click:Connect(function()
        sellEnabled = not sellEnabled
        if sellEnabled then
            SellToggle.Text = "AUTO SELL: ON"
            SellToggle.BackgroundColor3 = THEME.ButtonGreen
        else
            SellToggle.Text = "AUTO SELL: OFF"
            SellToggle.BackgroundColor3 = THEME.ButtonGray
        end
    end)
    
    AntiAFKToggle.MouseButton1Click:Connect(function()
        antiAFKEnabled = not antiAFKEnabled
        if antiAFKEnabled then
            AntiAFKToggle.Text = "ANTI AFK: ON"
            AntiAFKToggle.BackgroundColor3 = THEME.ButtonGreen
            nextAFKTime = tick() + 900
            task.spawn(AntiAFKLoop)
        else
            AntiAFKToggle.Text = "ANTI AFK: OFF"
            AntiAFKToggle.BackgroundColor3 = THEME.ButtonGray
        end
    end)
    
    local function UpdateDelay()
        currentDelay = math.floor(currentDelay * 10) / 10
        DelayLabel.Text = "DELAY: " .. currentDelay .. "s"
        if _G[MEMORY_KEY] then
            _G[MEMORY_KEY].Settings.Delay = currentDelay
        end
    end
    
    MinusButton.MouseButton1Click:Connect(function()
        if currentDelay > 0.1 then
            currentDelay = currentDelay - 0.1
            UpdateDelay()
        end
    end)
    
    PlusButton.MouseButton1Click:Connect(function()
        if currentDelay < 5.0 then
            currentDelay = currentDelay + 0.1
            UpdateDelay()
        end
    end)
    
    ResetButton.MouseButton1Click:Connect(function()
        currentDelay = 0.3
        UpdateDelay()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        uiVisible = false
        MainFrame.Visible = false
    end)
    
    return MainFrame
end

-- ==================== INPUT HANDLER ====================
local uiElements = nil

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == KEYBINDS.MainToggle then
            isRunning = not isRunning
            if isRunning then
                task.spawn(MainLoop)
            end
            SecurePrint("Main: " .. (isRunning and "ON" or "OFF"))
        elseif input.KeyCode == KEYBINDS.CollectToggle then
            collectEnabled = not collectEnabled
            SecurePrint("Collect: " .. (collectEnabled and "ON" or "OFF"))
        elseif input.KeyCode == KEYBINDS.SellToggle then
            sellEnabled = not sellEnabled
            SecurePrint("Sell: " .. (sellEnabled and "ON" or "OFF"))
        elseif input.KeyCode == KEYBINDS.AntiAFKToggle then
            antiAFKEnabled = not antiAFKEnabled
            if antiAFKEnabled then
                nextAFKTime = tick() + 900
                task.spawn(AntiAFKLoop)
            end
            SecurePrint("Anti AFK: " .. (antiAFKEnabled and "ON" or "OFF"))
        elseif input.KeyCode == KEYBINDS.UIKey then
            uiVisible = not uiVisible
            if uiElements then
                uiElements.Visible = uiVisible
            end
        end
    end
end)

-- ==================== PERIODIC VALIDATION ====================
task.spawn(function()
    while true do
        task.wait(60)
        
        pcall(function()
            if _G[MEMORY_KEY] then
                _G[MEMORY_KEY].SessionData.LastCheck = tick()
                
                local sessionTime = tick() - _G[MEMORY_KEY].SessionData.StartTime
                SecurePrint("Session running: " .. math.floor(sessionTime) .. "s")
                SecurePrint("Items collected: " .. (_G[MEMORY_KEY].SessionData.ItemsCollected or 0))
                SecurePrint("Items sold: " .. (_G[MEMORY_KEY].SessionData.ItemsSold or 0))
            end
        end)
        
        ResetRateLimiter()
    end
end)

-- ==================== MEMORY CLEANUP ====================
task.spawn(function()
    while true do
        task.wait(600)
        
        pcall(function()
            if #LogQueue > MaxLogEntries then
                while #LogQueue > MaxLogEntries do
                    table.remove(LogQueue, 1)
                end
                SecurePrint("Log cleanup performed")
            end
        end)
    end
end)

-- ==================== AUTO RECOVERY ====================
task.spawn(function()
    while true do
        task.wait(30)
        
        pcall(function()
            if LocalPlayer.Character == nil then
                SecurePrint("Character lost, waiting respawn...")
                task.wait(5)
            end
        end)
        
        pcall(function()
            if CoreGui:FindFirstChild("HizutomeUI") == nil then
                SecurePrint("UI lost, recreating...")
                uiElements = CreateUI()
            end
        end)
    end
end)

-- ==================== INISIALISASI ====================
SecurePrint("========================================")
SecurePrint("HIZUTOME // MINIWAR AUTO FARM")
SecurePrint("Version: " .. SCRIPT_VERSION)
SecurePrint("Build: " .. SCRIPT_BUILD)
SecurePrint("Session ID: " .. SCRIPT_ID)
SecurePrint("========================================")

FullRemoteScan()
uiElements = CreateUI()

if antiAFKEnabled then
    nextAFKTime = tick() + 900
    task.spawn(AntiAFKLoop)
end

SecurePrint("Script loaded successfully")
SecurePrint("Keybinds:")
SecurePrint(GetKeyName(KEYBINDS.MainToggle) .. " - Start/Stop")
SecurePrint(GetKeyName(KEYBINDS.CollectToggle) .. " - Toggle Collect")
SecurePrint(GetKeyName(KEYBINDS.SellToggle) .. " - Toggle Sell")
SecurePrint(GetKeyName(KEYBINDS.AntiAFKToggle) .. " - Toggle Anti AFK")
SecurePrint(GetKeyName(KEYBINDS.UIKey) .. " - Toggle UI")
SecurePrint("========================================")
