local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- UI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 100)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, 0) -- Middle of screen
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.BorderSizePixel = 2
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 200, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -100, 0.3, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true
ToggleButton.Text = "Magnetic Pull: OFF"
ToggleButton.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 50, 0, 30)
MinimizeButton.Position = UDim2.new(1, -55, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Text = "-"
MinimizeButton.Parent = MainFrame

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 250, 0, 40)
        ToggleButton.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 250, 0, 100)
        ToggleButton.Visible = true
        MinimizeButton.Text = "-"
    end
end)

-- Magnet Functionality
local magnetActive = false
local magnetObjects = {}

local function enableMagnet()
    magnetObjects = {} -- Reset list
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            table.insert(magnetObjects, obj)
        end
    end

    while magnetActive do
        for _, obj in pairs(magnetObjects) do
            if obj and obj.Parent then
                local direction = (humanoidRootPart.Position - obj.Position).unit
                obj.Velocity = direction * 30 + Vector3.new(math.sin(tick()) * 10, math.cos(tick()) * 10, math.sin(tick() * 1.5) * 10)
            end
        end
        wait(0.05)
    end
end

local function disableMagnet()
    for _, obj in pairs(magnetObjects) do
        if obj and obj.Parent then
            obj.Velocity = Vector3.new(0, -50, 0) -- Drop down
        end
    end
end

ToggleButton.MouseButton1Click:Connect(function()
    magnetActive = not magnetActive
    ToggleButton.Text = "Magnetic Pull: " .. (magnetActive and "ON" or "OFF")

    if magnetActive then
        enableMagnet()
    else
        disableMagnet()
    end
end)
