--====================================================
-- LYNOX ✖ MACABRO | HUB 1 - KEY SYSTEM
-- REQUIERE KEY ANTES DE EJECUTAR HUB 2
--====================================================

-- HUB 2 (EL REAL)
local HUB_2_URL = "https://raw.githubusercontent.com/A0WTGFjaGecc2k42wP0PZAbQphqh/Contact/refs/heads/main/OrzlxZ44HubOwnKQenGRSVztS5ndNb.lua"

-- TIEMPOS
local HOUR = 3600
local DAY  = 86400

-- KEYS + DURACIÓN (COLLAB LYNOX ✖ MACABRO)
local KEYS = {
    -- 30 KEYS | 7 DÍAS
    ["LYNOXxMACABRO-7D-01"]=7*DAY, ["LYNOXxMACABRO-7D-02"]=7*DAY,
    ["LYNOXxMACABRO-7D-03"]=7*DAY, ["LYNOXxMACABRO-7D-04"]=7*DAY,
    ["LYNOXxMACABRO-7D-05"]=7*DAY, ["LYNOXxMACABRO-7D-06"]=7*DAY,
    ["LYNOXxMACABRO-7D-07"]=7*DAY, ["LYNOXxMACABRO-7D-08"]=7*DAY,
    ["LYNOXxMACABRO-7D-09"]=7*DAY, ["LYNOXxMACABRO-7D-10"]=7*DAY,
    ["LYNOXxMACABRO-7D-11"]=7*DAY, ["LYNOXxMACABRO-7D-12"]=7*DAY,
    ["LYNOXxMACABRO-7D-13"]=7*DAY, ["LYNOXxMACABRO-7D-14"]=7*DAY,
    ["LYNOXxMACABRO-7D-15"]=7*DAY, ["LYNOXxMACABRO-7D-16"]=7*DAY,
    ["LYNOXxMACABRO-7D-17"]=7*DAY, ["LYNOXxMACABRO-7D-18"]=7*DAY,
    ["LYNOXxMACABRO-7D-19"]=7*DAY, ["LYNOXxMACABRO-7D-20"]=7*DAY,
    ["LYNOXxMACABRO-7D-21"]=7*DAY, ["LYNOXxMACABRO-7D-22"]=7*DAY,
    ["LYNOXxMACABRO-7D-23"]=7*DAY, ["LYNOXxMACABRO-7D-24"]=7*DAY,
    ["LYNOXxMACABRO-7D-25"]=7*DAY, ["LYNOXxMACABRO-7D-26"]=7*DAY,
    ["LYNOXxMACABRO-7D-27"]=7*DAY, ["LYNOXxMACABRO-7D-28"]=7*DAY,
    ["LYNOXxMACABRO-7D-29"]=7*DAY, ["LYNOXxMACABRO-7D-30"]=7*DAY,

    -- TRIAL | 10 HORAS
    ["LYNOXxMACABRO-TRIAL-10H-A"]=10*HOUR,
    ["LYNOXxMACABRO-TRIAL-10H-B"]=10*HOUR,

    -- ESPECIALES
    ["LYNOXxMACABRO-2H"]=2*HOUR,
    ["LYNOXxMACABRO-5H"]=5*HOUR,
    ["LYNOXxMACABRO-8H"]=8*HOUR,
}

-- ARCHIVO LOCAL (GUARDA EXPIRACIÓN)
local FILE = "LYNOX_x_MACABRO.exp"

local function now()
    return os.time()
end

--====================================================
-- GUI
--====================================================
local Players = game:GetService("Players")
local player  = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "LYNOX_MACABRO_KEY"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,360,0,190)
frame.Position = UDim2.new(0.5,-180,0.5,-95)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,42)
title.Text = "LYNOX ✖ MACABRO"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local subtitle = Instance.new("TextLabel", frame)
subtitle.Size = UDim2.new(1,0,0,24)
subtitle.Position = UDim2.new(0,0,0.22,0)
subtitle.Text = "KEY SYSTEM"
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(200,200,200)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.9,0,0,36)
box.Position = UDim2.new(0.05,0,0.45,0)
box.PlaceholderText = "INGRESA TU KEY (LYNOX ✖ MACABRO)"
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextSize = 14
box.BackgroundColor3 = Color3.fromRGB(30,30,30)
box.TextColor3 = Color3.new(1,1,1)
box.ClearTextOnFocus = false

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.9,0,0,36)
btn.Position = UDim2.new(0.05,0,0.7,0)
btn.Text = "VALIDAR KEY"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.BackgroundColor3 = Color3.fromRGB(170,0,0)
btn.TextColor3 = Color3.new(1,1,1)

--====================================================
-- VALIDACIÓN
--====================================================
btn.MouseButton1Click:Connect(function()
    local key = box.Text
    local duration = KEYS[key]

    if duration then
        local expireAt = now() + duration
        writefile(FILE, tostring(expireAt))
        gui:Destroy()
        loadstring(game:HttpGet(HUB_2_URL, true))()
    else
        btn.Text = "KEY INVÁLIDA"
        task.wait(1)
        btn.Text = "VALIDAR KEY"
    end
end)--====================================================
-- LYNOX ✖ MACABRO | HUB 1 - KEY SYSTEM
-- REQUIERE KEY ANTES DE EJECUTAR HUB 2
--====================================================

