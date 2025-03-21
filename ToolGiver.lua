local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local toolGiverGui = Instance.new("ScreenGui", playerGui)
toolGiverGui.Name = "ToolGiverUI"
toolGiverGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", toolGiverGui)
mainFrame.Size = UDim2.new(0, 450, 0, 200)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local toolsHeader = Instance.new("TextButton", mainFrame)
toolsHeader.Size = UDim2.new(1, 0, 0, 30)
toolsHeader.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toolsHeader.Text = "Tools  ▽"
toolsHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
toolsHeader.TextScaled = true

local toolsList = Instance.new("ScrollingFrame", mainFrame)
toolsList.Size = UDim2.new(1, -10, 0, 120)
toolsList.Position = UDim2.new(0, 5, 0, 40)
toolsList.BackgroundTransparency = 1
toolsList.CanvasSize = UDim2.new(0, 0, 0, 0)
toolsList.ScrollBarThickness = 5
toolsList.Visible = false

local claimButton = Instance.new("TextButton", mainFrame)
claimButton.Size = UDim2.new(0.5, 0, 0, 40)
claimButton.Position = UDim2.new(0.25, 0, 0.75, 0)
claimButton.BackgroundTransparency = 1
claimButton.Text = "Claim Tool"
claimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
claimButton.TextScaled = true
claimButton.BorderMode = Enum.BorderMode.Outline
claimButton.BorderSizePixel = 2
claimButton.BorderColor3 = Color3.fromRGB(255, 0, 255)

local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -55, 0, 5)
minimizeButton.Text = "−"
minimizeButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

local toggleButton = Instance.new("TextButton", mainFrame)
toggleButton.Size = UDim2.new(0, 50, 0, 25)
toggleButton.Position = UDim2.new(0, 5, 0, 5)
toggleButton.Text = "☀"
toggleButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)

local minimizedIcon = Instance.new("ImageButton", toolGiverGui)
minimizedIcon.Size = UDim2.new(0, 50, 0, 50)
minimizedIcon.Position = UDim2.new(0.9, 0, 0.1, 0)
minimizedIcon.Image = "rbxassetid://84855592579272"
minimizedIcon.Visible = false
minimizedIcon.Active = true
minimizedIcon.Draggable = true

toolsHeader.MouseButton1Click:Connect(function()
    toolsList.Visible = not toolsList.Visible
    toolsHeader.Text = toolsList.Visible and "Tools  △" or "Tools  ▽"
end)

local function refreshToolList()
    for _, child in pairs(toolsList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local toolsFolder = ReplicatedStorage:FindFirstChild("Tools")
    if toolsFolder then
        for _, tool in pairs(toolsFolder:GetChildren()) do
            if tool:IsA("Tool") then
                local toolButton = Instance.new("TextButton", toolsList)
                toolButton.Size = UDim2.new(1, 0, 0, 30)
                toolButton.Text = tool.Name
                toolButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
                toolButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                toolButton.MouseButton1Click:Connect(function()
                    ReplicatedStorage:FindFirstChild("Tools")[tool.Name]:Clone().Parent = player.Backpack
                end)
            end
        end
    end
end

refreshToolList()

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedIcon.Visible = true
end)

minimizedIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    minimizedIcon.Visible = false
end)

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedIcon.Visible = false
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

local isDarkMode = true
toggleButton.MouseButton1Click:Connect(function()
    isDarkMode = not isDarkMode
    mainFrame.BackgroundColor3 = isDarkMode and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(230, 230, 230)
    toggleButton.Text = isDarkMode and "☀" or "🌙"
end)
