local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player.PlayerGui

-- ==============================
-- СОЗДАНИЕ GUI
-- ==============================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlightGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- ==============================
-- ЭКРАН ЗАГРУЗКИ (чёрный фон)
-- ==============================
local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(1, 0, 1, 0)
loadFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadFrame.ZIndex = 10
loadFrame.Parent = screenGui

local codeLabel = Instance.new("TextLabel")
codeLabel.Size = UDim2.new(1, -40, 0.6, 0)
codeLabel.Position = UDim2.new(0, 20, 0.1, 0)
codeLabel.BackgroundTransparency = 1
codeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
codeLabel.TextScaled = true
codeLabel.Font = Enum.Font.Code
codeLabel.TextXAlignment = Enum.TextXAlignment.Left
codeLabel.TextYAlignment = Enum.TextYAlignment.Top
codeLabel.ZIndex = 11
codeLabel.Parent = loadFrame

local byLabel = Instance.new("TextLabel")
byLabel.Size = UDim2.new(1, 0, 0.06, 0)
byLabel.Position = UDim2.new(0, 0, 0.82, 0)
byLabel.BackgroundTransparency = 1
byLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
byLabel.Text = "by Murd"
byLabel.TextScaled = true
byLabel.Font = Enum.Font.Code
byLabel.ZIndex = 11
byLabel.Parent = loadFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.3, 0, 0.07, 0)
closeBtn.Position = UDim2.new(0.35, 0, 0.91, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeBtn.BorderSizePixel = 1
closeBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "[ ЗАКРЫТЬ ]"
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.Code
closeBtn.ZIndex = 11
closeBtn.Parent = loadFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = closeBtn

-- ==============================
-- АНИМАЦИЯ ПЕЧАТАНИЯ КОДА
-- ==============================
local codeText = [[-- FlightSystem v2.0
-- by Murd

local flying = false
local speed = 60

local function startFly()
    flying = true
    bodyVelocity = Instance.new(
        "BodyVelocity")
    bodyVelocity.MaxForce =
        Vector3.new(1e5,1e5,1e5)
    bodyVelocity.Parent = rootPart
    flyTrack:Play()
end

local function stopFly()
    flying = false
    bodyVelocity:Destroy()
    flyTrack:Stop()
end

-- Нажми на кнопку для полёта
-- Загрузка завершена...]]

local function typewriterEffect(text, label, callback)
    label.Text = ""
    local i = 0
    local connection
    connection = RunService.Heartbeat:Connect(function()
        i = i + 1
        if i <= #text then
            label.Text = string.sub(text, 1, i)
        else
            connection:Disconnect()
            if callback then callback() end
        end
    end)
end

-- ==============================
-- ПАНЕЛЬ ПОЛЁТА
-- ==============================
local flightPanel = Instance.new("Frame")
flightPanel.Size = UDim2.new(0, 260, 0, 200)
flightPanel.Position = UDim2.new(0.5, -130, 0.5, -100)
flightPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
flightPanel.BorderSizePixel = 0
flightPanel.Visible = false
flightPanel.Active = true
flightPanel.Draggable = true
flightPanel.ZIndex = 5
flightPanel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 8)
panelCorner.Parent = flightPanel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(60, 60, 60)
panelStroke.Thickness = 1
panelStroke.Parent = flightPanel

local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(1, 0, 0, 28)
panelTitle.Position = UDim2.new(0, 0, 0, 0)
panelTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
panelTitle.BorderSizePixel = 0
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
panelTitle.Text = "✈  FLIGHT  |  by Murd"
panelTitle.TextScaled = true
panelTitle.Font = Enum.Font.Code
panelTitle.ZIndex = 6
panelTitle.Parent = flightPanel

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = panelTitle

-- ==============================
-- ГАЛОЧКА ВКЛЮЧЕНИЯ ПОЛЁТА
-- ==============================
local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(0, 80, 0, 30)
toggleLabel.Position = UDim2.new(0, 10, 0, 38)
toggleLabel.BackgroundTransparency = 1
toggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleLabel.Text = "Полёт:"
toggleLabel.TextScaled = true
toggleLabel.Font = Enum.Font.Code
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.ZIndex = 6
toggleLabel.Parent = flightPanel

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 30, 0, 30)
toggleBtn.Position = UDim2.new(0, 95, 0, 38)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "✗"
toggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.Code
toggleBtn.ZIndex = 6
toggleBtn.Parent = flightPanel

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 4)
toggleCorner.Parent = toggleBtn

