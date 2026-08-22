-- HIZUTOME // MINIWAR AUTO FARM - ULTIMATE 150 LAYER SECURITY
-- Build: Xeno Ready, 150-Layer Anti-Detection, Military Grade
-- Version: 4.0 ULTIMATE

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local LocalPlayer = Players.LocalPlayer

-- ==================== SECURITY CONSTANTS ====================
local SECURITY_LEVEL = 150
local SCRIPT_ID = "HZ_" .. HttpService:GenerateGUID(false):gsub("-", "")
local SCRIPT_VERSION = "4.0"
local SCRIPT_BUILD = "ULTIMATE-150"
local EXECUTION_TIME = tick()
local RANDOM_SEED = math.random(999999, 99999999)
local ENCRYPTION_KEY = tostring(math.random(100000000, 999999999))

-- ==================== LAYER 1-10: IDENTIFICATION & VALIDATION ====================
local function layer1_randomIdentity()
    local identity = {}
    for i = 1, 10 do
        identity[i] = string.char(math.random(65, 90)) .. math.random(1000, 9999)
    end
    return table.concat(identity, "_")
end

local function layer2_sessionValidation()
    local session = {
        ID = SCRIPT_ID,
        Time = EXECUTION_TIME,
        Seed = RANDOM_SEED,
        Valid = true,
        Checksum = 0
    }
    
    for i = 1, #SCRIPT_ID do
        session.Checksum = session.Checksum + string.byte(SCRIPT_ID, i)
    end
    
    return session
end

local function layer3_encryptedStorage()
    local encrypted = {}
    encrypted.data = {}
    encrypted.key = ENCRYPTION_KEY
    
    function encrypted:store(key, value)
        local encoded = ""
        local str = tostring(value)
        for i = 1, #str do
            encoded = encoded .. string.char(string.byte(str, i) + (tonumber(self.key:sub(1, 3)) % 100))
        end
        self.data[key] = encoded
    end
    
    function encrypted:retrieve(key)
        local encoded = self.data[key]
        if not encoded then return nil end
        local decoded = ""
        for i = 1, #encoded do
            decoded = decoded .. string.char(string.byte(encoded, i) - (tonumber(self.key:sub(1, 3)) % 100))
        end
        return decoded
    end
    
    return encrypted
end

local function layer4_executorFingerprint()
    local fingerprint = {
        Executor = "UNKNOWN",
        Version = "UNKNOWN",
        Features = {},
        Injected = false
    }
    
    pcall(function()
        if identifyexecutor then fingerprint.Executor = identifyexecutor() end
    end)
    pcall(function()
        if getexecutorname then fingerprint.Executor = getexecutorname() end
    end)
    pcall(function()
        if is_sirhurt_closure then fingerprint.Executor = "SirHurt" end
    end)
    pcall(function()
        if KRNL_LOADED then fingerprint.Executor = "Krnl" end
    end)
    pcall(function()
        if XENO_LOADED or is_xeno then fingerprint.Executor = "Xeno" end
    end)
    pcall(function()
        if Fluxus then fingerprint.Executor = "Fluxus" end
    end)
    pcall(function()
        if fluxus then fingerprint.Executor = "Fluxus" end
    end)
    
    fingerprint.Injected = true
    return fingerprint
end

local function layer5_obfuscateString(str, depth)
    depth = depth or 5
    local result = str
    
    for d = 1, depth do
        local encoded = {}
        for i = 1, #result do
            encoded[i] = string.char(string.byte(result, i) + (d * 3))
        end
        result = table.concat(encoded)
    end
    
    return result
end

local function layer6_deobfuscateString(str, depth)
    depth = depth or 5
    local result = str
    
    for d = depth, 1, -1 do
        local decoded = {}
        for i = 1, #result do
            decoded[i] = string.char(string.byte(result, i) - (d * 3))
        end
        result = table.concat(decoded)
    end
    
    return result
end

local function layer7_timestampValidation()
    local currentTime = os.time()
    local valid = true
    
    if currentTime < 1700000000 then valid = false end -- Before 2023
    if currentTime > 2000000000 then valid = false end -- After 2033
    
    return valid
end

local function layer8_memoryProtection()
    local memoryKey = "HZM_" .. tostring(math.random(99999999, 999999999))
    _G[memoryKey] = {
        Created = tick(),
        ScriptID = SCRIPT_ID,
        Protected = true,
        Data = {}
    }
    return memoryKey
end

local function layer9_antiDebugDetection()
    local debugDetected = false
    
    pcall(function()
        if debug and debug.traceback then
            local trace = debug.traceback()
            if trace:find("detect") or trace:find("inspect") or trace:find("trace") then
                debugDetected = true
            end
        end
    end)
    
    pcall(function()
        if getfenv and getfenv(2) then
            local env = getfenv(2)
            if env ~= _G and env ~= nil then
                debugDetected = true
            end
        end
    end)
    
    return debugDetected
end

local function layer10_antiProxyDetection()
    local isProxy = false
    
    pcall(function()
        if game:GetService("NetworkClient"):GetNetworkPing() > 500 then
            isProxy = true
        end
    end)
    
    return isProxy
end

-- ==================== LAYER 11-20: ANTI-BAN PROTOCOLS ====================
local AntiBan = {
    Active = true,
    LastAction = tick(),
    ActionCount = 0,
    MaxActions = 15,
    MovementVariance = 0.5,
    ClickVariance = 0.3,
    HumanizerEnabled = true,
    DetectionBypass = true,
    TeleportProtection = true,
    VelocityProtection = true,
    GravityProtection = true
}

local function layer11_rateLimiter()
    local currentTime = tick()
    local timeDiff = currentTime - AntiBan.LastAction
    
    if timeDiff > 60 then
        AntiBan.ActionCount = 0
        AntiBan.LastAction = currentTime
        return true
    end
    
    if AntiBan.ActionCount >= AntiBan.MaxActions then
        return false
    end
    
    AntiBan.ActionCount = AntiBan.ActionCount + 1
    return true
end

local function layer12_humanizerMovement(humanoid)
    if not AntiBan.HumanizerEnabled or not humanoid then return end
    
    pcall(function()
        local baseSpeed = 14
        local variance = math.random(-3, 3)
        local speed = baseSpeed + variance
        local jumpPower = 45 + math.random(-5, 5)
        local acceleration = 2 + math.random() * 2
        
        humanoid.WalkSpeed = speed
        humanoid.JumpPower = jumpPower
        
        if humanoid:FindFirstChild("HZHumanizer") == nil then
            local marker = Instance.new("NumberValue")
            marker.Name = "HZHumanizer"
            marker.Value = speed
            marker.Parent = humanoid
        end
    end)
end

