local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player.PlayerGui

-- ==============================
-- НАЧАЛЬНЫЙ ЭКРАН
-- ==============================
local splashGui = Instance.new("ScreenGui")
splashGui.Name = "SplashGui"
splashGui.ResetOnSpawn = false
splashGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
splashGui.Parent = playerGui

local blackBg = Instance.new("Frame")
blackBg.Size = UDim2.new(1, 0, 1, 0)
blackBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackBg.BackgroundTransparency = 0
blackBg.Parent = splashGui

-- Анимация появления текста
local mainText = Instance.new("TextLabel")
mainText.Size = UDim2.new(1, 0, 0.7, 0)
mainText.Position = UDim2.new(0, 0, 0.15, 0)
mainText.BackgroundTransparency = 1
mainText.Text = ""
mainText.TextColor3 = Color3.fromRGB(80, 255, 100)
mainText.TextSize = 50
mainText.Font = Enum.Font.GothamBold
mainText.TextScaled = true
mainText.Parent = blackBg

-- Подпись by Murd
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 60)
footer.Position = UDim2.new(0, 0, 0.8, 0)
footer.BackgroundTransparency = 1
footer.Text = "by Murd"
footer.TextColor3 = Color3.fromRGB(255, 80, 80)
footer.TextSize = 24
footer.Font = Enum.Font.GothamBold
footer.TextScaled = true
footer.Parent = blackBg

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
closeSplashBtn.Parent = blackBg

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeSplashBtn

-- Анимация печатания текста
local fullText = "ПЖ АДМИНКУ"
local charIndex = 0
local typewriter = RunService.Heartbeat:Connect(function()
    charIndex = charIndex + 1
    if charIndex <= #fullText then
        mainText.Text = string.sub(fullText, 1, charIndex)
    else
        typewriter:Disconnect()
    end
end)

-- ==============================
-- ОСНОВНОЙ GUI ПОСЛЕ ЗАКРЫТИЯ
-- ==============================
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "FlightGui"
mainGui.ResetOnSpawn = false
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
mainGui.Parent = playerGui
mainGui.Visible = false

-- ==============================
-- ПАНЕЛЬ УПРАВЛЕНИЯ
-- ==============================
local controlPanel = Instance.new("Frame")
controlPanel.Size = UDim2.new(0, 250, 0, 140)
controlPanel.Position = UDim2.new(0.5, -125, 0.5, -70)
controlPanel.BackgroundColor3 = Color3.fromRGB(15, 20, 18)
controlPanel.BackgroundTransparency = 0.1
controlPanel.BorderSizePixel = 0
controlPanel.Parent = mainGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 10)
panelCorner.Parent = controlPanel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(60, 60, 60)
panelStroke.Thickness = 1
panelStroke.Parent = controlPanel

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(25, 35, 30)
title.BackgroundTransparency = 0.1
title.Text = "ROFL  |  FLY"
title.TextColor3 = Color3.fromRGB(80, 255, 100)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = controlPanel

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Кнопка закрыть панель
local closePanelBtn = Instance.new("TextButton")
closePanelBtn.Size = UDim2.new(0, 25, 0, 25)
closePanelBtn.Position = UDim2.new(1, -30, 0, 2)
closePanelBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closePanelBtn.BackgroundTransparency = 0.3
closePanelBtn.Text = "X"
closePanelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closePanelBtn.TextSize = 12
closePanelBtn.Font = Enum.Font.GothamBold
closePanelBtn.Parent = controlPanel

local closeCorner2 = Instance.new("UICorner")
closeCorner2.CornerRadius = UDim.new(0, 8)
closeCorner2.Parent = closePanelBtn

-- ==============================
-- ВКЛЮЧЕНИЕ ПОЛЁТА (ГАЛОЧКА)
-- ==============================
local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(0, 80, 0, 30)
toggleLabel.Position = UDim2.new(0, 10, 0, 40)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "ПОЛЁТ:"
toggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleLabel.TextSize = 12
toggleLabel.Font = Enum.Font.GothamBold
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.Parent = controlPanel

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 30, 0, 30)
toggleBtn.Position = UDim2.new(0, 95, 0, 40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
toggleBtn.TextSize = 10
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = controlPanel

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 4)
toggleCorner.Parent = toggleBtn

