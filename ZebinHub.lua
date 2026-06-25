-- ZEBIN HUB | Time-Locked System (48h)
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Time Check: 172800 seconds = 48 hours
local KEY_EXPIRY = 172800 
local startTime = os.time()

local function isKeyValid()
    return (os.time() - startTime) < KEY_EXPIRY
end

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local LoginFrame = Instance.new("Frame", ScreenGui); LoginFrame.Size = UDim2.new(0, 200, 0, 150); LoginFrame.Position = UDim2.new(0.5, -100, 0.5, -75); LoginFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
local Input = Instance.new("TextBox", LoginFrame); Input.Size = UDim2.new(0, 180, 0, 40); Input.Position = UDim2.new(0, 10, 0, 20); Input.PlaceholderText = "Введите ключ"
local CheckBtn = Instance.new("TextButton", LoginFrame); CheckBtn.Size = UDim2.new(0, 180, 0, 40); CheckBtn.Position = UDim2.new(0, 10, 0, 80); CheckBtn.Text = "Войти"

local MainFrame = Instance.new("Frame", ScreenGui); MainFrame.Size = UDim2.new(0, 200, 0, 200); MainFrame.Position = UDim2.new(0.5, -100, 0.5, -100); MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30); MainFrame.Visible = false; MainFrame.Active = true; MainFrame.Draggable = true

local Toggles = {ESP = false, Aimbot = false}
local function CreateToggle(name, y)
    local btn = Instance.new("TextButton", MainFrame); btn.Size = UDim2.new(0, 180, 0, 40); btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = name; btn.MouseButton1Click:Connect(function() Toggles[name] = not Toggles[name]; btn.BackgroundColor3 = Toggles[name] and Color3.fromRGB(0,255,0) or Color3.fromRGB(45,45,45) end)
end

CreateToggle("ESP", 10); CreateToggle("Aimbot", 60)
local WinBtn = Instance.new("TextButton", MainFrame); WinBtn.Size = UDim2.new(0, 180, 0, 40); WinBtn.Position = UDim2.new(0, 10, 0, 110); WinBtn.Text = "AUTO-WIN"
WinBtn.MouseButton1Click:Connect(function() if isKeyValid() then for _,v in pairs(workspace:GetDescendants()) do if v:IsA("RemoteEvent") and (v.Name=="Win" or v.Name=="Finish") then v:FireServer() end end end end)

CheckBtn.MouseButton1Click:Connect(function()
    if Input.Text == "FREE-2DAYS" and isKeyValid() then LoginFrame:Destroy(); MainFrame.Visible = true 
    else Input.Text = "Ключ истек или неверен" end
end)

RunService.RenderStepped:Connect(function()
    if not isKeyValid() then MainFrame.Visible = false; return end
    
    if Toggles.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("ESPHighlight") then
                local hl = Instance.new("Highlight", p.Character); hl.Name = "ESPHighlight"; hl.FillColor = Color3.fromRGB(255,0,0)
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("ESPHighlight") then p.Character.ESPHighlight:Destroy() end end
    end
    
    if Toggles.Aimbot and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local closest, min = nil, 500
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                local dist = (Vector2.new(pos.X, pos.Y) - Camera.ViewportSize/2).Magnitude
                if vis and dist < min then closest = p.Character.Head; min = dist end
            end
        end
        if closest then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position) end
    end
end)