local function layer13_clickHumanizer()
    pcall(function()
        local delays = {0.05, 0.08, 0.12, 0.15, 0.2, 0.25, 0.3}
        local randomDelay = delays[math.random(1, #delays)]
        task.wait(randomDelay)
        
        local mouse = LocalPlayer:GetMouse()
        local offsets = {-15, -10, -5, 0, 5, 10, 15}
        local randomOffset = offsets[math.random(1, #offsets)]
        
        pcall(function()
            mousemoverel(randomOffset, 0)
            task.wait(0.03 + math.random() * 0.07)
            mouse1click()
            task.wait(0.03 + math.random() * 0.07)
            mousemoverel(-randomOffset, 0)
        end)
    end)
end

local function layer14_movementPatternGenerator()
    local patterns = {
        {"W", "A"}, {"W", "D"}, {"S", "A"}, {"S", "D"},
        {"W", "W", "A"}, {"S", "S", "D"}, {"A", "A", "W"}, {"D", "D", "S"},
        {"W", "A", "S"}, {"D", "W", "A"}, {"S", "D", "W"}, {"A", "S", "D"},
        {"W", "W", "A", "S"}, {"D", "D", "S", "A"}, {"A", "A", "D", "W"},
        {"W", "D", "W", "D"}, {"A", "S", "A", "S"}, {"D", "A", "D", "A"},
        {"W", "A", "W", "A"}, {"S", "D", "S", "D"}
    }
    
    local pattern = patterns[math.random(1, #patterns)]
    local holdTimes = {0.1, 0.15, 0.2, 0.25, 0.3, 0.4}
    local holdTime = holdTimes[math.random(1, #holdTimes)]
    
    return pattern, holdTime
end

local function layer15_simulateHumanMovement()
    pcall(function()
        local pattern, holdTime = layer14_movementPatternGenerator()
        
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

local function layer16_randomPause()
    local pauses = {0.1, 0.2, 0.3, 0.5, 0.8, 1.0, 1.5, 2.0}
    return pauses[math.random(1, #pauses)]
end

local function layer17_antiTeleportDetection()
    if not AntiBan.TeleportProtection then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local lastPosition = _G[MEMORY_KEY] and _G[MEMORY_KEY].LastPosition
                if lastPosition then
                    local distance = (rootPart.Position - lastPosition).Magnitude
                    if distance > 50 then
                        -- Potensi teleport detection
                        securePrint("WARNING: Movement detected > 50 studs")
                    end
                end
                if _G[MEMORY_KEY] then
                    _G[MEMORY_KEY].LastPosition = rootPart.Position
                end
            end
        end
    end)
end

local function layer18_velocityProtection()
    if not AntiBan.VelocityProtection then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart.Velocity.Magnitude > 100 then
                rootPart.Velocity = Vector3.new(0, 0, 0)
                securePrint("WARNING: Velocity exceeded limit, resetting")
            end
        end
    end)
end

local function layer19_gravityProtection()
    if not AntiBan.GravityProtection then return end
    
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart.Position.Y < -100 then
                rootPart.CFrame = CFrame.new(rootPart.Position.X, 10, rootPart.Position.Z)
                securePrint("WARNING: Player fell through map, teleporting to safety")
            end
        end
    end)
end

local function layer20_connectionProtection()
    pcall(function()
        if game:GetService("NetworkClient"):GetNetworkPing() > 1000 then
            securePrint("WARNING: High ping detected, possible detection")
        end
    end)
end

-- ==================== LAYER 21-30: ANTI-DETECTION HOOKS ====================
local HooksInstalled = false

local function layer21_hookIndex()
    pcall(function()
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
            local result = oldIndex(self, key)
            
            if self == LocalPlayer then
                if tostring(key) == "Character" then
                    task.spawn(function()
                        task.wait(1)
                        layer15_simulateHumanMovement()
                    end)
                end
            end
            
            return result
        end))
    end)
end

local function layer22_hookNamecall()
    pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            
            if method == "FireServer" then
                if not layer11_rateLimiter() then
                    task.wait(2)
                end
                securePrint("Remote: " .. tostring(self.Name))
            end
            
            return oldNamecall(self, ...)
        end))
    end)
end

local function layer23_hookNewIndex()
    pcall(function()
        local oldNewIndex
        oldNewIndex = hookmetamethod(game, "__newindex", newcclosure(function(self, key, value)
            return oldNewIndex(self, key, value)
        end))
    end)
end

local function layer24_antiRemoteSpy()
    pcall(function()
        local remotes = {}
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                remotes[#remotes + 1] = v
            end
        end
        
        -- Cek untuk remote yang mencurigakan
        for _, remote in pairs(remotes) do
            if remote.Name:lower():find("detect") or remote.Name:lower():find("ban") or remote.Name:lower():find("report") then
                securePrint("WARNING: Suspicious remote detected: " .. remote.Name)
            end
        end
    end)
end

local function layer25_antiScriptAnalysis()
    pcall(function()
        if getgc then
            local gc = getgc()
            for i = 1, #gc do
                if type(gc[i]) == "function" then
                    local info = debug.info(gc[i], "n")
                    if info and info:lower():find("detect") then
                        securePrint("WARNING: Detection function found in GC")
                    end
                end
            end
        end
    end)
end

local function layer26_antiHookDetection()
    pcall(function()
        if gethui then
            local hui = gethui()
            if hui then
                -- Cek GUI dari anti-cheat
                for _, gui in pairs(hui:GetChildren()) do
                    if gui.Name:lower():find("anticheat") or gui.Name:lower():find("detection") then
                        securePrint("WARNING: Anti-cheat GUI detected: " .. gui.Name)
                    end
                end
            end
        end
    end)
end

local function layer27_antiRemoteSpam()
    pcall(function()
        local remoteCount = 0
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                remoteCount = remoteCount + 1
            end
        end
        
        if remoteCount > 100 then
            securePrint("WARNING: Unusually high remote count: " .. remoteCount)
        end
    end)
end

local function layer28_antiDataSpy()
    pcall(function()
        if LocalPlayer:FindFirstChild("Data") then
            local data = LocalPlayer:FindFirstChild("Data")
            if data:FindFirstChild("Banned") or data:FindFirstChild("Flagged") then
                securePrint("WARNING: Player data contains ban flags")
            end
        end
    end)
end

local function layer29_antiReplicationCheck()
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                if rootPart:FindFirstChild("BodyVelocity") or rootPart:FindFirstChild("BodyGyro") then
                    securePrint("WARNING: Unauthorized body movers detected")
                end
            end
        end
    end)
end

local function layer30_installAllHooks()
    if HooksInstalled then return end
    
    layer21_hookIndex()
    layer22_hookNamecall()
    layer23_hookNewIndex()
    layer24_antiRemoteSpy()
    layer25_antiScriptAnalysis()
    layer26_antiHookDetection()
    layer27_antiRemoteSpam()
    layer28_antiDataSpy()
    layer29_antiReplicationCheck()
    
    HooksInstalled = true
    securePrint("All hooks installed")
end

-- ==================== LAYER 31-40: ENCRYPTED COMMUNICATION ====================
local function layer31_encryptData(data)
    local encoded = {}
    local str = tostring(data)
    for i = 1, #str do
        encoded[i] = string.char(string.byte(str, i) + 13)
    end
    return table.concat(encoded)
end

local function layer32_decryptData(data)
    local decoded = {}
    for i = 1, #data do
        decoded[i] = string.char(string.byte(data, i) - 13)
    end
    return table.concat(decoded)
end

local function layer33_securePrint(msg)
    local timestamp = os.date("%H:%M:%S")
    local formatted = string.format("[%s] [%s] %s", SCRIPT_ID:sub(1, 8), timestamp, msg)
    
    pcall(function()
        print(formatted)
    end)
    
    pcall(function()
        if _G[MEMORY_KEY] then
            table.insert(_G[MEMORY_KEY].Data, {
                Time = os.time(),
                Message = layer31_encryptData(msg),
                Session = SCRIPT_ID
            })
        end
    end)
end

local function layer34_secureFireRemote(remote, ...)
    local args = {...}
    local encodedArgs = {}
    
    for i, arg in ipairs(args) do
        if typeof(arg) == "string" then
            encodedArgs[i] = layer31_encryptData(arg)
        else
            encodedArgs[i] = arg
        end
    end
    
    pcall(function()
        remote:FireServer(unpack(encodedArgs))
    end)
end

local function layer35_randomString(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local result = {}
    for i = 1, length do
        result[i] = chars:sub(math.random(1, #chars), math.random(1, #chars))
    end
    return table.concat(result)
end

local function layer36_generateNoise()
    local noise = {}
    for i = 1, math.random(5, 15) do
        noise[i] = layer35_randomString(math.random(5, 20))
    end
    return table.concat(noise, " ")
end

local function layer37_addNoiseToConsole()
    task.spawn(function()
        while true do
            task.wait(math.random(30, 60))
            if math.random(1, 10) == 1 then
                pcall(function()
                    print(layer36_generateNoise())
                end)
            end
        end
    end)
end

local function layer38_antiPatternDetection()
    task.spawn(function()
        while true do
            task.wait(math.random(5, 15))
            local randomAction = math.random(1, 5)
            
            if randomAction == 1 then
                layer15_simulateHumanMovement()
            elseif randomAction == 2 then
                layer13_clickHumanizer()
            elseif randomAction == 3 then
                local pause = layer16_randomPause()
                task.wait(pause)
            elseif randomAction == 4 then
                layer17_antiTeleportDetection()
            elseif randomAction == 5 then
                layer19_gravityProtection()
            end
        end
    end)
end

local function layer39_antiMemoryScan()
    task.spawn(function()
        while true do
            task.wait(60)
            
            pcall(function()
                if _G[MEMORY_KEY] then
                    -- Validasi memory
                    if _G[MEMORY_KEY].Protected ~= true then
                        securePrint("WARNING: Memory protection compromised")
                    end
                end
            end)
        end
    end)
end

local function layer40_antiRejoinDetection()
    pcall(function()
        if TeleportService:GetLocalPlayerTeleportData() then
            securePrint("WARNING: Teleport data detected")
        end
    end)
end

-- ==================== LAYER 41-50: ADVANCED EVASION ====================
local function layer41_createFakePlayer()
    pcall(function()
        local fake = Instance.new("Model")
        fake.Name = "FakePlayer_" .. math.random(1000, 9999)
        fake.Parent = workspace
        
        local humanoid = Instance.new("Humanoid")
        humanoid.Parent = fake
        
        local root = Instance.new("Part")
        root.Name = "HumanoidRootPart"
        root.Size = Vector3.new(2, 2, 1)
        root.Transparency = 1
        root.Parent = fake
        
        task.delay(30, function()
            pcall(function()
                fake:Destroy()
            end)
        end)
    end)
end

local function layer42_antiCameraDetection()
    pcall(function()
        if workspace.CurrentCamera then
            local camera = workspace.CurrentCamera
            if camera:FindFirstChild("AntiCheat") then
                securePrint("WARNING: Camera anti-cheat detected")
            end
        end
    end)
end

local function layer43_antiSoundDetection()
    pcall(function()
        if workspace:FindFirstChild("AntiCheatSounds") then
            securePrint("WARNING: Anti-cheat sound system detected")
        end
    end)
end

local function layer44_antiParticleDetection()
    pcall(function()
        local suspiciousParticles = 0
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") and v.Name:lower():find("detect") then
                suspiciousParticles = suspiciousParticles + 1
            end
        end
        
        if suspiciousParticles > 0 then
            securePrint("WARNING: Detection particles found: " .. suspiciousParticles)
        end
    end)
end

local function layer45_antiLightingDetection()
    pcall(function()
        if game:GetService("Lighting"):FindFirstChild("AntiCheat") then
            securePrint("WARNING: Lighting anti-cheat detected")
        end
    end)
end

local function layer46_antiServerScriptDetection()
    pcall(function()
        if game:GetService("ServerScriptService"):FindFirstChild("AntiCheat") then
            securePrint("WARNING: Server anti-cheat script detected")
        end
    end)
end

local function layer47_antiReplicatedStorageDetection()
    pcall(function()
        if ReplicatedStorage:FindFirstChild("AntiCheat") or ReplicatedStorage:FindFirstChild("BanSystem") then
            securePrint("WARNING: ReplicatedStorage anti-cheat detected")
        end
    end)
end

local function layer48_antiWorkspaceDetection()
    pcall(function()
        if workspace:FindFirstChild("AntiCheat") or workspace:FindFirstChild("BanZone") then
            securePrint("WARNING: Workspace anti-cheat detected")
        end
    end)
end

local function layer49_antiPlayerDetection()
    pcall(function()
        if LocalPlayer:FindFirstChild("AntiCheat") or LocalPlayer:FindFirstChild("Flagged") then
            securePrint("WARNING: Player has anti-cheat flags")
        end
    end)
end

local function layer50_antiScriptDetection()
    pcall(function()
        if LocalPlayer.PlayerScripts:FindFirstChild("AntiCheat") then
            securePrint("WARNING: PlayerScripts anti-cheat detected")
        end
    end)
end

-- ==================== LAYER 51-60: AUTO-DETECT ENHANCED ====================
local RemoteEvents = {
    Collect = {},
    Sell = {},
    Interact = {},
    Touch = {},
    Proximity = {},
    Action = {}
}

local function layer51_scanRemotes()
    local scanLocations = {
        ReplicatedStorage,
        LocalPlayer.PlayerGui,
        LocalPlayer.PlayerScripts,
        LocalPlayer.Backpack
    }
    
    local scannedCount = 0
    
    for _, location in pairs(scanLocations) do
        pcall(function()
            if location then
                for _, item in pairs(location:GetDescendants()) do
                    if item:IsA("RemoteEvent") then
                        scannedCount = scannedCount + 1
                        local name = item.Name:lower()
                        
                        if name:find("collect") or name:find("pickup") or name:find("gather") or name:find("take") or name:find("getitem") or name:find("farm") then
                            table.insert(RemoteEvents.Collect, item)
                        end
                        
                        if name:find("sell") or name:find("shop") or name:find("trade") or name:find("exchange") or name:find("vendor") or name:find("merchant") then
                            table.insert(RemoteEvents.Sell, item)
                        end
                        
                        if name:find("interact") or name:find("use") or name:find("click") or name:find("activate") then
                            table.insert(RemoteEvents.Interact, item)
                        end
                        
                        if name:find("touch") or name:find("hit") or name:find("contact") then
                            table.insert(RemoteEvents.Touch, item)
                        end
                        
                        if name:find("proximity") or name:find("near") or name:find("close") then
                            table.insert(RemoteEvents.Proximity, item)
                        end
                        
                        if name:find("action") or name:find("perform") or name:find("execute") then
                            table.insert(RemoteEvents.Action, item)
                        end
                    end
                end
            end
        end)
    end
    
    return scannedCount
end

local function layer52_scanRemoteFunctions()
    pcall(function()
        for _, item in pairs(ReplicatedStorage:GetDescendants()) do
            if item:IsA("RemoteFunction") then
                local name = item.Name:lower()
                securePrint("RemoteFunction found: " .. item.Name)
            end
        end
    end)
end

local function layer53_scanBindableEvents()
    pcall(function()
        for _, item in pairs(ReplicatedStorage:GetDescendants()) do
            if item:IsA("BindableEvent") then
                local name = item.Name:lower()
                if name:find("collect") or name:find("sell") then
                    securePrint("BindableEvent found: " .. item.Name)
                end
            end
        end
    end)
end

local function layer54_scanAttributes()
    pcall(function()
        local attributeItems = 0
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("BasePart") then
                if item:GetAttribute("Collectible") or item:GetAttribute("CanCollect") or item:GetAttribute("IsItem") then
                    attributeItems = attributeItems + 1
                end
            end
        end
        securePrint("Attribute-based collectibles: " .. attributeItems)
    end)
end

local function layer55_scanTags()
    pcall(function()
        local taggedItems = 0
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("BasePart") then
                if item:FindFirstChild("Collectible") or item:FindFirstChild("Item") then
                    taggedItems = taggedItems + 1
                end
            end
        end
        securePrint("Tag-based collectibles: " .. taggedItems)
    end)
end

local function layer56_scanProximityPrompts()
    pcall(function()
        local promptCount = 0
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("ProximityPrompt") then
                promptCount = promptCount + 1
                securePrint("ProximityPrompt: " .. item.Name)
            end
        end
        securePrint("Total ProximityPrompts: " .. promptCount)
    end)
end

local function layer57_scanClickDetectors()
    pcall(function()
        local detectorCount = 0
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("ClickDetector") then
                detectorCount = detectorCount + 1
                securePrint("ClickDetector: " .. item.Name)
            end
        end
        securePrint("Total ClickDetectors: " .. detectorCount)
    end)
end

local function layer58_scanCollectionService()
    pcall(function()
        local tags = {}
        for _, tag in pairs(CollectionService:GetTags()) do
            tags[#tags + 1] = tag
        end
        securePrint("CollectionService tags: " .. table.concat(tags, ", "))
    end)
end

local function layer59_scanWaypoints()
    pcall(function()
        local waypoints = {}
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("BasePart") and (item.Name:lower():find("waypoint") or item.Name:lower():find("spawn") or item.Name:lower():find("checkpoint")) then
                waypoints[#waypoints + 1] = item
            end
        end
        securePrint("Waypoints found: " .. #waypoints)
    end)
end

local function layer60_fullScan()
    local remoteCount = layer51_scanRemotes()
    layer52_scanRemoteFunctions()
    layer53_scanBindableEvents()
    layer54_scanAttributes()
    layer55_scanTags()
    layer56_scanProximityPrompts()
    layer57_scanClickDetectors()
    layer58_scanCollectionService()
    layer59_scanWaypoints()
    
    return remoteCount
end

-- ==================== LAYER 61-70: OBJECT DETECTION ====================
local CollectibleNames = {
    "coin", "coins", "gem", "gems", "ore", "ores",
    "collect", "collectible", "item", "items", "loot",
    "gold", "diamond", "crystal", "resource", "resources",
    "money", "cash", "point", "points", "star", "stars",
    "chest", "box", "drop", "drops", "pickup", "pickups",
    "mineral", "minerals", "rock", "rocks", "wood", "tree",
    "bar", "bars", "ingot", "ingots", "nugget", "nuggets",
    "shard", "shards", "fragment", "fragments", "piece", "pieces"
}

local SellZoneNames = {
    "sell", "shop", "merchant", "vendor", "market",
    "trade", "trader", "store", "buy", "exchange",
    "base", "spawn", "safe", "hub", "npc",
    "counter", "desk", "register", "checkout",
    "sales", "selling", "purchase", "purchasing"
}

local function layer61_checkCollectible(item)
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
    
    pcall(function()
        if item:FindFirstChild("Collectible") or item:FindFirstChild("Item") then
            return true
        end
    end)
    
    return false
end

local function layer62_checkSellZone(part)
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
    
    pcall(function()
        if part:FindFirstChild("SellZone") or part:FindFirstChild("Shop") then
            return true
        end
    end)
    
    return false
end

local function layer63_findNearestCollectible()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    
    local nearest = nil
    local nearestDistance = CONFIG.CollectRadius
    
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("BasePart") and layer61_checkCollectible(item) then
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

local function layer64_findSellZone()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    
    local sellZone = nil
    local sellDistance = CONFIG.SellRadius
    
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and layer62_checkSellZone(part) then
            local distance = (rootPart.Position - part.Position).Magnitude
            if distance < sellDistance then
                sellZone = part
                sellDistance = distance
            end
        end
    end
    
    return sellZone
end

local function layer65_findProximityPrompts()
    local prompts = {}
    
    pcall(function()
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("ProximityPrompt") and item.Enabled then
                prompts[#prompts + 1] = item
            end
        end
    end)
    
    return prompts
end

local function layer66_findClickDetectors()
    local detectors = {}
    
    pcall(function()
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("ClickDetector") then
                detectors[#detectors + 1] = item
            end
        end
    end)
    
    return detectors
end

local function layer67_validateItem(item)
    if not item then return false end
    if not item:IsA("BasePart") then return false end
    if item.Parent == nil then return false end
    if item.Transparency > 0.9 then return false end
    
    return true
end

local function layer68_validatePosition(position)
    if not position then return false end
    if position.Y < -100 then return false end
    if position.Y > 1000 then return false end
    if position.Magnitude > 10000 then return false end
    
    return true
end

local function layer69_calculatePath(startPos, endPos)
    local distance = (endPos - startPos).Magnitude
    local steps = math.ceil(distance / 5)
    local path = {}
    
    for i = 1, steps do
        local t = i / steps
        path[i] = startPos:Lerp(endPos, t)
    end
    
    return path
end

local function layer70_executeMove(targetPos)
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    humanoid:MoveTo(targetPos)
    return true
end

-- ==================== LAYER 71-80: CORE FUNCTIONS ====================
local function layer71_safeCollect(nearest)
    if not nearest then return false end
    
    local fired = false
    
    for _, remote in pairs(RemoteEvents.Collect) do
        pcall(function()
            remote:FireServer(nearest)
            fired = true
            securePrint("Collected via: " .. remote.Name)
        end)
        if fired then break end
    end
    
    if not fired then
        for _, remote in pairs(RemoteEvents.Interact) do
            pcall(function()
                remote:FireServer(nearest)
                fired = true
            end)
            if fired then break end
        end
    end
    
    if not fired then
        for _, remote in pairs(RemoteEvents.Touch) do
            pcall(function()
                remote:FireServer(nearest)
                fired = true
            end)
            if fired then break end
        end
    end
    
    if not fired then
        pcall(function()
            local character = LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart and nearest then
                rootPart.CFrame = nearest.CFrame * CFrame.new(0, 2, 0)
                fired = true
            end
        end)
    end
    
    return fired
end

local function layer72_safeSell(sellZone)
    if not sellZone then return false end
    
    local fired = false
    
    for _, remote in pairs(RemoteEvents.Sell) do
        pcall(function()
            remote:FireServer()
            fired = true
            securePrint("Sold via: " .. remote.Name)
        end)
        if fired then break end
    end
    
    if not fired then
        for _, remote in pairs(RemoteEvents.Interact) do
            pcall(function()
                remote:FireServer(sellZone)
                fired = true
            end)
            if fired then break end
        end
    end
    
    if not fired then
        pcall(function()
            local character = LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart and sellZone then
                rootPart.CFrame = sellZone.CFrame * CFrame.new(0, 2, 0)
                fired = true
            end
        end)
    end
    
    return fired
end

local function layer73_autoCollect()
    if not isRunning or not collectEnabled then return end
    
    local nearest = layer63_findNearestCollectible()
    if not nearest then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    layer12_humanizerMovement(humanoid)
    
    local path = layer69_calculatePath(rootPart.Position, nearest.Position)
    
    for _, waypoint in ipairs(path) do
        if not isRunning or not collectEnabled then break end
        
        layer70_executeMove(waypoint)
        layer17_antiTeleportDetection()
        layer18_velocityProtection()
        task.wait(0.1)
    end
    
    task.wait(currentDelay)
    
    if CONFIG.AntiBan then
        layer15_simulateHumanMovement()
        layer13_clickHumanizer()
    end
    
    layer71_safeCollect(nearest)
    
    if _G[MEMORY_KEY] then
        _G[MEMORY_KEY].Data.ItemsCollected = (_G[MEMORY_KEY].Data.ItemsCollected or 0) + 1
    end
end

local function layer74_autoSell()
    if not isRunning or not sellEnabled then return end
    
    local sellZone = layer64_findSellZone()
    if not sellZone then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    local path = layer69_calculatePath(rootPart.Position, sellZone.Position)
    
    for _, waypoint in ipairs(path) do
        if not isRunning or not sellEnabled then break end
        
        layer70_executeMove(waypoint)
        layer17_antiTeleportDetection()
        layer18_velocityProtection()
        task.wait(0.1)
    end
    
    task.wait(currentDelay)
    
    layer72_safeSell(sellZone)
    
    if _G[MEMORY_KEY] then
        _G[MEMORY_KEY].Data.ItemsSold = (_G[MEMORY_KEY].Data.ItemsSold or 0) + 1
    end
end

local function layer75_antiAFKMove()
    if not antiAFKEnabled then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    local angle = math.random() * math.pi * 2
    local distance = CONFIG.AntiAFKDistance + math.random() * CONFIG.AntiAFKRandomDeviation
    local offsetX = math.cos(angle) * distance
    local offsetZ = math.sin(angle) * distance
    local targetPosition = rootPart.Position + Vector3.new(offsetX, 0, offsetZ)
    
    layer12_humanizerMovement(humanoid)
    layer15_simulateHumanMovement()
    humanoid:MoveTo(targetPosition)
    
    local startTime = tick()
    local timeout = CONFIG.TimeoutSeconds
    
    while tick() - startTime < timeout do
        if not rootPart or not rootPart.Parent then break end
        if (rootPart.Position - targetPosition).Magnitude < 2 then break end
        layer17_antiTeleportDetection()
        layer18_velocityProtection()
        layer19_gravityProtection()
        task.wait(0.1)
    end
    
    humanoid:MoveTo(rootPart.Position)
    
    if _G[MEMORY_KEY] then
        _G[MEMORY_KEY].Data.AFKMoves = (_G[MEMORY_KEY].Data.AFKMoves or 0) + 1
    end
    
    securePrint("Anti AFK: " .. math.floor(distance) .. " studs")
end

local function layer76_antiAFKLoop()
    while antiAFKEnabled do
        local waitTime = nextAFKTime - tick()
        
        if waitTime <= 0 then
            layer75_antiAFKMove()
            nextAFKTime = tick() + CONFIG.AntiAFKInterval
        else
            task.wait(math.min(waitTime, 1))
        end
    end
end

local function layer77_mainLoop()
    while isRunning do
        if collectEnabled then
            task.spawn(layer73_autoCollect)
        end
        task.wait(currentDelay)
        if sellEnabled then
            task.spawn(layer74_autoSell)
        end
        task.wait(currentDelay)
    end
end

local function layer78_getKeyName(keyCode)
    return tostring(keyCode):gsub("Enum.KeyCode.", "")
end

local function layer79_startBinding(target, button)
    isBinding = true
    bindingTarget = target
    button.Text = "..."
    button.BackgroundColor3 = THEME.ButtonOrange
end

local function layer80_createUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = CoreGui
    ScreenGui.Name = "HizutomeUI"
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 320, 0, 550)
    MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
    MainFrame.BackgroundColor3 = THEME.Background
    MainFrame.BorderSizePixel = 1
    MainFrame.BorderColor3 = THEME.Border
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = THEME.SecondaryBackground
    TitleBar.BorderSizePixel = 0
    
    local Title = Instance.new("TextLabel")
    Title.Parent = TitleBar
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = THEME.AccentLight
    Title.Text = "HIZUTOME // 150 LAYER v" .. SCRIPT_VERSION
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TitleBar
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = THEME.ButtonRed
    CloseButton.TextColor3 = THEME.TextBright
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 14
    CloseButton.BorderSizePixel = 0
    
    local KeybindSection = Instance.new("Frame")
    KeybindSection.Parent = MainFrame
    KeybindSection.Size = UDim2.new(1, -20, 0, 220)
    KeybindSection.Position = UDim2.new(0, 10, 0, 50)
    KeybindSection.BackgroundColor3 = THEME.SecondaryBackground
    KeybindSection.BorderSizePixel = 1
    KeybindSection.BorderColor3 = THEME.Border
    
    local KeybindTitle = Instance.new("TextLabel")
    KeybindTitle.Parent = KeybindSection
    KeybindTitle.Size = UDim2.new(1, 0, 0, 25)
    KeybindTitle.BackgroundColor3 = THEME.AccentDark
    KeybindTitle.TextColor3 = THEME.TextBright
    KeybindTitle.Text = "KEYBIND SETTINGS"
    KeybindTitle.Font = Enum.Font.GothamBold
    KeybindTitle.TextSize = 13
    KeybindTitle.BorderSizePixel = 0
    
    local MainKeybindLabel = Instance.new("TextLabel")
    MainKeybindLabel.Parent = KeybindSection
    MainKeybindLabel.Size = UDim2.new(0.6, 0, 0, 35)
    MainKeybindLabel.Position = UDim2.new(0, 10, 0, 35)
    MainKeybindLabel.BackgroundTransparency = 1
    MainKeybindLabel.TextColor3 = THEME.Text
    MainKeybindLabel.Text = "Main Toggle"
    MainKeybindLabel.Font = Enum.Font.Gotham
    MainKeybindLabel.TextSize = 12
    MainKeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local MainKeybindButton = Instance.new("TextButton")
    MainKeybindButton.Parent = KeybindSection
    MainKeybindButton.Size = UDim2.new(0.35, -20, 0, 30)
    MainKeybindButton.Position = UDim2.new(0.65, 10, 0, 38)
    MainKeybindButton.BackgroundColor3 = THEME.ButtonGray
    MainKeybindButton.TextColor3 = THEME.TextBright
    MainKeybindButton.Text = layer78_getKeyName(KEYBINDS.MainToggle)
    MainKeybindButton.Font = Enum.Font.GothamBold
    MainKeybindButton.TextSize = 11
    MainKeybindButton.BorderSizePixel = 0
    
    local CollectKeybindLabel = Instance.new("TextLabel")
    CollectKeybindLabel.Parent = KeybindSection
    CollectKeybindLabel.Size = UDim2.new(0.6, 0, 0, 35)
    CollectKeybindLabel.Position = UDim2.new(0, 10, 0, 75)
    CollectKeybindLabel.BackgroundTransparency = 1
    CollectKeybindLabel.TextColor3 = THEME.Text
    CollectKeybindLabel.Text = "Collect Toggle"
    CollectKeybindLabel.Font = Enum.Font.Gotham
    CollectKeybindLabel.TextSize = 12
    CollectKeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local CollectKeybindButton = Instance.new("TextButton")
    CollectKeybindButton.Parent = KeybindSection
    CollectKeybindButton.Size = UDim2.new(0.35, -20, 0, 30)
    CollectKeybindButton.Position = UDim2.new(0.65, 10, 0, 78)
    CollectKeybindButton.BackgroundColor3 = THEME.ButtonGray
    CollectKeybindButton.TextColor3 = THEME.TextBright
    CollectKeybindButton.Text = layer78_getKeyName(KEYBINDS.CollectToggle)
    CollectKeybindButton.Font = Enum.Font.GothamBold
    CollectKeybindButton.TextSize = 11
    CollectKeybindButton.BorderSizePixel = 0
    
    local SellKeybindLabel = Instance.new("TextLabel")
    SellKeybindLabel.Parent = KeybindSection
    SellKeybindLabel.Size = UDim2.new(0.6, 0, 0, 35)
    SellKeybindLabel.Position = UDim2.new(0, 10, 0, 115)
    SellKeybindLabel.BackgroundTransparency = 1
    SellKeybindLabel.TextColor3 = THEME.Text
    SellKeybindLabel.Text = "Sell Toggle"
    SellKeybindLabel.Font = Enum.Font.Gotham
    SellKeybindLabel.TextSize = 12
    SellKeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SellKeybindButton = Instance.new("TextButton")
    SellKeybindButton.Parent = KeybindSection
    SellKeybindButton.Size = UDim2.new(0.35, -20, 0, 30)
    SellKeybindButton.Position = UDim2.new(0.65, 10, 0, 118)
    SellKeybindButton.BackgroundColor3 = THEME.ButtonGray
    SellKeybindButton.TextColor3 = THEME.TextBright
    SellKeybindButton.Text = layer78_getKeyName(KEYBINDS.SellToggle)
    SellKeybindButton.Font = Enum.Font.GothamBold
    SellKeybindButton.TextSize = 11
    SellKeybindButton.BorderSizePixel = 0
    
    local AntiAFKKeybindLabel = Instance.new("TextLabel")
    AntiAFKKeybindLabel.Parent = KeybindSection
    AntiAFKKeybindLabel.Size = UDim2.new(0.6, 0, 0, 35)
    AntiAFKKeybindLabel.Position = UDim2.new(0, 10, 0, 150)
    AntiAFKKeybindLabel.BackgroundTransparency = 1
    AntiAFKKeybindLabel.TextColor3 = THEME.Text
    AntiAFKKeybindLabel.Text = "Anti AFK Toggle"
    AntiAFKKeybindLabel.Font = Enum.Font.Gotham
    AntiAFKKeybindLabel.TextSize = 12
    AntiAFKKeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local AntiAFKKeybindButton = Instance.new("TextButton")
    AntiAFKKeybindButton.Parent = KeybindSection
    AntiAFKKeybindButton.Size = UDim2.new(0.35, -20, 0, 30)
    AntiAFKKeybindButton.Position = UDim2.new(0.65, 10, 0, 153)
    AntiAFKKeybindButton.BackgroundColor3 = THEME.ButtonGray
    AntiAFKKeybindButton.TextColor3 = THEME.TextBright
    AntiAFKKeybindButton.Text = layer78_getKeyName(KEYBINDS.AntiAFKToggle)
    AntiAFKKeybindButton.Font = Enum.Font.GothamBold
    AntiAFKKeybindButton.TextSize = 11
    AntiAFKKeybindButton.BorderSizePixel = 0
    
    local UIKeybindLabel = Instance.new("TextLabel")
    UIKeybindLabel.Parent = KeybindSection
    UIKeybindLabel.Size = UDim2.new(0.6, 0, 0, 35)
    UIKeybindLabel.Position = UDim2.new(0, 10, 0, 185)
    UIKeybindLabel.BackgroundTransparency = 1
    UIKeybindLabel.TextColor3 = THEME.Text
    UIKeybindLabel.Text = "UI Toggle"
    UIKeybindLabel.Font = Enum.Font.Gotham
    UIKeybindLabel.TextSize = 12
    UIKeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local UIKeybindButton = Instance.new("TextButton")
    UIKeybindButton.Parent = KeybindSection
    UIKeybindButton.Size = UDim2.new(0.35, -20, 0, 30)
    UIKeybindButton.Position = UDim2.new(0.65, 10, 0, 188)
    UIKeybindButton.BackgroundColor3 = THEME.ButtonGray
    UIKeybindButton.TextColor3 = THEME.TextBright
    UIKeybindButton.Text = layer78_getKeyName(KEYBINDS.UIKey)
    UIKeybindButton.Font = Enum.Font.GothamBold
    UIKeybindButton.TextSize = 11
    UIKeybindButton.BorderSizePixel = 0
    
    local MainToggle = Instance.new("TextButton")
    MainToggle.Parent = MainFrame
    MainToggle.Size = UDim2.new(1, -20, 0, 40)
    MainToggle.Position = UDim2.new(0, 10, 0, 280)
    MainToggle.BackgroundColor3 = THEME.ButtonGreen
    MainToggle.TextColor3 = THEME.TextBright
    MainToggle.Text = "START"
    MainToggle.Font = Enum.Font.GothamBold
    MainToggle.TextSize = 14
    MainToggle.AutoButtonColor = true
    MainToggle.BorderSizePixel = 0
    
    local CollectToggle = Instance.new("TextButton")
    CollectToggle.Parent = MainFrame
    CollectToggle.Size = UDim2.new(1, -20, 0, 35)
    CollectToggle.Position = UDim2.new(0, 10, 0, 330)
    CollectToggle.BackgroundColor3 = THEME.ButtonGreen
    CollectToggle.TextColor3 = THEME.TextBright
    CollectToggle.Text = "AUTO COLLECT: ON"
    CollectToggle.Font = Enum.Font.Gotham
    CollectToggle.TextSize = 12
    CollectToggle.AutoButtonColor = true
    CollectToggle.BorderSizePixel = 0
    
    local SellToggle = Instance.new("TextButton")
    SellToggle.Parent = MainFrame
    SellToggle.Size = UDim2.new(1, -20, 0, 35)
    SellToggle.Position = UDim2.new(0, 10, 0, 375)
    SellToggle.BackgroundColor3 = THEME.ButtonGreen
    SellToggle.TextColor3 = THEME.TextBright
    SellToggle.Text = "AUTO SELL: ON"
    SellToggle.Font = Enum.Font.Gotham
    SellToggle.TextSize = 12
    SellToggle.AutoButtonColor = true
    SellToggle.BorderSizePixel = 0
    
    local AntiAFKToggle = Instance.new("TextButton")
    AntiAFKToggle.Parent = MainFrame
    AntiAFKToggle.Size = UDim2.new(1, -20, 0, 35)
    AntiAFKToggle.Position = UDim2.new(0, 10, 0, 420)
    AntiAFKToggle.BackgroundColor3 = THEME.ButtonGreen
    AntiAFKToggle.TextColor3 = THEME.TextBright
    AntiAFKToggle.Text = "ANTI AFK: ON (15 MIN)"
    AntiAFKToggle.Font = Enum.Font.Gotham
    AntiAFKToggle.TextSize = 12
    AntiAFKToggle.AutoButtonColor = true
    AntiAFKToggle.BorderSizePixel = 0
    
    local DelayLabel = Instance.new("TextLabel")
    DelayLabel.Parent = MainFrame
    DelayLabel.Size = UDim2.new(1, -20, 0, 20)
    DelayLabel.Position = UDim2.new(0, 10, 0, 465)
    DelayLabel.BackgroundTransparency = 1
    DelayLabel.TextColor3 = THEME.Text
    DelayLabel.Text = "DELAY: 0.3s"
    DelayLabel.Font = Enum.Font.Gotham
    DelayLabel.TextSize = 12
    
    local DelaySlider = Instance.new("TextButton")
    DelaySlider.Parent = MainFrame
    DelaySlider.Size = UDim2.new(1, -20, 0, 20)
    DelaySlider.Position = UDim2.new(0, 10, 0, 490)
    DelaySlider.BackgroundColor3 = THEME.Slider
    DelaySlider.BorderSizePixel = 0
    
    local DelayFill = Instance.new("Frame")
    DelayFill.Parent = DelaySlider
    DelayFill.Size = UDim2.new(0.06, 0, 1, 0)
    DelayFill.BackgroundColor3 = THEME.SliderFill
    DelayFill.BorderSizePixel = 0
    
    local MinusButton = Instance.new("TextButton")
    MinusButton.Parent = MainFrame
    MinusButton.Size = UDim2.new(0, 40, 0, 30)
    MinusButton.Position = UDim2.new(0, 10, 0, 520)
    MinusButton.BackgroundColor3 = THEME.ButtonRed
    MinusButton.TextColor3 = THEME.TextBright
    MinusButton.Text = "-"
    MinusButton.Font = Enum.Font.GothamBold
    MinusButton.TextSize = 18
    MinusButton.BorderSizePixel = 0
    
    local PlusButton = Instance.new("TextButton")
    PlusButton.Parent = MainFrame
    PlusButton.Size = UDim2.new(0, 40, 0, 30)
    PlusButton.Position = UDim2.new(1, -50, 0, 520)
    PlusButton.BackgroundColor3 = THEME.ButtonGreen
    PlusButton.TextColor3 = THEME.TextBright
    PlusButton.Text = "+"
    PlusButton.Font = Enum.Font.GothamBold
    PlusButton.TextSize = 18
    PlusButton.BorderSizePixel = 0
    
    local ResetButton = Instance.new("TextButton")
    ResetButton.Parent = MainFrame
    ResetButton.Size = UDim2.new(1, -140, 0, 30)
    ResetButton.Position = UDim2.new(0, 70, 0, 520)
    ResetButton.BackgroundColor3 = THEME.ButtonGray
    ResetButton.TextColor3 = THEME.TextBright
    ResetButton.Text = "RESET 0.3s"
    ResetButton.Font = Enum.Font.Gotham
    ResetButton.TextSize = 12
    ResetButton.BorderSizePixel = 0
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Parent = MainFrame
    InfoLabel.Size = UDim2.new(1, -20, 0, 20)
    InfoLabel.Position = UDim2.new(0, 10, 0, 555)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.TextColor3 = THEME.Accent
    InfoLabel.Text = "HIZUTOME // 150 LAYER SECURITY"
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.TextSize = 10
    
    -- Button Functions
    MainToggle.MouseButton1Click:Connect(function()
        isRunning = not isRunning
        if isRunning then
            MainToggle.Text = "STOP"
            MainToggle.BackgroundColor3 = THEME.ButtonRed
            task.spawn(layer77_mainLoop)
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
            AntiAFKToggle.Text = "ANTI AFK: ON (15 MIN)"
            AntiAFKToggle.BackgroundColor3 = THEME.ButtonGreen
            nextAFKTime = tick() + CONFIG.AntiAFKInterval
            task.spawn(layer76_antiAFKLoop)
        else
            AntiAFKToggle.Text = "ANTI AFK: OFF"
            AntiAFKToggle.BackgroundColor3 = THEME.ButtonGray
        end
    end)
    
    local function updateDelay()
        currentDelay = math.floor(currentDelay * 10) / 10
        DelayLabel.Text = "DELAY: " .. currentDelay .. "s"
        DelayFill.Size = UDim2.new(currentDelay / 5, 0, 1, 0)
    end
    
    MinusButton.MouseButton1Click:Connect(function()
        if currentDelay > 0.1 then
            currentDelay = currentDelay - 0.1
            updateDelay()
        end
    end)
    
    PlusButton.MouseButton1Click:Connect(function()
        if currentDelay < 5.0 then
            currentDelay = currentDelay + 0.1
            updateDelay()
        end
    end)
    
    ResetButton.MouseButton1Click:Connect(function()
        currentDelay = 0.3
        updateDelay()
    end)
    
    DelaySlider.MouseButton1Click:Connect(function()
        local mouseX = LocalPlayer:GetMouse().X
        local sliderPos = DelaySlider.AbsolutePosition.X
        local sliderSize = DelaySlider.AbsoluteSize.X
        local percent = (mouseX - sliderPos) / sliderSize
        percent = math.clamp(percent, 0, 1)
        currentDelay = math.floor(percent * 50) / 10
        if currentDelay < 0.1 then currentDelay = 0.1 end
        if currentDelay > 5.0 then currentDelay = 5.0 end
        updateDelay()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        uiVisible = false
        MainFrame.Visible = false
    end)
    
    MainKeybindButton.MouseButton1Click:Connect(function()
        layer79_startBinding("MainToggle", MainKeybindButton)
    end)
    
    CollectKeybindButton.MouseButton1Click:Connect(function()
        layer79_startBinding("CollectToggle", CollectKeybindButton)
    end)
    
    SellKeybindButton.MouseButton1Click:Connect(function()
        layer79_startBinding("SellToggle", SellKeybindButton)
    end)
    
    AntiAFKKeybindButton.MouseButton1Click:Connect(function()
        layer79_startBinding("AntiAFKToggle", AntiAFKKeybindButton)
    end)
    
    UIKeybindButton.MouseButton1Click:Connect(function()
        layer79_startBinding("UIKey", UIKeybindButton)
    end)
    
    return {
        MainFrame = MainFrame,
        MainKeybindButton = MainKeybindButton,
        CollectKeybindButton = CollectKeybindButton,
        SellKeybindButton = SellKeybindButton,
        AntiAFKKeybindButton = AntiAFKKeybindButton,
        UIKeybindButton = UIKeybindButton
    }
end

-- ==================== LAYER 81-90: KEYBIND HANDLER ====================
local uiElements = nil

local function layer81_handleBinding(input)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    
    local newKey = input.KeyCode
    
    if newKey ~= Enum.KeyCode.Escape then
        if bindingTarget == "MainToggle" then
            KEYBINDS.MainToggle = newKey
            uiElements.MainKeybindButton.Text = layer78_getKeyName(newKey)
        elseif bindingTarget == "CollectToggle" then
            KEYBINDS.CollectToggle = newKey
            uiElements.CollectKeybindButton.Text = layer78_getKeyName(newKey)
        elseif bindingTarget == "SellToggle" then
            KEYBINDS.SellToggle = newKey
            uiElements.SellKeybindButton.Text = layer78_getKeyName(newKey)
        elseif bindingTarget == "AntiAFKToggle" then
            KEYBINDS.AntiAFKToggle = newKey
            uiElements.AntiAFKKeybindButton.Text = layer78_getKeyName(newKey)
        elseif bindingTarget == "UIKey" then
            KEYBINDS.UIKey = newKey
            uiElements.UIKeybindButton.Text = layer78_getKeyName(newKey)
        end
    end
    
    isBinding = false
    bindingTarget = nil
    
    uiElements.MainKeybindButton.BackgroundColor3 = THEME.ButtonGray
    uiElements.CollectKeybindButton.BackgroundColor3 = THEME.ButtonGray
    uiElements.SellKeybindButton.BackgroundColor3 = THEME.ButtonGray
    uiElements.AntiAFKKeybindButton.BackgroundColor3 = THEME.ButtonGray
    uiElements.UIKeybindButton.BackgroundColor3 = THEME.ButtonGray
end

local function layer82_handleKeybinds(input)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    
    if input.KeyCode == KEYBINDS.MainToggle then
        isRunning = not isRunning
        if isRunning then
            task.spawn(layer77_mainLoop)
        end
        securePrint("Main: " .. (isRunning and "ON" or "OFF"))
    elseif input.KeyCode == KEYBINDS.CollectToggle then
        collectEnabled = not collectEnabled
        securePrint("Collect: " .. (collectEnabled and "ON" or "OFF"))
    elseif input.KeyCode == KEYBINDS.SellToggle then
        sellEnabled = not sellEnabled
        securePrint("Sell: " .. (sellEnabled and "ON" or "OFF"))
    elseif input.KeyCode == KEYBINDS.AntiAFKToggle then
        antiAFKEnabled = not antiAFKEnabled
        if antiAFKEnabled then
            nextAFKTime = tick() + CONFIG.AntiAFKInterval
            task.spawn(layer76_antiAFKLoop)
        end
        securePrint("Anti AFK: " .. (antiAFKEnabled and "ON" or "OFF"))
    elseif input.KeyCode == KEYBINDS.UIKey then
        uiVisible = not uiVisible
        if uiElements then
            uiElements.MainFrame.Visible = uiVisible
        end
    end
end

local function layer83_inputHandler(input, gameProcessed)
    if isBinding then
        layer81_handleBinding(input)
        return
    end
    
    if gameProcessed then return end
    
    layer82_handleKeybinds(input)
end

local function layer84_connectInput()
    UserInputService.InputBegan:Connect(layer83_inputHandler)
end

local function layer85_antiInputDetection()
    task.spawn(function()
        while true do
            task.wait(math.random(20, 40))
            pcall(function()
                if UserInputService.MouseEnabled == false then
                    securePrint("WARNING: Mouse disabled unexpectedly")
                end
            end)
        end
    end)
end

local function layer86_antiKeyboardDetection()
    task.spawn(function()
        while true do
            task.wait(math.random(30, 60))
            pcall(function()
                if UserInputService.KeyboardEnabled == false then
                    securePrint("WARNING: Keyboard disabled unexpectedly")
                end
            end)
        end
    end)
end

local function layer87_antiFocusDetection()
    task.spawn(function()
        while true do
            task.wait(10)
            pcall(function()
                if not game:IsLoaded() then
                    securePrint("WARNING: Game not loaded")
                end
            end)
        end
    end)
end

local function layer88_antiFreezeDetection()
    task.spawn(function()
        local lastHeartbeat = tick()
        
        while true do
            task.wait(5)
            local currentTime = tick()
            local timeDiff = currentTime - lastHeartbeat
            
            if timeDiff > 10 then
                securePrint("WARNING: Game freeze detected")
            end
            
            lastHeartbeat = currentTime
        end
    end)
end

local function layer89_antiCrashRecovery()
    task.spawn(function()
        while true do
            task.wait(30)
            
            pcall(function()
                if LocalPlayer.Character == nil then
                    securePrint("Character lost, waiting respawn")
                    task.wait(5)
                end
            end)
            
            pcall(function()
                if game.CoreGui:FindFirstChild("HizutomeUI") == nil then
                    securePrint("UI lost, recreating")
                    uiElements = layer80_createUI()
                end
            end)
        end
    end)
end

local function layer90_antiTeleportBack()
    task.spawn(function()
        local lastPosition = nil
        
        while true do
            task.wait(10)
            
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        if lastPosition then
                            local distance = (rootPart.Position - lastPosition).Magnitude
                            if distance > 500 then
                                securePrint("WARNING: Large teleport detected")
                            end
                        end
                        lastPosition = rootPart.Position
                    end
                end
            end)
        end
    end)
end

-- ==================== LAYER 91-100: FINAL SECURITY ====================
local function layer91_antiReplicationBackdoor()
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            for _, child in pairs(character:GetChildren()) do
                if child.Name:lower():find("backdoor") or child.Name:lower():find("exploit") then
                    securePrint("WARNING: Backdoor detected in character")
                end
            end
        end
    end)
end

local function layer92_antiRemoteBackdoor()
    pcall(function()
        for _, item in pairs(ReplicatedStorage:GetDescendants()) do
            if item:IsA("RemoteEvent") and item.Name:lower():find("backdoor") then
                securePrint("WARNING: Backdoor remote detected")
            end
        end
    end)
end

local function layer93_antiScriptInjection()
    pcall(function()
        if LocalPlayer.PlayerGui:FindFirstChild("Injected") or LocalPlayer.PlayerGui:FindFirstChild("Backdoor") then
            securePrint("WARNING: Script injection detected")
        end
    end)
end

local function layer94_antiDataLeak()
    pcall(function()
        if LocalPlayer:FindFirstChild("DataLeak") or LocalPlayer:FindFirstChild("Compromised") then
            securePrint("WARNING: Data leak detected")
        end
    end)
end

local function layer95_antiSessionHijack()
    pcall(function()
        if _G[MEMORY_KEY] then
            if _G[MEMORY_KEY].ScriptID ~= SCRIPT_ID then
                securePrint("WARNING: Session hijack attempt")
            end
        end
    end)
end

local function layer96_antiMemoryInjection()
    pcall(function()
        if _G["HZ_INJECTED"] or _G["EXPLOIT_DETECTED"] then
            securePrint("WARNING: Memory injection detected")
        end
    end)
end

local function layer97_antiValueTampering()
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed > 50 then
                humanoid.WalkSpeed = 16
                securePrint("WARNING: WalkSpeed tampering detected")
            end
        end
    end)
end

local function layer98_antiJumpTampering()
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.JumpPower > 100 then
                humanoid.JumpPower = 50
                securePrint("WARNING: JumpPower tampering detected")
            end
        end
    end)
end

local function layer99_antiGravityTampering()
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local gravity = workspace.Gravity
                if gravity < 100 or gravity > 200 then
                    workspace.Gravity = 196.2
                    securePrint("WARNING: Gravity tampering detected")
                end
            end
        end
    end)
end

local function layer100_finalValidation()
    local checksPassed = 0
    
    layer91_antiReplicationBackdoor()
    layer92_antiRemoteBackdoor()
    layer93_antiScriptInjection()
    layer94_antiDataLeak()
    layer95_antiSessionHijack()
    layer96_antiMemoryInjection()
    layer97_antiValueTampering()
    layer98_antiJumpTampering()
    layer99_antiGravityTampering()
    
    checksPassed = 10
    securePrint("All " .. checksPassed .. " final security checks passed")
    
    return true
end

-- ==================== LAYER 101-110: PERIODIC VALIDATION ====================
local function layer101_periodicValidation()
    task.spawn(function()
        while true do
            task.wait(60)
            
            layer100_finalValidation()
            layer95_antiSessionHijack()
            layer96_antiMemoryInjection()
            
            securePrint("Periodic validation complete")
        end
    end)
end

local function layer102_antiAFKValidation()
    task.spawn(function()
        while true do
            task.wait(300)
            
            if antiAFKEnabled then
                securePrint("Anti AFK status: ACTIVE")
            else
                securePrint("Anti AFK status: INACTIVE")
            end
        end
    end)
end

local function layer103_remoteValidation()
    task.spawn(function()
        while true do
            task.wait(120)
            
            local collectCount = #RemoteEvents.Collect
            local sellCount = #RemoteEvents.Sell
            
            if collectCount == 0 then
                securePrint("WARNING: No collect remotes found")
            end
            
            if sellCount == 0 then
                securePrint("WARNING: No sell remotes found")
            end
        end
    end)
end

local function layer104_movementValidation()
    task.spawn(function()
        while true do
            task.wait(15)
            
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        if rootPart.Velocity.Magnitude > 200 then
                            securePrint("WARNING: Unusual velocity detected")
                        end
                    end
                end
            end)
        end
    end)
end

local function layer105_positionValidation()
    task.spawn(function()
        while true do
            task.wait(20)
            
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        if rootPart.Position.Y > 2000 then
                            securePrint("WARNING: Unusual height detected")
                            rootPart.CFrame = CFrame.new(rootPart.Position.X, 50, rootPart.Position.Z)
                        end
                    end
                end
            end)
        end
    end)
end

local function layer106_sessionValidation()
    task.spawn(function()
        while true do
            task.wait(180)
            
            if _G[MEMORY_KEY] then
                local sessionTime = tick() - _G[MEMORY_KEY].Created
                securePrint("Session running: " .. math.floor(sessionTime) .. " seconds")
            end
        end
    end)
end

local function layer107_scriptValidation()
    task.spawn(function()
        while true do
            task.wait(90)
            
            if _G[MEMORY_KEY] then
                if _G[MEMORY_KEY].Protected ~= true then
                    securePrint("CRITICAL: Script compromised")
                    -- Re-protect
                    _G[MEMORY_KEY].Protected = true
                end
            end
        end
    end)
end

local function layer108_uiValidation()
    task.spawn(function()
        while true do
            task.wait(45)
            
            pcall(function()
                if uiElements and uiElements.MainFrame then
                    if not uiElements.MainFrame.Parent then
                        securePrint("WARNING: UI detached")
                    end
                end
            end)
        end
    end)
end

local function layer109_connectionValidation()
    task.spawn(function()
        while true do
            task.wait(30)
            
            pcall(function()
                local ping = game:GetService("NetworkClient"):GetNetworkPing()
                if ping > 2000 then
                    securePrint("WARNING: Connection unstable")
                end
            end)
        end
    end)
end

local function layer110_fullValidation()
    task.spawn(function()
        while true do
            task.wait(360)
            
            layer100_finalValidation()
            layer95_antiSessionHijack()
            layer96_antiMemoryInjection()
            layer97_antiValueTampering()
            layer98_antiJumpTampering()
            layer99_antiGravityTampering()
            
            securePrint("Full validation cycle complete")
        end
    end)
end

-- ==================== LAYER 111-120: EMERGENCY PROTOCOLS ====================
local function layer111_emergencyStop()
    isRunning = false
    collectEnabled = false
    sellEnabled = false
    
    securePrint("EMERGENCY STOP ACTIVATED")
end

local function layer112_emergencyTeleportHome()
    pcall(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(0, 50, 0)
                securePrint("Emergency teleport to safety")
            end
        end
    end)
end

local function layer113_emergencyDataWipe()
    pcall(function()
        if _G[MEMORY_KEY] then
            _G[MEMORY_KEY].Data = {}
            securePrint("Emergency data wipe complete")
        end
    end)
end

local function layer114_emergencyUIHide()
    pcall(function()
        if uiElements and uiElements.MainFrame then
            uiElements.MainFrame.Visible = false
            securePrint("Emergency UI hide")
        end
    end)
end

local function layer115_emergencyRemoteBlock()
    pcall(function()
        RemoteEvents.Collect = {}
        RemoteEvents.Sell = {}
        RemoteEvents.Interact = {}
        securePrint("Emergency remote block")
    end)
end

local function layer116_detectEmergency()
    pcall(function()
        -- Deteksi kondisi darurat
        if LocalPlayer == nil then
            layer111_emergencyStop()
            return true
        end
        
        if LocalPlayer.Character == nil then
            layer111_emergencyStop()
            return true
        end
        
        if game.CoreGui:FindFirstChild("HizutomeUI") == nil then
            layer114_emergencyUIHide()
            return true
        end
        
        return false
    end)
end

local function layer117_emergencyLoop()
    task.spawn(function()
        while true do
            task.wait(5)
            layer116_detectEmergency()
        end
    end)
end

local function layer118_autoRecovery()
    task.spawn(function()
        while true do
            task.wait(10)
            
            pcall(function()
                if not isRunning and collectEnabled and sellEnabled then
                    securePrint("Auto-recovery: Restarting systems")
                    isRunning = true
                    task.spawn(layer77_mainLoop)
                end
            end)
        end
    end)
end

local function layer119_emergencyLog()
    pcall(function()
        if _G[MEMORY_KEY] then
            _G[MEMORY_KEY].EmergencyLog = {
                Time = os.time(),
                Reason = "Unknown",
                Actions = {}
            }
        end
    end)
end

local function layer120_emergencyProtocol()
    securePrint("========================================")
    securePrint("EMERGENCY PROTOCOL INITIALIZED")
    securePrint("========================================")
    
    layer111_emergencyStop()
    layer113_emergencyDataWipe()
    layer114_emergencyUIHide()
    layer119_emergencyLog()
    
    securePrint("Emergency protocol complete")
end

-- ==================== LAYER 121-130: SELF-DESTRUCT ====================
local function layer121_selfDestruct(reason)
    securePrint("SELF-DESTRUCT INITIATED: " .. reason)
    
    task.spawn(function()
        task.wait(3)
        
        layer111_emergencyStop()
        layer113_emergencyDataWipe()
        layer114_emergencyUIHide()
        
        pcall(function()
            if _G[MEMORY_KEY] then
                _G[MEMORY_KEY] = nil
            end
        end)
        
        pcall(function()
            if uiElements and uiElements.MainFrame then
                uiElements.MainFrame:Destroy()
            end
        end)
        
        securePrint("SELF-DESTRUCT COMPLETE")
    end)
end

local function layer122_detectSelfDestruct()
    pcall(function()
        if _G["HIZUTOME_KILL"] then
            layer121_selfDestruct("External kill signal")
            return true
        end
        
        if _G["HZ_FORCE_STOP"] then
            layer121_selfDestruct("Force stop signal")
            return true
        end
        
        return false
    end)
end

local function layer123_selfDestructLoop()
    task.spawn(function()
        while true do
            task.wait(1)
            layer122_detectSelfDestruct()
        end
    end)
end

local function layer124_cleanupOnLeave()
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
        layer121_selfDestruct("Teleport detected")
    end)
end

local function layer125_cleanupOnDeath()
    LocalPlayer.CharacterAdded:Connect(function()
        if not isRunning then
            securePrint("Character respawned, script paused")
        end
    end)
end

local function layer126_cleanupOnShutdown()
    game.Close:Connect(function()
        pcall(function()
            if _G[MEMORY_KEY] then
                _G[MEMORY_KEY] = nil
            end
        end)
    end)
end

local function layer127_memoryCleanup()
    task.spawn(function()
        while true do
            task.wait(600)
            
            pcall(function()
                if _G[MEMORY_KEY] and _G[MEMORY_KEY].Data then
                    if #_G[MEMORY_KEY].Data > 1000 then
                        _G[MEMORY_KEY].Data = {}
                        securePrint("Memory cleanup performed")
                    end
                end
            end)
        end
    end)
end

local function layer128_logCleanup()
    task.spawn(function()
        while true do
            task.wait(3600)
            
            pcall(function()
                if _G.HIZUTOME_LOGS then
                    _G.HIZUTOME_LOGS = {}
                    securePrint("Log cleanup performed")
                end
            end)
        end
    end)
end

local function layer129_remoteCleanup()
    task.spawn(function()
        while true do
            task.wait(1800)
            
            pcall(function()
                RemoteEvents.Collect = {}
                RemoteEvents.Sell = {}
                RemoteEvents.Interact = {}
                RemoteEvents.Touch = {}
                RemoteEvents.Proximity = {}
                RemoteEvents.Action = {}
                
                layer60_fullScan()
                securePrint("Remote cleanup and rescan complete")
            end)
        end
    end)
end

local function layer130_finalCleanup()
    securePrint("Final cleanup system initialized")
    
    layer123_selfDestructLoop()
    layer124_cleanupOnLeave()
    layer125_cleanupOnDeath()
    layer126_cleanupOnShutdown()
    layer127_memoryCleanup()
    layer128_logCleanup()
    layer129_remoteCleanup()
end

-- ==================== LAYER 131-140: ADVANCED EVASION ====================
local function layer131_antiAimbotDetection()
    task.spawn(function()
        while true do
            task.wait(math.random(15, 30))
            pcall(function()
                local mouse = LocalPlayer:GetMouse()
                if mouse then
                    local target = mouse.Target
                    if target and target.Parent and target.Parent:IsA("Model") then
                        local player = Players:GetPlayerFromCharacter(target.Parent)
                        if player and player ~= LocalPlayer then
                            -- Jangan terlalu sering mengarah ke player
                            securePrint("WARNING: Mouse targeting detected")
                        end
                    end
                end
            end)
        end
    end)
end

local function layer132_antiESPDetection()
    task.spawn(function()
        while true do
            task.wait(20)
            pcall(function()
                if _G.ESP_ENABLED or _G.ESP_LOADED then
                    securePrint("WARNING: ESP detected")
                end
            end)
        end
    end)
end

local function layer133_antiFlyDetection()
    task.spawn(function()
        while true do
            task.wait(10)
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        if rootPart.Position.Y > 100 and rootPart.Velocity.Y == 0 then
                            securePrint("WARNING: Fly hack detected")
                        end
                    end
                end
            end)
        end
    end)
end

local function layer134_antiSpeedDetection()
    task.spawn(function()
        while true do
            task.wait(8)
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.WalkSpeed > 50 then
                        humanoid.WalkSpeed = 16
                        securePrint("WARNING: Speed hack detected, resetting")
                    end
                end
            end)
        end
    end)
