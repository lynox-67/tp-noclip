-- =========================================
-- 🌌 LYN0X HUB | CELESTIAL FAST DETECTOR
-- 🎵 TikTok: Lynox Hub
-- =========================================

-- SERVICES
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- PLAYER
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local Camera = Workspace.CurrentCamera

-- CONFIG
local CELESTIAL_KEYWORDS = {"celestial", "brainrot"}
local BASE_NAME = "Base"
local GRAB_KEY = Enum.KeyCode.E
local GRAB_DISTANCE = 10

-- UI ROOT
local gui = Instance.new("ScreenGui")
gui.Name = "LynoxHubUI"
gui.ResetOnSpawn = false
gui.Parent = Player.PlayerGui

-- TITLE
local title = Instance.new("TextLabel", gui)
title.Size = UDim2.fromScale(0.6, 0.07)
title.Position = UDim2.fromScale(0.2, 0.01)
title.BackgroundTransparency = 1
title.Text = "🌌 Lynox Hub"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(180,0,255)

-- ALERT
local alert = Instance.new("TextLabel", gui)
alert.Size = UDim2.fromScale(0.65, 0.15)
alert.Position = UDim2.fromScale(0.175, 0.1)
alert.BackgroundColor3 = Color3.fromRGB(120,0,180)
alert.TextColor3 = Color3.new(1,1,1)
alert.Font = Enum.Font.GothamBold
alert.TextScaled = true
alert.TextWrapped = true
alert.Visible = false
alert.TextStrokeTransparency = 0.6

-- BUTTON BASE
local btnBase = Instance.new("TextButton", gui)
btnBase.Size = UDim2.fromScale(0.22, 0.09)
btnBase.Position = UDim2.fromScale(0.39, 0.27)
btnBase.Text = "🏠 IR A BASE"
btnBase.Font = Enum.Font.GothamBold
btnBase.TextScaled = true
btnBase.BackgroundColor3 = Color3.fromRGB(0,170,255)
btnBase.TextColor3 = Color3.new(1,1,1)
btnBase.Visible = false

-- CREDIT
local credit = Instance.new("TextLabel", gui)
credit.Size = UDim2.fromScale(0.4, 0.05)
credit.Position = UDim2.fromScale(0.3, 0.93)
credit.BackgroundTransparency = 1
credit.Text = "🎵 TikTok: Lynox Hub"
credit.Font = Enum.Font.Gotham
credit.TextScaled = true
credit.TextColor3 = Color3.fromRGB(200,200,200)
credit.TextStrokeTransparency = 0.6
credit.TextStrokeColor3 = Color3.fromRGB(140,0,200)

-- SOUND
local sound = Instance.new("Sound", gui)
sound.SoundId = "rbxassetid://9118823101"
sound.Volume = 1

-- ARROW
local arrow = Instance.new("BillboardGui")
arrow.Size = UDim2.fromScale(2,2)
arrow.AlwaysOnTop = true
arrow.Enabled = false

local arrowImg = Instance.new("ImageLabel", arrow)
arrowImg.Size = UDim2.fromScale(1,1)
arrowImg.BackgroundTransparency = 1
arrowImg.Image = "rbxassetid://6031094678"

-- FUNCTIONS
local function isCelestial(obj)
	for _,k in ipairs(CELESTIAL_KEYWORDS) do
		if string.find(string.lower(obj.Name), k) then
			return true
		end
	end
	return false
end

local function highlight(obj)
	if obj:FindFirstChild("LynoxHL") then return end
	local hl = Instance.new("Highlight")
	hl.Name = "LynoxHL"
	hl.FillColor = Color3.fromRGB(180,0,255)
	hl.OutlineColor = Color3.new(1,1,1)
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = obj
end

local function gotoBase()
	local base = Workspace:FindFirstChild(BASE_NAME, true)
	if base and base:IsA("BasePart") then
		HRP.CFrame = base.CFrame + Vector3.new(0,5,0)
	end
end
btnBase.MouseButton1Click:Connect(gotoBase)

-- TRACK CELESTIAL
local currentCelestial = nil

-- FAST GRAB UI (NO AUTO)
local function updateGrabPrompt()
	if not currentCelestial or not currentCelestial.Parent then
		alert.Visible = false
		return
	end
	local dist = (HRP.Position - currentCelestial.Position).Magnitude
	if dist <= GRAB_DISTANCE then
		alert.Text = "⚡ PRESIONA ["..GRAB_KEY.Name.."] PARA AGARRAR ⚡\n🌌 "..currentCelestial.Name
		alert.Visible = true
	end
end

RunService.RenderStepped:Connect(updateGrabPrompt)

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == GRAB_KEY and currentCelestial then
		-- Aquí NO se dispara ningún Remote
		-- El agarre lo valida el juego al presionar la tecla
	end
end)

-- DETECTOR
Workspace.DescendantAdded:Connect(function(obj)
	if (obj:IsA("BasePart") or obj:IsA("Model")) and isCelestial(obj) then
		currentCelestial = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj

		alert.Text = "🌌 CELESTIAL DETECTADO 🌌\n📦 "..obj.Name
		alert.Visible = true
		btnBase.Visible = true
		sound:Play()

		highlight(obj)

		arrow.Parent = currentCelestial
		arrow.Enabled = true
	end
end)

print("✅ Lynox Hub FULL cargado correctamente")
