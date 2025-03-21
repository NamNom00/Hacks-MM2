-- Roblox Lua Script for NamHack MM2 GUI
-- Created for educational purposes only

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildWhichIsA("Humanoid")
local mouse = player:GetMouse()

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.6, 0, 0.6, 0) -- 60% of screen
mainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.new(1, 1, 1) -- White background
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.new(1, 0, 0) -- Red outline
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Text = "NamHack MM2"
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
title.TextColor3 = Color3.new(0, 0, 0)
title.Parent = mainFrame

-- Minimize and Close Buttons
local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.Parent = mainFrame

local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "_"
minimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
minimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
minimizeButton.BackgroundColor3 = Color3.new(0, 1, 0)
minimizeButton.Parent = mainFrame

-- Minimize Icon
local minimizeIcon = Instance.new("ImageButton")
minimizeIcon.Image = "rbxassetid://121922407716633"
minimizeIcon.Size = UDim2.new(0.05, 0, 0.05, 0)
minimizeIcon.Position = UDim2.new(0, 0, 0.95, 0)
minimizeIcon.Visible = false
minimizeIcon.Parent = screenGui

-- Categories
local categories = {"Visuals", "Player", "Misc", "Teleports"}
local categoryButtons = {}

for i, category in pairs(categories) do
    local button = Instance.new("TextButton")
    button.Text = category
    button.Size = UDim2.new(0.2, 0, 0.1, 0)
    button.Position = UDim2.new(0, 0, 0.1 * i, 0)
    button.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    button.Parent = mainFrame
    table.insert(categoryButtons, button)
end

-- Visuals Tab
local visualsFrame = Instance.new("Frame")
visualsFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
visualsFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
visualsFrame.BackgroundColor3 = Color3.new(1, 1, 1)
visualsFrame.Visible = false
visualsFrame.Parent = mainFrame

local murdererESP = Instance.new("TextButton")
murdererESP.Text = "Murderer ESP"
murdererESP.Size = UDim2.new(0.8, 0, 0.1, 0)
murdererESP.Position = UDim2.new(0.1, 0, 0.1, 0)
murdererESP.Parent = visualsFrame

local sheriffESP = Instance.new("TextButton")
sheriffESP.Text = "Sheriff ESP"
sheriffESP.Size = UDim2.new(0.8, 0, 0.1, 0)
sheriffESP.Position = UDim2.new(0.1, 0, 0.3, 0)
sheriffESP.Parent = visualsFrame

local innocentESP = Instance.new("TextButton")
innocentESP.Text = "Innocent ESP"
innocentESP.Size = UDim2.new(0.8, 0, 0.1, 0)
innocentESP.Position = UDim2.new(0.1, 0, 0.5, 0)
innocentESP.Parent = visualsFrame

-- Player Tab
local playerFrame = Instance.new("Frame")
playerFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
playerFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
playerFrame.BackgroundColor3 = Color3.new(1, 1, 1)
playerFrame.Visible = false
playerFrame.Parent = mainFrame

local walkspeedSlider = Instance.new("TextButton")
walkspeedSlider.Text = "Walkspeed"
walkspeedSlider.Size = UDim2.new(0.8, 0, 0.1, 0)
walkspeedSlider.Position = UDim2.new(0.1, 0, 0.1, 0)
walkspeedSlider.Parent = playerFrame

local jumpBoostSlider = Instance.new("TextButton")
jumpBoostSlider.Text = "Jump Boost"
jumpBoostSlider.Size = UDim2.new(0.8, 0, 0.1, 0)
jumpBoostSlider.Position = UDim2.new(0.1, 0, 0.3, 0)
jumpBoostSlider.Parent = playerFrame

local immortalityButton = Instance.new("TextButton")
immortalityButton.Text = "Immortality"
immortalityButton.Size = UDim2.new(0.8, 0, 0.1, 0)
immortalityButton.Position = UDim2.new(0.1, 0, 0.5, 0)
immortalityButton.Parent = playerFrame

-- Misc Tab
local miscFrame = Instance.new("Frame")
miscFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
miscFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
miscFrame.BackgroundColor3 = Color3.new(1, 1, 1)
miscFrame.Visible = false
miscFrame.Parent = mainFrame

local silentAimButton = Instance.new("TextButton")
silentAimButton.Text = "Silent Aim"
silentAimButton.Size = UDim2.new(0.8, 0, 0.1, 0)
silentAimButton.Position = UDim2.new(0.1, 0, 0.1, 0)
silentAimButton.Parent = miscFrame

local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Text = "Auto Farm"
autoFarmButton.Size = UDim2.new(0.8, 0, 0.1, 0)
autoFarmButton.Position = UDim2.new(0.1, 0, 0.3, 0)
autoFarmButton.Parent = miscFrame

local resetCharacterButton = Instance.new("TextButton")
resetCharacterButton.Text = "Reset Character"
resetCharacterButton.Size = UDim2.new(0.8, 0, 0.1, 0)
resetCharacterButton.Position = UDim2.new(0.1, 0, 0.5, 0)
resetCharacterButton.Parent = miscFrame

local redeemCodesButton = Instance.new("TextButton")
redeemCodesButton.Text = "Redeem all Codes"
redeemCodesButton.Size = UDim2.new(0.8, 0, 0.1, 0)
redeemCodesButton.Position = UDim2.new(0.1, 0, 0.7, 0)
redeemCodesButton.Parent = miscFrame