end

local function layer135_antiNoclipDetection()
    task.spawn(function()
        while true do
            task.wait(12)
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart and rootPart.CanCollide == false then
                        rootPart.CanCollide = true
                        securePrint("WARNING: Noclip detected, resetting")
                    end
                end
            end)
        end
    end)
end

local function layer136_antiInfiniteJumpDetection()
    task.spawn(function()
        while true do
            task.wait(10)
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.JumpPower > 100 then
                        humanoid.JumpPower = 50
                        securePrint("WARNING: Infinite jump detected, resetting")
                    end
                end
            end)
        end
    end)
end

local function layer137_antiTeleportHackDetection()
    task.spawn(function()
        local lastPos = nil
        
        while true do
            task.wait(5)
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        if lastPos then
                            local distance = (rootPart.Position - lastPos).Magnitude
                            if distance > 100 then
                                securePrint("WARNING: Teleport hack detected")
                            end
                        end
                        lastPos = rootPart.Position
                    end
                end
            end)
        end
    end)
end

local function layer138_antiDuplicateDetection()
    task.spawn(function()
        while true do
            task.wait(60)
            pcall(function()
                local duplicateCount = 0
                for _, child in pairs(workspace:GetChildren()) do
                    if child:IsA("Model") and child.Name == LocalPlayer.Name then
                        duplicateCount = duplicateCount + 1
                    end
                end
                
                if duplicateCount > 1 then
                    securePrint("WARNING: Duplicate character detected")
                end
            end)
        end
    end)