-- ==============================
-- НАСТРОЙКА СКОРОСТИ
-- ==============================
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 80, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 80)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "СКОРОСТЬ:"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.TextSize = 12
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = controlPanel

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 30, 0, 30)
minusBtn.Position = UDim2.new(0, 95, 0, 80)
minusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minusBtn.BorderSizePixel = 0
minusBtn.Text = "-"
minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minusBtn.TextSize = 16
minusBtn.Font = Enum.Font.GothamBold
minusBtn.Parent = controlPanel

local minusCorner = Instance.new("UICorner")
minusCorner.CornerRadius = UDim.new(0, 4)
minusCorner.Parent = minusBtn

local speedValue = Instance.new("TextLabel")
speedValue.Size = UDim2.new(0, 50, 0, 30)
speedValue.Position = UDim2.new(0, 130, 0, 80)
speedValue.BackgroundTransparency = 1
speedValue.Text = "50"
speedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
speedValue.TextSize = 14
speedValue.Font = Enum.Font.GothamBold
speedValue.Parent = controlPanel

local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 30, 0, 30)
plusBtn.Position = UDim2.new(0, 185, 0, 80)
plusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
plusBtn.BorderSizePixel = 0
plusBtn.Text = "+"
plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
plusBtn.TextSize = 16
plusBtn.Font = Enum.Font.GothamBold
plusBtn.Parent = controlPanel

local plusCorner = Instance.new("UICorner")
plusCorner.CornerRadius = UDim.new(0, 4)
plusCorner.Parent = plusBtn

-- ==============================
-- ДЖОЙСТИК (ТОЛЬКО ДЛЯ ТЕЛЕФОНА)
-- ==============================
local joystickBg = Instance.new("ImageLabel")
joystickBg.Size = UDim2.new(0, 120, 0, 120)
joystickBg.Position = UDim2.new(0.1, 0, 0.75, 0)
joystickBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
joystickBg.BackgroundTransparency = 0.5
joystickBg.Image = "rbxassetid://15097438680"
joystickBg.ImageColor3 = Color3.fromRGB(80, 255, 100)
joystickBg.ImageTransparency = 0.7
joystickBg.Visible = false
joystickBg.Parent = mainGui

local joystickKnob = Instance.new("ImageLabel")
joystickKnob.Size = UDim2.new(0, 40, 0, 40)
joystickKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
joystickKnob.BackgroundColor3 = Color3.fromRGB(80, 255, 100)
joystickKnob.BackgroundTransparency = 0.3
joystickKnob.Image = "rbxassetid://15097438680"
joystickKnob.ImageColor3 = Color3.fromRGB(255, 255, 255)
joystickKnob.Parent = joystickBg

local joystickActive = false
local joystickStartPos = Vector2.zero
local joystickVector = Vector2.zero
local joystickRadius = 40

-- Кнопки вверх/вниз (отдельно)
local upBtn = Instance.new("TextButton")
upBtn.Size = UDim2.new(0, 60, 0, 60)
upBtn.Position = UDim2.new(0.85, -30, 0.75, 0)
upBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
upBtn.BackgroundTransparency = 0.3
upBtn.Text = "⬆"
upBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
upBtn.TextSize = 30
upBtn.Font = Enum.Font.GothamBold
upBtn.Visible = false
upBtn.Parent = mainGui

local upCorner = Instance.new("UICorner")
upCorner.CornerRadius = UDim.new(1, 0)
upCorner.Parent = upBtn

local downBtn = Instance.new("TextButton")
downBtn.Size = UDim2.new(0, 60, 0, 60)
downBtn.Position = UDim2.new(0.85, -30, 0.87, 0)
downBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
downBtn.BackgroundTransparency = 0.3
downBtn.Text = "⬇"
downBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
downBtn.TextSize = 30
downBtn.Font = Enum.Font.GothamBold
downBtn.Visible = false
downBtn.Parent = mainGui

