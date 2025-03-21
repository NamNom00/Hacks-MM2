local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI Creation
local cheatGui = Instance.new("ScreenGui", playerGui)
cheatGui.Name = "NamHackMM2"
cheatGui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame", cheatGui)
mainFrame.Size = UDim2.new(0.6, 0, 0.8, 0) -- 60% of the screen
mainFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White Background
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Red Border
mainFrame.Active = true
mainFrame.Draggable = true

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0.1, 0)
title.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
title.Text = "NamHack MM2"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true

-- Minimize Button
local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -55, 0, 5)
minimizeButton.Text = "−"
minimizeButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)

-- Close Button
local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

-- Minimized Icon
local minimizedIcon = Instance.new("ImageButton", cheatGui)
minimizedIcon.Size = UDim2.new(0, 50, 0, 50)
minimizedIcon.Position = UDim2.new(0, 10, 0.5, -25)
minimizedIcon.Image = "rbxassetid://121922407716633"
minimizedIcon.Visible = false
minimizedIcon.Active = true
minimizedIcon.Draggable = true

-- Categories (Sidebar)
local categories = {"Visuals", "Player", "Misc", "Special"}
local categoryButtons = {}
local currentCategory = "Visuals"

local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0.2, 0, 0.9, 0)
sidebar.Position = UDim2.new(0, 0, 0.1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(230, 230, 230)

for i, category in ipairs(categories) do
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Position = UDim2.new(0, 0, (i-1) * 0.25, 0)
    button.Text = category
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.MouseButton1Click:Connect(function()
        currentCategory = category
        updateCategoryUI()
    end)
    categoryButtons[category] = button
end

-- Content Frame
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
contentFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
contentFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)

-- Update UI based on category
local function updateCategoryUI()
    contentFrame:ClearAllChildren()
    
    if currentCategory == "Visuals" then
        local espButtons = {"Murderer EsP", "Sheriff EsP", "Innocent EsP"}
        for i, name in ipairs(espButtons) do
            local button = Instance.new("TextButton", contentFrame)
            button.Size = UDim2.new(0.9, 0, 0, 40)
            button.Position = UDim2.new(0.05, 0, (i-1) * 0.2, 0)
            button.Text = name .. " [OFF]"
            button.MouseButton1Click:Connect(function()
                button.Text = button.Text:find("OFF") and name .. " [ON]" or name .. " [OFF]"
            end)
        end
    elseif currentCategory == "Player" then
        -- Walkspeed
        local speedLabel = Instance.new("TextLabel", contentFrame)
        speedLabel.Text = "Speed"
        speedLabel.Position = UDim2.new(0.05, 0, 0, 40)

        local speedSlider = Instance.new("TextBox", contentFrame)
        speedSlider.Text = "16"
        speedSlider.Position = UDim2.new(0.3, 0, 0, 40)
        speedSlider.FocusLost:Connect(function()
            local speed = tonumber(speedSlider.Text)
            if speed then player.Character.Humanoid.WalkSpeed = speed end
        end)
    elseif currentCategory == "Misc" then
        local miscButtons = {"Silent Aim", "Auto Farm", "Reset Character"}
        for i, name in ipairs(miscButtons) do
            local button = Instance.new("TextButton", contentFrame)
            button.Size = UDim2.new(0.9, 0, 0, 40)
            button.Position = UDim2.new(0.05, 0, (i-1) * 0.2, 0)
            button.Text = name
            button.MouseButton1Click:Connect(function()
                if name == "Reset Character" then player.Character:BreakJoints() end
            end)
        end
    end
end

updateCategoryUI()

-- Minimize / Close Logic
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
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)