-- HUB 2 (EL REAL)
local HUB_2_URL = "https://raw.githubusercontent.com/A0WTGFjaGecc2k42wP0PZAbQphqh/Contact/refs/heads/main/OrzlxZ44HubOwnKQenGRSVztS5ndNb.lua"

-- TIEMPOS
local HOUR = 3600
local DAY  = 86400

-- KEYS + DURACIÓN (COLLAB LYNOX ✖ MACABRO)
local KEYS = {
    -- 30 KEYS | 7 DÍAS
    ["LYNOXxMACABRO-7D-01"]=7*DAY, ["LYNOXxMACABRO-7D-02"]=7*DAY,
    ["LYNOXxMACABRO-7D-03"]=7*DAY, ["LYNOXxMACABRO-7D-04"]=7*DAY,
    ["LYNOXxMACABRO-7D-05"]=7*DAY, ["LYNOXxMACABRO-7D-06"]=7*DAY,
    ["LYNOXxMACABRO-7D-07"]=7*DAY, ["LYNOXxMACABRO-7D-08"]=7*DAY,
    ["LYNOXxMACABRO-7D-09"]=7*DAY, ["LYNOXxMACABRO-7D-10"]=7*DAY,
    ["LYNOXxMACABRO-7D-11"]=7*DAY, ["LYNOXxMACABRO-7D-12"]=7*DAY,
    ["LYNOXxMACABRO-7D-13"]=7*DAY, ["LYNOXxMACABRO-7D-14"]=7*DAY,
    ["LYNOXxMACABRO-7D-15"]=7*DAY, ["LYNOXxMACABRO-7D-16"]=7*DAY,
    ["LYNOXxMACABRO-7D-17"]=7*DAY, ["LYNOXxMACABRO-7D-18"]=7*DAY,
    ["LYNOXxMACABRO-7D-19"]=7*DAY, ["LYNOXxMACABRO-7D-20"]=7*DAY,
    ["LYNOXxMACABRO-7D-21"]=7*DAY, ["LYNOXxMACABRO-7D-22"]=7*DAY,
    ["LYNOXxMACABRO-7D-23"]=7*DAY, ["LYNOXxMACABRO-7D-24"]=7*DAY,
    ["LYNOXxMACABRO-7D-25"]=7*DAY, ["LYNOXxMACABRO-7D-26"]=7*DAY,
    ["LYNOXxMACABRO-7D-27"]=7*DAY, ["LYNOXxMACABRO-7D-28"]=7*DAY,
    ["LYNOXxMACABRO-7D-29"]=7*DAY, ["LYNOXxMACABRO-7D-30"]=7*DAY,

    -- TRIAL | 10 HORAS
    ["LYNOXxMACABRO-TRIAL-10H-A"]=10*HOUR,
    ["LYNOXxMACABRO-TRIAL-10H-B"]=10*HOUR,

    -- ESPECIALES
    ["LYNOXxMACABRO-2H"]=2*HOUR,
    ["LYNOXxMACABRO-5H"]=5*HOUR,
    ["LYNOXxMACABRO-8H"]=8*HOUR,
}

-- ARCHIVO LOCAL (GUARDA EXPIRACIÓN)
local FILE = "LYNOX_x_MACABRO.exp"

local function now()
    return os.time()
end

--====================================================
-- GUI
--====================================================
local Players = game:GetService("Players")
local player  = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "LYNOX_MACABRO_KEY"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,360,0,190)
frame.Position = UDim2.new(0.5,-180,0.5,-95)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,42)
title.Text = "LYNOX ✖ MACABRO"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local subtitle = Instance.new("TextLabel", frame)
subtitle.Size = UDim2.new(1,0,0,24)
subtitle.Position = UDim2.new(0,0,0.22,0)
subtitle.Text = "KEY SYSTEM"
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(200,200,200)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.9,0,0,36)
box.Position = UDim2.new(0.05,0,0.45,0)
box.PlaceholderText = "INGRESA TU KEY (LYNOX ✖ MACABRO)"
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextSize = 14
box.BackgroundColor3 = Color3.fromRGB(30,30,30)
box.TextColor3 = Color3.new(1,1,1)
box.ClearTextOnFocus = false

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.9,0,0,36)
btn.Position = UDim2.new(0.05,0,0.7,0)
btn.Text = "VALIDAR KEY"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.BackgroundColor3 = Color3.fromRGB(170,0,0)
btn.TextColor3 = Color3.new(1,1,1)

--====================================================
-- VALIDACIÓN
--====================================================
btn.MouseButton1Click:Connect(function()
    local key = box.Text
    local duration = KEYS[key]

    if duration then
        local expireAt = now() + duration
        writefile(FILE, tostring(expireAt))
        gui:Destroy()
        loadstring(game:HttpGet(HUB_2_URL, true))()
    else
        btn.Text = "KEY INVÁLIDA"
        task.wait(1)
        btn.Text = "VALIDAR KEY"
    end
end)
