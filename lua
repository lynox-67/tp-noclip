local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Update character reference
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Config
local Config = {
    Speed = 200,  -- High speed for fast TP and collection
    CollectDistance = 50,  -- Distance to detect brainrots
    BasePosition = nil  -- Will auto-detect base
}

-- Find base position (assume bases are in Workspace.Bases or player bases)
local function findBase()
    -- Common base folder names in such games: "Bases", "Plots", "PlayerBases"
    for _, folder in pairs(Workspace:GetChildren()) do
        if folder.Name:lower():find("base") or folder.Name:lower():find("plot") then
            local myBase = folder:FindFirstChild(LocalPlayer.Name)
            if myBase then
                Config.BasePosition = myBase.PrimaryPart or myBase:FindFirstChild("Spawn") or myBase:FindFirstChildOfClass("Part")
                if Config.BasePosition then
                    Config.BasePosition = Config.BasePosition.Position
                    return true
                end
            end
        end
    end
    -- Fallback: assume safe zone at Vector3(0, 50, 0) or find highest safe platform
    Config.BasePosition = Vector3.new(0, 50, 0)
    return false
end

findBase()

-- High speed for mobility
Humanoid.WalkSpeed = Config.Speed

-- Teleport function with tween for smoothness (anti-detection)
local function tweenTo(position, duration)
    duration = duration or 0.5
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(RootPart, tweenInfo, {CFrame = CFrame.new(position)})
    tween:Play()
    tween.Completed:Wait()
end

-- Collect brainrot function
local function collectBrainrot(brainrot)
    if brainrot and brainrot.Parent then
        local pos = brainrot.Position
        tweenTo(pos)
        wait(0.1)  -- Touch delay
        firetouchinterest(RootPart, brainrot, 0)  -- Touch start
        wait()
        firetouchinterest(RootPart, brainrot, 1)  -- Touch end
        print("Lynox Hub: Collected Celestial Brainrot!")
    end
end

-- Main loop: Scan for Celestial Brainrots
local function scanBrainrots()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("MeshPart") then
            -- Detect Celestial: Check name patterns or attributes (common: "Celestial", rarity value, glow effect)
            local name = obj.Name:lower()
            local hasCelestial = name:find("celestial") or name:find("god") or name:find("secret") or 
                                 (obj:FindFirstChild("Rarity") and obj.Rarity.Value == "Celestial") or
                                 obj.Material == Enum.Material.Neon  -- Glowy rare ones

            if hasCelestial and (RootPart.Position - obj.Position).Magnitude < Config.CollectDistance then
                print("Lynox Hub: Celestial Brainrot detected! Collecting...")
                collectBrainrot(obj)
                
                -- Goto Base after pickup
                if Config.BasePosition then
                    print("Lynox Hub: Returning to base...")
                    tweenTo(Config.BasePosition + Vector3.new(0, 10, 0))
                end
                break  -- One at a time
            end
        end
    end
end

-- Run scanner every frame
RunService.Heartbeat:Connect(scanBrainrots)

-- Re-find base periodically
spawn(function()
    while true do
        wait(30)
        findBase()
    end
end)

print("🧠 TikTok Lynox Hub Loaded! Auto Celestial Collector + Auto Base Return Active 🏃‍♂️🌊")
print("Game: https://www.roblox.com/es/games/131623223084840/Escape-Tsunami-For-Brainrots")
print("Toggle: Manually disable by setting Humanoid.WalkSpeed = 16")

-- Anti-detection: Randomize speed slightly
spawn(function()
    while true do
        wait(math.random(5, 15))
        Humanoid.WalkSpeed = Config.Speed + math.random(-10, 10)
    end
end)
