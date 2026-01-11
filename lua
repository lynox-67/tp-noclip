
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Update on respawn
plr.CharacterAdded:Connect(function(new)
    char = new
    hrp = new:WaitForChild("HumanoidRootPart")
end)

-- Configuración
local SPEED = 250             -- Velocidad alta
local COLLECT_DISTANCE = 60   -- Distancia para detectar
local BASE_POS = Vector3.new(0, 50, 0)  -- Cambia esto si sabes las coords de tu base

-- Intento de detectar base automáticamente (puede fallar, ajusta manual)
local function tryFindBase()
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name:lower():find("base") or v.Name:lower():find("plot") then
            local myBase = v:FindFirstChild(plr.Name)
            if myBase and myBase:IsA("Model") then
                local part = myBase.PrimaryPart or myBase:FindFirstChildWhichIsA("BasePart")
                if part then
                    BASE_POS = part.Position + Vector3.new(0, 10, 0)
                    print("[Lynox Hub] Base detectada en: " .. tostring(BASE_POS))
                    return
                end
            end
        end
    end
    print("[Lynox Hub] No se detectó base → usando posición por defecto (0,50,0)")
end

tryFindBase()

-- Velocidad alta
if char:FindFirstChild("Humanoid") then
    char.Humanoid.WalkSpeed = SPEED
end

-- Función simple de teletransporte (sin Tween para mejor compatibilidad en Xeno)
local function tpTo(pos)
    if hrp then
        hrp.CFrame = CFrame.new(pos)
    end
end

-- Recolectar brainrot (touch simulation simple)
local function collect(part)
    if not part or not part.Parent then return end
    
    print("[Lynox Hub] Celestial detectado → recolectando...")
    tpTo(part.Position + Vector3.new(0, 3, 0))
    wait(0.15)
    
    -- Simular touch (funciona en la mayoría de executors level 7+ como Xeno)
    firetouchinterest(hrp, part, 0)
    wait()
    firetouchinterest(hrp, part, 1)
    
    wait(0.4)
    print("[Lynox Hub] Recolectado! Volviendo a base...")
    tpTo(BASE_POS)
end

-- Scanner principal (cada frame)
RunService.Heartbeat:Connect(function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            local name = obj.Name:lower()
            local dist = (hrp.Position - obj.Position).Magnitude
            
            -- Detección de Celestial (ajusta según necesites)
            local isCelestial = name:find("celestial") or name:find("god") or name:find("secret") or
                                name:find("legendary") or obj.Material == Enum.Material.Neon or
                                (obj:FindFirstChild("Rarity") and obj.Rarity.Value:lower():find("celestial"))
            
            if isCelestial and dist < COLLECT_DISTANCE then
                collect(obj)
                break  -- Solo uno a la vez para evitar spam
            end
        end
    end
end)
