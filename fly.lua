-- J.A.R.V.I.S | Fly + Speed | Для Delta Mobile
-- by Murd

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Настройки
local flying = false
local bodyVelocity = nil
local flySpeed = 50

-- ========== GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JARVIS_Fly"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 140)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -70)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 22)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 40, 35)
title.BackgroundTransparency = 0.1
title.Text = "J.A.R.V.I.S  |  FLY"
title.TextColor3 = Color3.fromRGB(80, 255, 100)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Кнопка FLY
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 100, 0, 40)
flyBtn.Position = UDim2.new(0.5, -105, 0, 40)
flyBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 100)
flyBtn.BackgroundTransparency = 0.3
flyBtn.Text = "✈️ FLY: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextSize = 14
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = flyBtn

-- Поле ввода скорости
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 80, 0, 40)
speedBox.Position = UDim2.new(0.5, 25, 0, 40)
speedBox.BackgroundColor3 = Color3.fromRGB(30, 40, 35)
speedBox.BackgroundTransparency = 0.3
speedBox.Text = "50"
speedBox.TextColor3 = Color3.fromRGB(80, 255, 100)
speedBox.TextSize = 14
speedBox.Font = Enum.Font.GothamBold
speedBox.PlaceholderText = "Speed"
speedBox.Parent = mainFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedBox

-- Кнопка закрыть
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 60, 0, 25)
closeBtn.Position = UDim2.new(1, -70, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- Подпись by Murd
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 0, 120)
footer.BackgroundTransparency = 1
footer.Text = "by Murd"
footer.TextColor3 = Color3.fromRGB(255, 80, 80)
footer.TextSize = 10
footer.Font = Enum.Font.Gotham
footer.Parent = mainFrame

-- ========== ФУНКЦИИ ПОЛЁТА ==========
local function startFly()
    flying = true
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 100000
    bodyVelocity.Parent = hrp
    
    -- Управление полётом
    task.spawn(function()
        while flying do
            local direction = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + Vector3.new(0, 0, -1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction + Vector3.new(0, 0, 1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction + Vector3.new(-1, 0, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + Vector3.new(1, 0, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                direction = direction + Vector3.new(0, -1, 0)
            end
            
            direction = (Camera.CFrame.RightVector * direction.X + 
                        Camera.CFrame.UpVector * direction.Y + 
                        Camera.CFrame.LookVector * direction.Z) * flySpeed
            
            if bodyVelocity then
                bodyVelocity.Velocity = direction
            end
            task.wait()
        end
    end)
end

local function stopFly()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

-- ========== КНОПКИ ==========
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        -- Обновляем скорость из поля ввода
        local newSpeed = tonumber(speedBox.Text)
        if newSpeed and newSpeed > 0 then
            flySpeed = newSpeed
        end
        flyBtn.Text = "✈️ FLY: ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        startFly()
    else
        flyBtn.Text = "✈️ FLY: OFF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 100)
        stopFly()
    end
end)

-- Обновление скорости при изменении текста
speedBox.FocusLost:Connect(function()
    local newSpeed = tonumber(speedBox.Text)
    if newSpeed and newSpeed > 0 then
        flySpeed = newSpeed
        if flying then
            -- Если летим, просто обновляем скорость для следующего обновления
            print("Speed updated to: " .. flySpeed)
        end
    else
        speedBox.Text = tostring(flySpeed)
    end
end)

-- Закрыть GUI
closeBtn.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    end
    screenGui:Destroy()
end)

-- Перетаскивание окна
local dragging = false
local dragStart, frameStart

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        frameStart = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            frameStart.X.Scale,
            frameStart.X.Offset + delta.X,
            frameStart.Y.Scale,
            frameStart.Y.Offset + delta.Y
        )
    end
end)

print("J.A.R.V.I.S | Fly script loaded | by Murd")
