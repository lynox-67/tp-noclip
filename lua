local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local isTeleporting = false
local noclipEnabled = false
local noclipConn = nil

local fastStealOn = false
local fastStealLoop = nil
local fastStealConn = nil

local function getCharacter()
    local char = LocalPlayer.Character
    if not char or not char.Parent then
        char = LocalPlayer.CharacterAdded:Wait()
    end
    return char
end

local function getMyPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in ipairs(plots:GetChildren()) do
        local label = plot:FindFirstChild("PlotSign")
            and plot.PlotSign:FindFirstChild("SurfaceGui")
            and plot.PlotSign.SurfaceGui:FindFirstChild("Frame")
            and plot.PlotSign.SurfaceGui.Frame:FindFirstChild("TextLabel")
        if label then
            local t = (label.ContentText or label.Text or "")
            if t:find(LocalPlayer.DisplayName) and t:find("Base") then
                return plot
            end
        end
    end
    return nil
end

local function getDeliveryHitbox()
    local myPlot = getMyPlot()
    if not myPlot then return nil end
    local delivery = myPlot:FindFirstChild("DeliveryHitbox") or myPlot:FindFirstChild("DeliveryHitbox", true)
    if delivery and delivery:IsA("BasePart") then
        return delivery
    end
    return nil
end

local function setNoclip(on)
    noclipEnabled = on
    if on then
        if noclipConn then noclipConn:Disconnect() end
        noclipConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

local function shortTeleportFreezeCamera(targetCF, duration)
    if isTeleporting then return end
    isTeleporting = true
    duration = math.clamp(duration or 0.25, 0.1, 0.5)

    local character = getCharacter()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then isTeleporting = false return end

    local camera = workspace.CurrentCamera
    if not camera then isTeleporting = false return end

    local originalCF = hrp.CFrame
    local originalCamCFrame = camera.CFrame

    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = originalCamCFrame
    hrp.CFrame = targetCF
    task.wait(duration)
    hrp.CFrame = originalCF

    local hum = character:FindFirstChildOfClass("Humanoid")
    if hum then
        camera.CameraSubject = hum
        camera.CameraType = Enum.CameraType.Custom
    end

    isTeleporting = false
end

local function doInstantSteal()
    local hrp = getCharacter():FindFirstChild("HumanoidRootPart")
    local delivery = getDeliveryHitbox()
    if not hrp or not delivery then return end
    local targetCF = delivery.CFrame + delivery.CFrame.LookVector * 3 + Vector3.new(0, 3, 0)
    shortTeleportFreezeCamera(targetCF, 0.25)
end

local function doForwardTP()
    local hrp = getCharacter():FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 8
    end
end

local function patchPrompt(prompt)
    if prompt:IsA("ProximityPrompt") and prompt.HoldDuration > 0.01 then
        prompt.HoldDuration = 0.01
    end
end

local function setFastSteal(on)
    fastStealOn = on

    if on then
        fastStealLoop = task.spawn(function()
            while fastStealOn do
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        patchPrompt(obj)
                    end
                end
                task.wait(0.08)
            end
        end)

        fastStealConn = workspace.DescendantAdded:Connect(function(obj)
            if fastStealOn and obj:IsA("ProximityPrompt") then
                patchPrompt(obj)
            end
        end)
    else
        if fastStealConn then fastStealConn:Disconnect() fastStealConn = nil end
    end
end

-- ================= UI =================

local function createUI()
    local guiParent = game:GetService("CoreGui")

    local old = guiParent:FindFirstChild("Lynox_Hub_UI")
    if old then old:Destroy() end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Lynox_Hub_UI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = guiParent

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 230, 0, 225)
    mainFrame.Position = UDim2.new(0.68, -115, 0.55, -112)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15,16,24)

    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,18)

    local header = Instance.new("Frame", mainFrame)
    header.Size = UDim2.new(1,0,0,40)
    header.BackgroundColor3 = Color3.fromRGB(25,26,38)
    Instance.new("UICorner", header).CornerRadius = UDim.new(0,18)

    local title = Instance.new("TextLabel", header)
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0,12,0,0)
    title.Size = UDim2.new(1,-40,1,0)
    title.Font = Enum.Font.GothamBold
    title.Text = "Lynox Hub"
    title.TextSize = 15
    title.TextColor3 = Color3.new(1,1,1)
    title.TextXAlignment = Enum.TextXAlignment.Left

    local subtitle = Instance.new("TextLabel", header)
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0,12,0,18)
    subtitle.Size = UDim2.new(1,-40,1,0)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = "Lynox"
    subtitle.TextSize = 11
    subtitle.TextColor3 = Color3.fromRGB(180,190,240)
    subtitle.TextXAlignment = Enum.TextXAlignment.Left

    local body = Instance.new("Frame", mainFrame)
    body.Size = UDim2.new(1,-20,1,-58)
    body.Position = UDim2.new(0,10,0,46)
    body.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", body)
    layout.Padding = UDim.new(0,6)

    local function makeButton(text, color, textColor)
        local b = Instance.new("TextButton", body)
        b.Size = UDim2.new(1,0,0,34)
        b.BackgroundColor3 = color
        b.Text = text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 14
        b.TextColor3 = textColor or Color3.new(1,1,1)
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
        return b
    end

    makeButton("INSTANT STEAL", Color3.fromRGB(90,155,255)).MouseButton1Click:Connect(doInstantSteal)
    makeButton("TP FORWARD", Color3.fromRGB(135,215,170), Color3.fromRGB(20,25,25)).MouseButton1Click:Connect(doForwardTP)

    local noclipBtn = makeButton("NOCLIP: OFF", Color3.fromRGB(110,95,170))
    noclipBtn.MouseButton1Click:Connect(function()
        setNoclip(not noclipEnabled)
        noclipBtn.Text = noclipEnabled and "NOCLIP: ON" or "NOCLIP: OFF"
    end)

    local fastBtn = makeButton("FAST STEAL: OFF", Color3.fromRGB(140,130,150))
    fastBtn.MouseButton1Click:Connect(function()
        setFastSteal(not fastStealOn)
        fastBtn.Text = fastStealOn and "FAST STEAL: ON" or "FAST STEAL: OFF"
    end)
end

createUI()