-- ==============================
-- НАСТРОЙКА СКОРОСТИ
-- ==============================
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 80, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 78)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.Text = "Скорость:"
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Code
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.ZIndex = 6
speedLabel.Parent = flightPanel

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 30, 0, 30)
minusBtn.Position = UDim2.new(0, 95, 0, 78)
minusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minusBtn.BorderSizePixel = 0
minusBtn.Text = "−"
minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minusBtn.TextScaled = true
minusBtn.Font = Enum.Font.Code
minusBtn.ZIndex = 6
minusBtn.Parent = flightPanel

local minusCorner = Instance.new("UICorner")
minusCorner.CornerRadius = UDim.new(0, 4)
minusCorner.Parent = minusBtn

local speedValue = Instance.new("TextLabel")
speedValue.Size = UDim2.new(0, 50, 0, 30)
speedValue.Position = UDim2.new(0, 130, 0, 78)
speedValue.BackgroundTransparency = 1
speedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
speedValue.Text = "60"
speedValue.TextScaled = true
speedValue.Font = Enum.Font.Code
speedValue.ZIndex = 6
speedValue.Parent = flightPanel

local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 30, 0, 30)
plusBtn.Position = UDim2.new(0, 185, 0, 78)
plusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
plusBtn.BorderSizePixel = 0
plusBtn.Text = "+"
plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
plusBtn.TextScaled = true
plusBtn.Font = Enum.Font.Code
plusBtn.ZIndex = 6
plusBtn.Parent = flightPanel

local plusCorner = Instance.new("UICorner")
plusCorner.CornerRadius = UDim.new(0, 4)
plusCorner.Parent = plusBtn

-- ==============================
-- СЕНСОРНЫЕ КНОПКИ ДЛЯ ТЕЛЕФОНА
-- ==============================
local moveUpBtn = Instance.new("TextButton")
moveUpBtn.Size = UDim2.new(0, 60, 0, 60)
moveUpBtn.Position = UDim2.new(0.3, -30, 0.85, 0)
moveUpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
moveUpBtn.BorderSizePixel = 0
moveUpBtn.Text = "⬆"
moveUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveUpBtn.TextSize = 30
moveUpBtn.Font = Enum.Font.Code
moveUpBtn.ZIndex = 6
moveUpBtn.Visible = false
moveUpBtn.Parent = flightPanel

local moveUpCorner = Instance.new("UICorner")
moveUpCorner.CornerRadius = UDim.new(1, 0)
moveUpCorner.Parent = moveUpBtn

local moveDownBtn = Instance.new("TextButton")
moveDownBtn.Size = UDim2.new(0, 60, 0, 60)
moveDownBtn.Position = UDim2.new(0.3, -30, 0.85, 0)
moveDownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
moveDownBtn.BorderSizePixel = 0
moveDownBtn.Text = "⬇"
moveDownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveDownBtn.TextSize = 30
moveDownBtn.Font = Enum.Font.Code
moveDownBtn.ZIndex = 6
moveDownBtn.Visible = false
moveDownBtn.Parent = flightPanel

local moveDownCorner = Instance.new("UICorner")
moveDownCorner.CornerRadius = UDim.new(1, 0)
moveDownCorner.Parent = moveDownBtn

local moveLeftBtn = Instance.new("TextButton")
moveLeftBtn.Size = UDim2.new(0, 60, 0, 60)
moveLeftBtn.Position = UDim2.new(0.15, 0, 0.85, 0)
moveLeftBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
moveLeftBtn.BorderSizePixel = 0
moveLeftBtn.Text = "⬅"
moveLeftBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveLeftBtn.TextSize = 30
moveLeftBtn.Font = Enum.Font.Code
moveLeftBtn.ZIndex = 6
moveLeftBtn.Visible = false
moveLeftBtn.Parent = flightPanel

local moveLeftCorner = Instance.new("UICorner")
moveLeftCorner.CornerRadius = UDim.new(1, 0)
moveLeftCorner.Parent = moveLeftBtn

local moveRightBtn = Instance.new("TextButton")
moveRightBtn.Size = UDim2.new(0, 60, 0, 60)
moveRightBtn.Position = UDim2.new(0.45, 0, 0.85, 0)
moveRightBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
moveRightBtn.BorderSizePixel = 0
moveRightBtn.Text = "➡"
moveRightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveRightBtn.TextSize = 30
moveRightBtn.Font = Enum.Font.Code
moveRightBtn.ZIndex = 6
moveRightBtn.Visible = false
moveRightBtn.Parent = flightPanel

local moveRightCorner = Instance.new("UICorner")
moveRightCorner.CornerRadius = UDim.new(1, 0)
moveRightCorner.Parent = moveRightBtn