local downCorner = Instance.new("UICorner")
downCorner.CornerRadius = UDim.new(1, 0)
downCorner.Parent = downBtn

-- ==============================
-- ЛОГИКА ДЖОЙСТИКА
-- ==============================
local function updateJoystick(inputPos)
    local delta = inputPos - joystickStartPos
    local distance = math.min(delta.Magnitude, joystickRadius)
    local direction = delta.Unit
    joystickVector = direction * (distance / joystickRadius)
    
    local knobPos = joystickVector * joystickRadius
    joystickKnob.Position = UDim2.new(0.5, knobPos.X - 20, 0.5, knobPos.Y - 20)
end

joystickBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        joystickActive = true
        joystickStartPos = input.Position
        updateJoystick(input.Position)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if joystickActive and input.UserInputType == Enum.UserInputType.Touch then
        updateJoystick(input.Position)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and joystickActive then
        joystickActive = false
        joystickVector = Vector2.zero
        joystickKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
    end
end)

-- ==============================
-- ПОЛЁТ
-- ==============================
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 50
local vertical = 0
local bodyVelocity, bodyGyro

local function startFly()
    flying = true
    humanoid.PlatformStand = true
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Parent = rootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.P = 1e4
    bodyGyro.Parent = rootPart
    
    toggleBtn.Text = "ON"
    toggleBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 25)
    
    -- Показываем джойстик и кнопки
    joystickBg.Visible = true
    upBtn.Visible = true
    downBtn.Visible = true
end

local function stopFly()
    flying = false
    humanoid.PlatformStand = false
    
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    
    -- Скрываем джойстик и кнопки
    joystickBg.Visible = false
    upBtn.Visible = false
    downBtn.Visible = false
end

toggleBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

-- Скорость
minusBtn.MouseButton1Click:Connect(function()
    speed = math.max(20, speed - 10)
    speedValue.Text = tostring(speed)
end)

plusBtn.MouseButton1Click:Connect(function()
    speed = math.min(150, speed + 10)
    speedValue.Text = tostring(speed)
end)

-- Управление джойстиком и кнопками
upBtn.MouseButton1Click:Connect(function()
    vertical = 1
    task.wait(0.1)
    vertical = 0
end)

downBtn.MouseButton1Click:Connect(function()
    vertical = -1
    task.wait(0.1)
    vertical = 0
end)

-- Основной цикл движения
RunService.Heartbeat:Connect(function()
    if not flying then return end
    
    local camera = workspace.CurrentCamera
    local moveDir = Vector3.zero
    
    -- Джойстик даёт влево/вправо и вперёд/назад
    if joystickActive then
        moveDir = moveDir + camera.CFrame.LookVector * joystickVector.Y
        moveDir = moveDir + camera.CFrame.RightVector * joystickVector.X
    end
    
    -- Вертикаль от кнопок
    moveDir = moveDir + Vector3.new(0, vertical, 0)
    
    if moveDir.Magnitude > 0 then
        bodyVelocity.Velocity = moveDir.Unit * speed
    else
        bodyVelocity.Velocity = Vector3.zero
    end
    
    if bodyGyro then
        bodyGyro.CFrame = camera.CFrame
    end
end)

-- Перетаскивание панели
local dragging = false
local dragStart, panelStart

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        panelStart = controlPanel.Position
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
        controlPanel.Position = UDim2.new(
            panelStart.X.Scale,
            panelStart.X.Offset + delta.X,
            panelStart.Y.Scale,
            panelStart.Y.Offset + delta.Y
        )
    end
end)

-- Закрытие панели
closePanelBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() end
    mainGui.Visible = false
end)

-- ==============================
-- ЗАКРЫТИЕ НАЧАЛЬНОГО ЭКРАНА
-- ==============================
closeSplashBtn.MouseButton1Click:Connect(function()
    TweenService:Create(blackBg, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()
    mainText.Visible = false
    footer.Visible = false
    closeSplashBtn.Visible = false
    task.wait(0.5)
    splashGui:Destroy()
    mainGui.Visible = true
end)

print("ROFL | Fly script loaded | by Murd")