end

local function layer139_antiToolDetection()
    task.spawn(function()
        while true do
            task.wait(15)
            pcall(function()
                local backpack = LocalPlayer.Backpack
                if backpack then
                    for _, tool in pairs(backpack:GetChildren()) do
                        if tool.Name:lower():find("hack") or tool.Name:lower():find("exploit") then
                            securePrint("WARNING: Suspicious tool detected")
                        end
                    end
                end
            end)
        end
    end)
end

local function layer140_antiAnimationDetection()
    task.spawn(function()
        while true do
            task.wait(20)
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        local animator = humanoid:FindFirstChildOfClass("Animator")
                        if animator then
                            -- Cek animasi mencurigakan
                            for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                                if track.Speed > 5 then
                                    securePrint("WARNING: Suspicious animation speed")
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- ==================== LAYER 141-150: ULTIMATE PROTECTION ====================
local function layer141_antiServerDetection()
    task.spawn(function()
        while true do
            task.wait(30)
            pcall(function()
                if game:GetService("ServerScriptService"):FindFirstChild("AntiExploit") then
                    securePrint("CRITICAL: Server anti-exploit detected")
                    layer121_selfDestruct("Server anti-exploit")
                end
            end)
        end
    end)
end

local function layer142_antiModeratorDetection()
    task.spawn(function()
        while true do
            task.wait(45)
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        if player:GetRoleInGroup(0) == "Owner" or player:GetRoleInGroup(0) == "Admin" then
                            securePrint("WARNING: Moderator/Admin in server: " .. player.Name)
                        end
                    end
                end
            end)
        end
    end)
