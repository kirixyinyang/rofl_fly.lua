-- Rofl Version | Fly Script (FIXED)
-- by Murd

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Настройки
local flying = false
local flySpeed = 50
local bodyVelocity = nil
local bodyGyro = nil

-- ========== НАЧАЛЬНАЯ НАДПИСЬ НА ВЕСЬ ЭКРАН (FIXED) ==========
local splashGui = Instance.new("ScreenGui")
splashGui.Name = "RoflSplash"
splashGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
splashGui.ResetOnSpawn = false
splashGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Затемнение на весь экран
local blackOverlay = Instance.new("Frame")
blackOverlay.Size = UDim2.new(1, 0, 1, 0)
blackOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackOverlay.BackgroundTransparency = 0
blackOverlay.Parent = splashGui

-- Текст по центру
local splashText = Instance.new("TextLabel")
splashText.Size = UDim2.new(1, 0, 0.7, 0)
splashText.Position = UDim2.new(0, 0, 0.15, 0)
splashText.BackgroundTransparency = 1
splashText.Text = "ПЖ АДМИНКУ"
splashText.TextColor3 = Color3.fromRGB(80, 255, 100)
splashText.TextSize = 50
splashText.Font = Enum.Font.GothamBold
splashText.TextScaled = true
splashText.Parent = blackOverlay

-- Подпись by Murd
local splashFooter = Instance.new("TextLabel")
splashFooter.Size = UDim2.new(1, 0, 0, 60)
splashFooter.Position = UDim2.new(0, 0, 0.8, 0)
splashFooter.BackgroundTransparency = 1
splashFooter.Text = "by Murd"
splashFooter.TextColor3 = Color3.fromRGB(255, 80, 80)
splashFooter.TextSize = 24
splashFooter.Font = Enum.Font.GothamBold
splashFooter.TextScaled = true
splashFooter.Parent = blackOverlay

-- Кнопка ЗАКРЫТЬ
local closeSplashBtn = Instance.new("TextButton")
closeSplashBtn.Size = UDim2.new(0, 160, 0, 50)
closeSplashBtn.Position = UDim2.new(0.5, -80, 0.92, 0)
closeSplashBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 100)
closeSplashBtn.BackgroundTransparency = 0.3
closeSplashBtn.Text = "ЗАКРЫТЬ"
closeSplashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeSplashBtn.TextSize = 18
closeSplashBtn.Font = Enum.Font.GothamBold
closeSplashBtn.Parent = blackOverlay

local closeSplashCorner = Instance.new("UICorner")
closeSplashCorner.CornerRadius = UDim.new(0, 10)
closeSplashCorner.Parent = closeSplashBtn

closeSplashBtn.MouseButton1Click:Connect(function()
    splashGui:Destroy()
end)

-- ========== GUI ПОЛЁТА ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Rofl_Fly"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 130)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -65)
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
title.Text = "ROFL  |  FLY"
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
flyBtn.Text = "FLY OFF"
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

-- Кнопка закрыть GUI
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

-- Подпись by Murd в основном окне
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 0, 110)
footer.BackgroundTransparency = 1
footer.Text = "by Murd"
footer.TextColor3 = Color3.fromRGB(255, 80, 80)
footer.TextSize = 10
footer.Font = Enum.Font.Gotham
footer.Parent = mainFrame

-- ========== ФУНКЦИИ ПОЛЁТА (ИСПРАВЛЕННЫЕ) ==========
local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
        humanoid.AutoRotate = false
        humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
    end
    
    -- BodyVelocity для движения
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.P = 1250
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = hrp
    
    -- BodyGyro для поворота (чтобы игрок смотрел в сторону движения) [citation:5]
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 100000
    bodyGyro.D = 500
    bodyGyro.Parent = hrp
    
    flying = true
end

local function stopFly()
    flying = false
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.AutoRotate = true
        end
    end
end

-- Кнопка FLY
flyBtn.MouseButton1Click:Connect(function()
    if not flying then
        local newSpeed = tonumber(speedBox.Text)
        if newSpeed and newSpeed > 0 then
            flySpeed = newSpeed
        end
        flyBtn.Text = "FLY ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        startFly()
    else
        flyBtn.Text = "FLY OFF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(80, 255, 100)
        stopFly()
    end
end)

-- Обновление скорости
speedBox.FocusLost:Connect(function()
    local newSpeed = tonumber(speedBox.Text)
    if newSpeed and newSpeed > 0 then
        flySpeed = newSpeed
    else
        speedBox.Text = tostring(flySpeed)
    end
end)

-- Закрыть GUI полёта
closeBtn.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    end
    screenGui:Destroy()
end)

-- ========== ОСНОВНОЙ ЦИКЛ ПОЛЁТА ==========
RunService.RenderStepped:Connect(function()
    if flying and bodyVelocity and bodyGyro then
        local moveDirection = Vector3.new()
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + Vector3.new(0, 0, -1)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection + Vector3.new(0, 0, 1)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection + Vector3.new(-1, 0, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + Vector3.new(1, 0, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection + Vector3.new(0, -1, 0)
        end
        
        -- Нормализуем направление
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
        end
        
        -- Преобразуем направление относительно камеры [citation:5]
        local camCF = Camera.CFrame
        local worldDirection = camCF.RightVector * moveDirection.X + 
                               camCF.UpVector * moveDirection.Y + 
                               camCF.LookVector * moveDirection.Z
        
        -- Устанавливаем скорость
        bodyVelocity.Velocity = worldDirection * flySpeed
        
        -- Поворачиваем игрока в сторону движения [citation:5]
        if worldDirection.Magnitude > 0.1 then
            bodyGyro.CFrame = CFrame.new(bodyGyro.Parent.Position, bodyGyro.Parent.Position + worldDirection)
        end
    end
end)

-- Перетаскивание окна
local dragging = false
local dragStart, frameStart

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
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
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            frameStart.X.Scale,
            frameStart.X.Offset + delta.X,
            frameStart.Y.Scale,
            frameStart.Y.Offset + delta.Y
        )
    end
end)

print("Rofl Version | Fly script loaded | by Murd")