local moveForwardBtn = Instance.new("TextButton")
moveForwardBtn.Size = UDim2.new(0, 60, 0, 60)
moveForwardBtn.Position = UDim2.new(0.3, -30, 0.75, 0)
moveForwardBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
moveForwardBtn.BorderSizePixel = 0
moveForwardBtn.Text = "⬆⬆"
moveForwardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveForwardBtn.TextSize = 24
moveForwardBtn.Font = Enum.Font.Code
moveForwardBtn.ZIndex = 6
moveForwardBtn.Visible = false
moveForwardBtn.Parent = flightPanel

local moveForwardCorner = Instance.new("UICorner")
moveForwardCorner.CornerRadius = UDim.new(1, 0)
moveForwardCorner.Parent = moveForwardBtn

-- ==============================
-- ЛОГИКА ПОЛЁТА
-- ==============================
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 60
local moveVector = Vector3.zero
local bodyVelocity, bodyGyro

local function updateMoveVector()
    if not flying then return end
    local camera = workspace.CurrentCamera
    local dir = Vector3.zero
    
    if moveForwardBtn.Visible and moveForwardBtn.Text == "⬆⬆" then
        dir = dir + camera.CFrame.LookVector
    end
    if moveLeftBtn.Visible and moveLeftBtn.Text == "⬅" then
        dir = dir - camera.CFrame.RightVector
    end
    if moveRightBtn.Visible and moveRightBtn.Text == "➡" then
        dir = dir + camera.CFrame.RightVector
    end
    if moveUpBtn.Visible and moveUpBtn.Text == "⬆" then
        dir = dir + Vector3.new(0, 1, 0)
    end
    if moveDownBtn.Visible and moveDownBtn.Text == "⬇" then
        dir = dir + Vector3.new(0, -1, 0)
    end
    
    if dir.Magnitude > 0 then
        moveVector = dir.Unit * speed
    else
        moveVector = Vector3.zero
    end
end

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
    
    toggleBtn.Text = "✓"
    toggleBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 25)
    
    -- Показываем сенсорные кнопки
    moveUpBtn.Visible = true
    moveDownBtn.Visible = true
    moveLeftBtn.Visible = true
    moveRightBtn.Visible = true
    moveForwardBtn.Visible = true
    
    TweenService:Create(workspace.CurrentCamera,
        TweenInfo.new(0.4, Enum.EasingStyle.Sine),
        {FieldOfView = 80}):Play()
end

local function stopFly()
    flying = false
    humanoid.PlatformStand = false
    
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    
    toggleBtn.Text = "✗"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    
    -- Скрываем сенсорные кнопки
    moveUpBtn.Visible = false
    moveDownBtn.Visible = false
    moveLeftBtn.Visible = false
    moveRightBtn.Visible = false
    moveForwardBtn.Visible = false
    
    TweenService:Create(workspace.CurrentCamera,
        TweenInfo.new(0.4, Enum.EasingStyle.Sine),
        {FieldOfView = 70}):Play()
end

-- Нажатия на сенсорные кнопки (для телефона)
moveForwardBtn.MouseButton1Click:Connect(function()
    moveForwardBtn.Text = moveForwardBtn.Text == "⬆⬆" and "⬆" or "⬆⬆"
end)

moveLeftBtn.MouseButton1Click:Connect(function()
    moveLeftBtn.Text = moveLeftBtn.Text == "⬅" and "⬅⬅" or "⬅"
end)

moveRightBtn.MouseButton1Click:Connect(function()
    moveRightBtn.Text = moveRightBtn.Text == "➡" and "➡➡" or "➡"
end)

moveUpBtn.MouseButton1Click:Connect(function()
    -- просто для обратной связи
end)

moveDownBtn.MouseButton1Click:Connect(function()
    -- просто для обратной связи
end)

-- Галочка
toggleBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

-- Скорость
minusBtn.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 10)
    speedValue.Text = tostring(speed)
end)

plusBtn.MouseButton1Click:Connect(function()
    speed = math.min(200, speed + 10)
    speedValue.Text = tostring(speed)
end)

-- Движение
RunService.Heartbeat:Connect(function()
    if not flying then return end
    updateMoveVector()
    if bodyVelocity then
        bodyVelocity.Velocity = moveVector
    end
    if bodyGyro then
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end
end)

-- ==============================
-- ЗАПУСК: анимация при входе
-- ==============================
task.wait(0.5)
typewriterEffect(codeText, codeLabel, function() end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(loadFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Sine),
        {BackgroundTransparency = 1}):Play()
    
    codeLabel.Visible = false
    byLabel.Visible = false
    closeBtn.Visible = false
    
    task.wait(0.5)
    loadFrame.Visible = false
    
    flightPanel.Visible = true
    flightPanel.Size = UDim2.new(0, 0, 0, 0)
    flightPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(flightPanel,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0, 260, 0, 200),
            Position = UDim2.new(0.5, -130, 0.5, -100)
        }):Play()
end)