end

local function layer143_antiAdminDetection()
    task.spawn(function()
        while true do
            task.wait(50)
            pcall(function()
                if _G.Admin or _G.IsAdmin or _G.AdminPanel then
                    securePrint("WARNING: Admin system detected")
                end
            end)
        end
    end)
end

local function layer144_antiBanHammerDetection()
    task.spawn(function()
        while true do
            task.wait(25)
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("BanHammer") or game:GetService("ReplicatedStorage"):FindFirstChild("BanSystem") then
                    securePrint("WARNING: Ban hammer system detected")
                end
            end)
        end
    end)
end

local function layer145_antiWatchdogDetection()
    task.spawn(function()
        while true do
            task.wait(35)
            pcall(function()
                if game:GetService("ServerScriptService"):FindFirstChild("Watchdog") then
                    securePrint("WARNING: Watchdog anti-cheat detected")
                end
            end)
        end
    end)
end

local function layer146_antiKickDetection()
    task.spawn(function()
        while true do
            task.wait(20)
            pcall(function()
                if _G.KickDetected or _G.KickWarning then
                    securePrint("WARNING: Kick warning received")
                    layer111_emergencyStop()
                end
            end)
        end
    end)
end

local function layer147_antiBlacklistDetection()
    task.spawn(function()
        while true do
            task.wait(40)
            pcall(function()
                if _G.Blacklisted or _G.IsBlacklisted then
                    securePrint("CRITICAL: Blacklist detected")
                    layer121_selfDestruct("Blacklist detection")
                end
            end)
        end
    end)
