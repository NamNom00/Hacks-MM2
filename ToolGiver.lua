local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI Setup
local gui = Instance.new("ScreenGui")
gui.Parent = playerGui
gui.Name = "ToolGiverGUI"
gui.ResetOnSpawn = false

-- Frame (Main UI)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 350)
mainFrame.Position = UDim2.new(0.5, -100, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = gui

-- Title Bar
local titleBar = Instance.new("TextButton")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
titleBar.Text = "Tools"
titleBar.Font = Enum.Font.SourceSansBold
titleBar.TextSize = 24
titleBar.Parent = mainFrame

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -65, 0, 5)
minimizeBtn.Text = "_"
minimizeBtn.TextSize = 20
minimizeBtn.Parent = titleBar

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.TextSize = 20
closeBtn.Parent = titleBar

-- Tool List
local toolList = Instance.new("ScrollingFrame")
toolList.Size = UDim2.new(1, -20, 1, -80)
toolList.Position = UDim2.new(0, 10, 0, 50)
toolList.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
toolList.BorderSizePixel = 2
toolList.ScrollBarThickness = 10
toolList.Parent = mainFrame
toolList.Visible = false -- Hidden by default

-- Claim Button
local claimBtn = Instance.new("TextButton")
claimBtn.Size = UDim2.new(0.8, 0, 0, 40)
claimBtn.Position = UDim2.new(0.1, 0, 1, -50)
claimBtn.BackgroundTransparency = 1
claimBtn.Text = "Claim Tool"
claimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
claimBtn.Font = Enum.Font.SourceSansBold
claimBtn.TextSize = 20
claimBtn.Parent = mainFrame

-- UI Outline Effect
local uiOutline = Instance.new("UIStroke")
uiOutline.Thickness = 3
uiOutline.Color = Color3.fromRGB(255, 0, 255)
uiOutline.Parent = mainFrame

-- Toggle Light/Dark Mode Button
local toggleModeBtn = Instance.new("TextButton")
toggleModeBtn.Size = UDim2.new(0.3, 0, 0, 30)
toggleModeBtn.Position = UDim2.new(0, 10, 1, -85)
toggleModeBtn.Text = "🌞"
toggleModeBtn.TextSize = 18
toggleModeBtn.Parent = mainFrame

-- Minimized Icon
local minimizedIcon = Instance.new("ImageButton")
minimizedIcon.Size = UDim2.new(0, 50, 0, 50)
minimizedIcon.Position = UDim2.new(0.9, -55, 0.9, -55)
minimizedIcon.Image = "rbxassetid://IMAGE_ID_HERE" -- Replace with your image ID
minimizedIcon.Parent = gui
minimizedIcon.Visible = false

-- Functions
local function populateTools()
    for _, tool in pairs(ReplicatedStorage:GetChildren()) do
        if tool:IsA("Tool") then
            local toolButton = Instance.new("TextButton")
            toolButton.Size = UDim2.new(1, 0, 0, 30)
            toolButton.Text = tool.Name
            toolButton.Parent = toolList
            toolButton.MouseButton1Click:Connect(function()
                local clonedTool = tool:Clone()
                clonedTool.Parent = player.Backpack
            end)
        end
    end
end
populateTools()

titleBar.MouseButton1Click:Connect(function()
    toolList.Visible = not toolList.Visible
end)

minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedIcon.Visible = true
end)

minimizedIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    minimizedIcon.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightShift then
        gui.Enabled = not gui.Enabled
    end
end)

toggleModeBtn.MouseButton1Click:Connect(function()
    if mainFrame.BackgroundColor3 == Color3.fromRGB(180, 180, 180) then
        mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Dark Mode
        titleBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        toolList.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        toggleModeBtn.Text = "🌙"
    else
        mainFrame.BackgroundColor3 = Color3.fromRGB(180, 180, 180) -- Light Mode
        titleBar.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        toolList.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        toggleModeBtn.Text = "🌞"
    end
end)
