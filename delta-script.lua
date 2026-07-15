-- // Grok Delta Hub - Versión Debug
print("🚀 Iniciando Grok Delta Script...")

local success, err = pcall(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local StarterGui = game:GetService("StarterGui")

    local player = Players.LocalPlayer

    local AutoMaxPower = false
    local AutoDetectHit = false

    -- GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GrokDeltaHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 320, 0, 280)
    MainFrame.Position = UDim2.new(0, 20, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.BackgroundTransparency = 1
    Title.Text = "🔥 GROK DELTA HUB"
    Title.TextColor3 = Color3.fromRGB(0, 255, 170)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBlack
    Title.Parent = MainFrame

    -- Toggle 1
    local Toggle1 = Instance.new("TextButton")
    Toggle1.Size = UDim2.new(0.9, 0, 0, 55)
    Toggle1.Position = UDim2.new(0.05, 0, 0.25, 0)
    Toggle1.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Toggle1.Text = "Auto Max Power: OFF"
    Toggle1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle1.TextScaled = true
    Toggle1.Font = Enum.Font.GothamSemibold
    Toggle1.Parent = MainFrame
    Instance.new("UICorner", Toggle1).CornerRadius = UDim.new(0, 12)

    -- Toggle 2
    local Toggle2 = Instance.new("TextButton")
    Toggle2.Size = UDim2.new(0.9, 0, 0, 55)
    Toggle2.Position = UDim2.new(0.05, 0, 0.5, 0)
    Toggle2.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Toggle2.Text = "Auto Detect Who Hit: OFF"
    Toggle2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle2.TextScaled = true
    Toggle2.Font = Enum.Font.GothamSemibold
    Toggle2.Parent = MainFrame
    Instance.new("UICorner", Toggle2).CornerRadius = UDim.new(0, 12)

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0.9, 0, 0, 50)
    Status.Position = UDim2.new(0.05, 0, 0.75, 0)
    Status.BackgroundTransparency = 1
    Status.Text = "✅ Script cargado correctamente"
    Status.TextColor3 = Color3.fromRGB(0, 255, 100)
    Status.TextScaled = true
    Status.Font = Enum.Font.Gotham
    Status.Parent = MainFrame

    print("✅ GUI creada correctamente")

    -- Toggles
    Toggle1.MouseButton1Click:Connect(function()
        AutoMaxPower = not AutoMaxPower
        Toggle1.Text = "Auto Max Power: " .. (AutoMaxPower and "ON" or "OFF")
        Toggle1.BackgroundColor3 = AutoMaxPower and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(25, 25, 35)
        print("AutoMaxPower:", AutoMaxPower)
    end)

    Toggle2.MouseButton1Click:Connect(function()
        AutoDetectHit = not AutoDetectHit
        Toggle2.Text = "Auto Detect Who Hit: " .. (AutoDetectHit and "ON" or "OFF")
        Toggle2.BackgroundColor3 = AutoDetectHit and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(25, 25, 35)
        print("AutoDetectHit:", AutoDetectHit)
    end)

    -- Auto Max Power
    RunService.Heartbeat:Connect(function()
        if not AutoMaxPower then return end
        -- (código de detección de barra aquí - se mantiene igual)
    end)

    StarterGui:SetCore("SendNotification", {
        Title = "Grok Delta";
        Text = "Script cargado correctamente!";
        Duration = 5;
    })

end)

if not success then
    warn("❌ Error al cargar el script: " .. tostring(err))
    game.StarterGui:SetCore("SendNotification", {
        Title = "Error";
        Text = "Hubo un error al cargar el menú";
        Duration = 10;
    })
end