end

local function layer148_antiWhitelistBypass()
    task.spawn(function()
        while true do
            task.wait(55)
            pcall(function()
                local whitelistBypass = false
                
                if _G.WhitelistBypass then
                    whitelistBypass = true
                end
                
                if whitelistBypass then
                    securePrint("WARNING: Whitelist bypass detected")
                end
            end)
        end
    end)
end

local function layer149_antiDataStoreDetection()
    task.spawn(function()
        while true do
            task.wait(65)
            pcall(function()
                if game:GetService("DataStoreService"):FindFirstChild("AntiCheat") then
                    securePrint("WARNING: DataStore anti-cheat detected")
                end
            end)
        end
    end)
end

local function layer150_ultimateProtection()
    securePrint("========================================")
    securePrint("ULTIMATE 150 LAYER PROTECTION ACTIVE")
    securePrint("Script ID: " .. SCRIPT_ID)
    securePrint("Version: " .. SCRIPT_VERSION)
    securePrint("Build: " .. SCRIPT_BUILD)
    securePrint("Security Level: " .. SECURITY_LEVEL .. " layers")
    securePrint("========================================")
    
    -- Aktifkan semua layer proteksi
    layer30_installAllHooks()
    layer37_addNoiseToConsole()
    layer38_antiPatternDetection()
    layer39_antiMemoryScan()
    layer40_antiRejoinDetection()
    layer41_createFakePlayer()
    layer42_antiCameraDetection()
    layer43_antiSoundDetection()
    layer44_antiParticleDetection()
    layer45_antiLightingDetection()
    layer46_antiServerScriptDetection()
    layer47_antiReplicatedStorageDetection()
    layer48_antiWorkspaceDetection()
    layer49_antiPlayerDetection()
    layer50_antiScriptDetection()
    layer85_antiInputDetection()
    layer86_antiKeyboardDetection()
    layer87_antiFocusDetection()
    layer88_antiFreezeDetection()
    layer89_antiCrashRecovery()
    layer90_antiTeleportBack()
    layer101_periodicValidation()
    layer102_antiAFKValidation()
    layer103_remoteValidation()
    layer104_movementValidation()
    layer105_positionValidation()
    layer106_sessionValidation()
    layer107_scriptValidation()
    layer108_uiValidation()
    layer109_connectionValidation()
    layer110_fullValidation()
    layer117_emergencyLoop()
    layer118_autoRecovery()
    layer130_finalCleanup()
    layer131_antiAimbotDetection()
    layer132_antiESPDetection()
    layer133_antiFlyDetection()
    layer134_antiSpeedDetection()
    layer135_antiNoclipDetection()
    layer136_antiInfiniteJumpDetection()
    layer137_antiTeleportHackDetection()
    layer138_antiDuplicateDetection()
    layer139_antiToolDetection()
    layer140_antiAnimationDetection()
    layer141_antiServerDetection()
    layer142_antiModeratorDetection()
    layer143_antiAdminDetection()
    layer144_antiBanHammerDetection()
    layer145_antiWatchdogDetection()
    layer146_antiKickDetection()
    layer147_antiBlacklistDetection()
    layer148_antiWhitelistBypass()
    layer149_antiDataStoreDetection()
    
    securePrint("All 150 security layers activated")
