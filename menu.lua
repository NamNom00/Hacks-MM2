local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DataStoreService = game:GetService("DataStoreService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local macroDataStore = DataStoreService:GetDataStore("PlayerMacros")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.45, 0, 0.45, 0)
mainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
mainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.new(0.1, 0.1, 0.1)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.1, 0)
corner.Parent = mainFrame

local leftSide = Instance.new("Frame")
leftSide.Size = UDim2.new(0.2, 0, 1, 0)
leftSide.Position = UDim2.new(0, 0, 0, 0)
leftSide.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
leftSide.Parent = mainFrame

local cornerLeft = Instance.new("UICorner")
cornerLeft.CornerRadius = UDim.new(0.1, 0)
cornerLeft.Parent = leftSide

local macroStartButton = Instance.new("TextButton")
macroStartButton.Text = "Macro Start"
macroStartButton.Size = UDim2.new(0.8, 0, 0.1, 0)
macroStartButton.Position = UDim2.new(0.1, 0, 0.1, 0)
macroStartButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
macroStartButton.TextColor3 = Color3.new(1, 1, 1)
macroStartButton.Parent = leftSide

local recordsButton = Instance.new("TextButton")
recordsButton.Text = "Records"
recordsButton.Size = UDim2.new(0.8, 0, 0.1, 0)
recordsButton.Position = UDim2.new(0.1, 0, 0.25, 0)
recordsButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
recordsButton.TextColor3 = Color3.new(1, 1, 1)
recordsButton.Parent = leftSide

local rightSide = Instance.new("Frame")
rightSide.Size = UDim2.new(0.8, 0, 1, 0)
rightSide.Position = UDim2.new(0.2, 0, 0, 0)
rightSide.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
rightSide.Parent = mainFrame

local macroStartFrame = Instance.new("Frame")
macroStartFrame.Size = UDim2.new(1, 0, 1, 0)
macroStartFrame.Position = UDim2.new(0, 0, 0, 0)
macroStartFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
macroStartFrame.Visible = true
macroStartFrame.Parent = rightSide

local recordNameBox = Instance.new("TextBox")
recordNameBox.Text = "Enter Record Name..."
recordNameBox.Size = UDim2.new(0.8, 0, 0.1, 0)
recordNameBox.Position = UDim2.new(0.1, 0, 0.1, 0)
recordNameBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
recordNameBox.TextColor3 = Color3.new(1, 1, 1)
recordNameBox.Parent = macroStartFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Text = "⏸️ Paused"
statusLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
statusLabel.Position = UDim2.new(0.1, 0, 0.25, 0)
statusLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.Parent = macroStartFrame

local startStopButton = Instance.new("TextButton")
startStopButton.Text = "Start Record"
startStopButton.Size = UDim2.new(0.8, 0, 0.1, 0)
startStopButton.Position = UDim2.new(0.1, 0, 0.4, 0)
startStopButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
startStopButton.TextColor3 = Color3.new(1, 1, 1)
startStopButton.Parent = macroStartFrame

local recordsFrame = Instance.new("Frame")
recordsFrame.Size = UDim2.new(1, 0, 1, 0)
recordsFrame.Position = UDim2.new(0, 0, 0, 0)
recordsFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
recordsFrame.Visible = false
recordsFrame.Parent = rightSide

local filterButton = Instance.new("TextButton")
filterButton.Text = "Filter"
filterButton.Size = UDim2.new(0.1, 0, 0.05, 0)
filterButton.Position = UDim2.new(0.85, 0, 0.05, 0)
filterButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
filterButton.TextColor3 = Color3.new(1, 1, 1)
filterButton.Parent = recordsFrame

local recordsList = Instance.new("ScrollingFrame")
recordsList.Size = UDim2.new(0.9, 0, 0.8, 0)
recordsList.Position = UDim2.new(0.05, 0, 0.15, 0)
recordsList.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
recordsList.Parent = recordsFrame

local isRecording = false
local isPlaying = false
local recordedData = {}
local startPosition = nil

local function saveMacro(recordName, data)
    local success, err = pcall(function()
        macroDataStore:SetAsync(player.UserId .. "_" .. recordName, data)
    end)
    if not success then
        warn("Failed to save macro: " .. err)
    end
end

local function loadMacro(recordName)
    local success, data = pcall(function()
        return macroDataStore:GetAsync(player.UserId .. "_" .. recordName)
    end)
    if success then
        return data
    else
        warn("Failed to load macro: " .. data)
        return nil
    end
end

local function createRecordEntry(recordName)
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0.1, 0)
    entry.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    entry.Parent = recordsList

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text = recordName
    nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Parent = entry

    local starButton = Instance.new("TextButton")
    starButton.Text = "⭐"
    starButton.Size = UDim2.new(0.1, 0, 1, 0)
    starButton.Position = UDim2.new(0.65, 0, 0, 0)
    starButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    starButton.Parent = entry

    local playButton = Instance.new("TextButton")
    playButton.Text = "Play"
    playButton.Size = UDim2.new(0.2, 0, 1, 0)
    playButton.Position = UDim2.new(0.8, 0, 0, 0)
    playButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    playButton.Parent = entry

    playButton.MouseButton1Click:Connect(function()
        local data = loadMacro(recordName)
        if data then
            isPlaying = true
            player.Character:SetPrimaryPartCFrame(data.startPosition)
            for _, action in pairs(data.actions) do
                wait(action.delay)
                player.Character:SetPrimaryPartCFrame(action.position)
            end
            isPlaying = false
        end
    end)
end

startStopButton.MouseButton1Click:Connect(function()
    if isRecording then
        isRecording = false
        statusLabel.Text = "⏸️ Paused"
        startStopButton.Text = "Start Record"
        local recordName = recordNameBox.Text == "Enter Record Name..." and "Record-" .. tostring(#recordsList:GetChildren()) or recordNameBox.Text
        saveMacro(recordName, {startPosition = startPosition, actions = recordedData})
        createRecordEntry(recordName)
        recordedData = {}
    else
        isRecording = true
        statusLabel.Text = "▶️ Playing"
        startStopButton.Text = "Stop Record"
        startPosition = player.Character.PrimaryPart.CFrame
        recordedData = {}
    end
end)

RunService.Heartbeat:Connect(function()
    if isRecording and not isPlaying then
        table.insert(recordedData, {
            position = player.Character.PrimaryPart.CFrame,
            delay = RunService.Heartbeat:Wait()
        })
    end
end)

macroStartButton.MouseButton1Click:Connect(function()
    macroStartFrame.Visible = true
    recordsFrame.Visible = false
end)

recordsButton.MouseButton1Click:Connect(function()
    macroStartFrame.Visible = false
    recordsFrame.Visible = true
end)