local antiCheatButton = Instance.new("TextButton")
antiCheatButton.Text = "Anti-Cheat"
antiCheatButton.Size = UDim2.new(0.8, 0, 0.1, 0)
antiCheatButton.Position = UDim2.new(0.1, 0, 0.9, 0)
antiCheatButton.Parent = miscFrame

-- Teleports Tab
local teleportsFrame = Instance.new("Frame")
teleportsFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
teleportsFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
teleportsFrame.BackgroundColor3 = Color3.new(1, 1, 1)
teleportsFrame.Visible = false
teleportsFrame.Parent = mainFrame

local lobbyButton = Instance.new("TextButton")
lobbyButton.Text = "Lobby"
lobbyButton.Size = UDim2.new(0.8, 0, 0.1, 0)
lobbyButton.Position = UDim2.new(0.1, 0, 0.1, 0)
lobbyButton.Parent = teleportsFrame

local gameButton = Instance.new("TextButton")
gameButton.Text = "Game"
gameButton.Size = UDim2.new(0.8, 0, 0.1, 0)
gameButton.Position = UDim2.new(0.1, 0, 0.3, 0)
gameButton.Parent = teleportsFrame

local safeZoneButton = Instance.new("TextButton")
safeZoneButton.Text = "Safe Zone"
safeZoneButton.Size = UDim2.new(0.8, 0, 0.1, 0)
safeZoneButton.Position = UDim2.new(0.1, 0, 0.5, 0)
safeZoneButton.Parent = teleportsFrame

-- ESP Function
local function createESP(target, color)
    if target and target:FindFirstChild("Head") then
        local highlight = Instance.new("BoxHandleAdornment")
        highlight.Size = target.Head.Size + Vector3.new(1, 1, 1)
        highlight.Adornee = target.Head
        highlight.Color3 = color
        highlight.Transparency = 0.5
        highlight.AlwaysOnTop = true
        highlight.Parent = target
    end
end

-- Functionality for Visuals
murdererESP.MouseButton1Click:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player and v.Backpack:FindFirstChild("Knife") then
            createESP(v.Character, Color3.new(1, 0, 0)) -- Red for Murderer
        end
    end
end)

sheriffESP.MouseButton1Click:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player and v.Backpack:FindFirstChild("Gun") then
            createESP(v.Character, Color3.new(0, 0, 1)) -- Blue for Sheriff
        end
    end
end)

innocentESP.MouseButton1Click:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player and not v.Backpack:FindFirstChild("Gun") and not v.Backpack:FindFirstChild("Knife") then
            createESP(v.Character, Color3.new(0, 1, 0)) -- Green for Innocent
        end
    end
end)

-- Walk Speed and Jump Boost
walkspeedSlider.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = 50 -- Default is 16
end)

jumpBoostSlider.MouseButton1Click:Connect(function()
    humanoid.JumpPower = 100 -- Default is 50
end)

-- Immortality
immortalityButton.MouseButton1Click:Connect(function()
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
end)

-- Silent Aim (Basic Example)
silentAimButton.MouseButton1Click:Connect(function()
    local target = nil
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player then
            target = v.Character and v.Character:FindFirstChild("Head")
            break
        end
    end
    if target then
        mouse.TargetFilter = target.Parent
    end
end)

-- Auto Farm (Coin Collection Example)
autoFarmButton.MouseButton1Click:Connect(function()
    for _, v in pairs(Workspace:GetChildren()) do
        if v:IsA("Part") and v.Name == "Coin" then
            character:SetPrimaryPartCFrame(v.CFrame)
            wait(0.2)
        end
    end
end)

-- Reset Character
resetCharacterButton.MouseButton1Click:Connect(function()
    character:BreakJoints()
end)

-- Redeem All Codes
redeemCodesButton.MouseButton1Click:Connect(function()
    local codes = {"CODE1", "CODE2", "CODE3"} -- Replace with actual codes
    for _, code in pairs(codes) do
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", code)
    end
end)

-- Anti-Cheat Bypass
antiCheatButton.MouseButton1Click:Connect(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldIndex = mt.__index
    mt.__index = newcclosure(function(t, k)
        if k == "Kick" then
            return function() end -- Disables kick function
        end
        return oldIndex(t, k)
    end)
end)

-- Teleportation Functions
lobbyButton.MouseButton1Click:Connect(function()
    character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, 10, 0))) -- Change coordinates as needed
end)

gameButton.MouseButton1Click:Connect(function()
    character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(50, 10, 50))) -- Change coordinates as needed
end)

safeZoneButton.MouseButton1Click:Connect(function()
    character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(-50, 10, -50))) -- Change coordinates as needed
end)

-- Category Switching
for i, button in pairs(categoryButtons) do
    button.MouseButton1Click:Connect(function()
        visualsFrame.Visible = false
        playerFrame.Visible = false
        miscFrame.Visible = false
        teleportsFrame.Visible = false

        if i == 1 then
            visualsFrame.Visible = true
        elseif i == 2 then
            playerFrame.Visible = true
        elseif i == 3 then
            miscFrame.Visible = true
        elseif i == 4 then
            teleportsFrame.Visible = true
        end
    end)
end

-- Minimize and Close Functionality
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizeIcon.Visible = true
end)

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizeIcon.Visible = true
end)

minimizeIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    minimizeIcon.Visible = false
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
        minimizeIcon.Visible = not mainFrame.Visible
    end
end)