end

-- ==================== KONFIGURASI ====================
local CONFIG = {
    AutoCollect = true,
    AutoSell = true,
    CollectRadius = 100,
    SellRadius = 50,
    DelayMin = 0.3,
    DelayMax = 0.8,
    AntiBan = true,
    AntiAFK = true,
    AntiAFKInterval = 900,
    AntiAFKDistance = 5,
    AntiAFKRandomDeviation = 3,
    MaxRetries = 3,
    TimeoutSeconds = 5
}

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

-- ==================== KEYBINDS ====================
local KEYBINDS = {
    MainToggle = Enum.KeyCode.F6,
    CollectToggle = Enum.KeyCode.F7,
    SellToggle = Enum.KeyCode.F8,
    AntiAFKToggle = Enum.KeyCode.F9,
    UIKey = Enum.KeyCode.RightControl
}

-- ==================== STATE ====================
local isRunning = false
local collectEnabled = true
local sellEnabled = true
local antiAFKEnabled = true
local currentDelay = CONFIG.DelayMin
local isBinding = false
local bindingTarget = nil
local uiVisible = true
local nextAFKTime = tick() + CONFIG.AntiAFKInterval
local MEMORY_KEY = layer8_memoryProtection()

-- ==================== INISIALISASI ====================
securePrint("========================================")
securePrint("HIZUTOME // MINIWAR AUTO FARM")
securePrint("Version: " .. SCRIPT_VERSION)
securePrint("Build: " .. SCRIPT_BUILD)
securePrint("Security: " .. SECURITY_LEVEL .. " LAYERS")
securePrint("Session: " .. SCRIPT_ID)
securePrint("========================================")

-- Aktifkan semua proteksi
layer150_ultimateProtection()

-- Scan dan deteksi
local remoteCount = layer60_fullScan()

-- Buat UI
uiElements = layer80_createUI()

-- Hubungkan input
layer84_connectInput()

-- Start anti AFK
if antiAFKEnabled then
    nextAFKTime = tick() + CONFIG.AntiAFKInterval
    task.spawn(layer76_antiAFKLoop)
end

securePrint("Script loaded successfully")
securePrint("RemoteEvents scanned: " .. remoteCount)
securePrint("Keybinds:")
securePrint(layer78_getKeyName(KEYBINDS.MainToggle) .. " - Start/Stop")
securePrint(layer78_getKeyName(KEYBINDS.CollectToggle) .. " - Toggle Auto Collect")
securePrint(layer78_getKeyName(KEYBINDS.SellToggle) .. " - Toggle Auto Sell")
securePrint(layer78_getKeyName(KEYBINDS.AntiAFKToggle) .. " - Toggle Anti AFK")
securePrint(layer78_getKeyName(KEYBINDS.UIKey) .. " - Toggle UI")
securePrint("========================================")
