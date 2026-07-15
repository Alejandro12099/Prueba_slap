-- // Grok Delta Hub - Encuentra Quien Te Golpeó
-- Versión Mejorada: Auto Max Power Ultra Preciso + Detector + GUI Moderna Mobile

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager") -- Para clicks más rápidos

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local AutoMaxPower = false
local AutoDetectHit = false

-- ==================== GUI MODERNA ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GrokDeltaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 260)
MainFrame.Position = UDim2.new(0, 15, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
UIGradient.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "🔥 GROK DELTA HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 170)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = MainFrame

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.9, 0, 0, 2)
Divider.Position = UDim2.new(0.05, 0, 0.22, 0)
Divider.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- Toggle 1 - Auto Max Power
local Toggle1 = Instance.new("TextButton")
Toggle1.Size = UDim2.new(0.9, 0, 0, 50)
Toggle1.Position = UDim2.new(0.05, 0, 0.28, 0)
Toggle1.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Toggle1.Text = "Auto Max Power: OFF"
Toggle1.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle1.TextScaled = true
Toggle1.Font = Enum.Font.GothamSemibold
Toggle1.Parent = MainFrame

local Corner1 = Instance.new("UICorner")
Corner1.CornerRadius = UDim.new(0, 12)
Corner1.Parent = Toggle1

-- Toggle 2 - Auto Detect
local Toggle2 = Instance.new("TextButton")
Toggle2.Size = UDim2.new(0.9, 0, 0, 50)
Toggle2.Position = UDim2.new(0.05, 0, 0.52, 0)
Toggle2.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Toggle2.Text = "Auto Detect Who Hit: OFF"
Toggle2.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle2.TextScaled = true
Toggle2.Font = Enum.Font.GothamSemibold
Toggle2.Parent = MainFrame

local Corner2 = Instance.new("UICorner")
Corner2.CornerRadius = UDim.new(0, 12)
Corner2.Parent = Toggle2

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(0.9, 0, 0, 40)
Status.Position = UDim2.new(0.05, 0, 0.78, 0)
Status.BackgroundTransparency = 1
Status.Text = "Listo • Esperando turno"
Status.TextColor3 = Color3.fromRGB(140, 255, 180)
Status.TextScaled = true
Status.Font = Enum.Font.Gotham
Status.Parent = MainFrame

-- ==================== LÓGICA AUTO MAX POWER ====================
Toggle1.MouseButton1Click:Connect(function()
    AutoMaxPower = not AutoMaxPower
    Toggle1.Text = "Auto Max Power: " .. (AutoMaxPower and "ON" or "OFF")
    Toggle1.BackgroundColor3 = AutoMaxPower and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(25, 25, 35)
end)

Toggle2.MouseButton1Click:Connect(function()
    AutoDetectHit = not AutoDetectHit
    Toggle2.Text = "Auto Detect Who Hit: " .. (AutoDetectHit and "ON" or "OFF")
    Toggle2.BackgroundColor3 = AutoDetectHit and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(25, 25, 35)
end)

-- Detección ultra precisa de la barra de potencia
RunService.Heartbeat:Connect(function()
    if not AutoMaxPower then return end

    for _, gui in ipairs(player:FindFirstChild("PlayerGui"):GetDescendants()) do
        if gui:IsA("Frame") or gui:IsA("ImageLabel") then
            local name = gui.Name:lower()
            if name:find("power") or name:find("barra") or name:find("fuerza") or name:find("meter") then
                if gui.Visible then
                    -- Detectar pico máximo (rojo o casi lleno)
                    local fill = gui:FindFirstChild("Fill") or gui:FindFirstChildWhichIsA("Frame")
                    if fill then
                        local progress = fill.Size.X.Scale
                        -- Si está en el pico alto (ajustable)
                        if progress >= 0.92 then
                            -- Click ultra rápido
                            VirtualInputManager:SendMouseButtonEvent(mouse.X, mouse.Y, 0, true, game, 1)
                            wait(0.015) -- Pequeño delay para registrar el click
                            VirtualInputManager:SendMouseButtonEvent(mouse.X, mouse.Y, 0, false, game, 1)
                            
                            Status.Text = "¡MAX POWER ACTIVADO!"
                            task.wait(0.3)
                            Status.Text = "Listo • Esperando próximo turno"
                            break
                        end
                    end
                end
            end
        end
    end
end)

-- ==================== DETECTOR QUIÉN TE GOLPEÓ ====================
local function detectWhoHit()
    if not AutoDetectHit then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr \~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local myChar = player.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local distance = (myChar.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if distance < 35 then
                    Status.Text = "Te golpeó: " .. plr.Name
                    -- Notificación
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "¡Detectado!";
                        Text = "Te golpeó: " .. plr.Name;
                        Duration = 4;
                    })
                    break
                end
            end
        end
    end
end

player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").HealthChanged:Connect(function()
        task.wait(0.1)
        detectWhoHit()
    end)
end)

if player.Character then
    player.Character:WaitForChild("Humanoid").HealthChanged:Connect(function()
        task.wait(0.1)
        detectWhoHit()
    end)
end

print("🚀 Grok Delta Hub cargado correctamente")
game.StarterGui:SetCore("SendNotification", {
    Title = "Grok Delta";
    Text = "Script listo para Encuentra quien te golpeó";
    Duration = 5;
})
