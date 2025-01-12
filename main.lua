-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

-- Variables
local Coins = 1000000
local Football = 3
local MECH_WalkSpeed = 15

-- Configure GUI
ScreenGui.Name = "CustomGUI"
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.BorderSizePixel = 0
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Function to create slider entries
local function createSliderEntry(name, minValue, maxValue, defaultValue, callback)
    local EntryFrame = Instance.new("Frame")
    local NameLabel = Instance.new("TextLabel")
    local SliderFrame = Instance.new("Frame")
    local SliderBar = Instance.new("Frame")
    local SliderHandle = Instance.new("Frame")
    local ValueLabel = Instance.new("TextLabel")

    -- Configure entry frame
    EntryFrame.Parent = MainFrame
    EntryFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    EntryFrame.Size = UDim2.new(1, 0, 0, 50)

    NameLabel.Parent = EntryFrame
    NameLabel.Text = name
    NameLabel.Font = Enum.Font.SourceSans
    NameLabel.TextColor3 = Color3.new(1, 1, 1)
    NameLabel.TextScaled = true
    NameLabel.BackgroundTransparency = 1
    NameLabel.Size = UDim2.new(0.5, 0, 1, 0)

    SliderFrame.Parent = EntryFrame
    SliderFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    SliderFrame.Size = UDim2.new(0.4, 0, 0.4, 0)
    SliderFrame.Position = UDim2.new(0.5, 0, 0.3, 0)

    SliderBar.Parent = SliderFrame
    SliderBar.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    SliderBar.Size = UDim2.new(1, 0, 0.5, 0)
    SliderBar.Position = UDim2.new(0, 0, 0.25, 0)

    SliderHandle.Parent = SliderBar
    SliderHandle.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    SliderHandle.Size = UDim2.new(0, 10, 1, 0)
    SliderHandle.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 0, 0)

    ValueLabel.Parent = EntryFrame
    ValueLabel.Text = tostring(defaultValue)
    ValueLabel.Font = Enum.Font.SourceSans
    ValueLabel.TextColor3 = Color3.new(1, 1, 1)
    ValueLabel.TextScaled = true
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Size = UDim2.new(0.1, 0, 1, 0)
    ValueLabel.Position = UDim2.new(0.9, 0, 0, 0)

    -- Handle slider dragging
    local isDragging = false
    SliderHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
        end
    end)
    SliderHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = math.clamp(input.Position.X - SliderBar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
            local percentage = relativeX / SliderBar.AbsoluteSize.X
            local value = math.floor((minValue + (maxValue - minValue) * percentage) + 0.5)
            SliderHandle.Position = UDim2.new(percentage, 0, 0, 0)
            ValueLabel.Text = tostring(value)
            callback(value)
        end
    end)
end

-- Coins Slider
createSliderEntry("Coins", 1000000, 20000000, Coins, function(value)
    Coins = value
    print("Coins set to: " .. Coins)
end)

-- Walk Speed Slider
createSliderEntry("Walk Speed", 15, 35, MECH_WalkSpeed, function(value)
    MECH_WalkSpeed = value
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = MECH_WalkSpeed
    end
    print("Walk Speed set to: " .. MECH_WalkSpeed)
end)

-- Hitbox Resizer Slider
createSliderEntry("Hitbox Resizer", 3, 50, Football, function(value)
    Football = value
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local football = character:FindFirstChild("Football")
    if football then
        football.Size = Vector3.new(Football, Football, Football)
    end
    print("Football hitbox set to: " .. Football .. " studs")
end)

-- QB Aimbot (N/A entry)
local function createNAEntry(name)
    local EntryFrame = Instance.new("Frame")
    local NameLabel = Instance.new("TextLabel")
    local NA_Label = Instance.new("TextLabel")

    EntryFrame.Parent = MainFrame
    EntryFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    EntryFrame.Size = UDim2.new(1, 0, 0, 50)

    NameLabel.Parent = EntryFrame
    NameLabel.Text = name
    NameLabel.Font = Enum.Font.SourceSans
    NameLabel.TextColor3 = Color3.new(1, 1, 1)
    NameLabel.TextScaled = true
    NameLabel.BackgroundTransparency = 1
    NameLabel.Size = UDim2.new(0.5, 0, 1, 0)

    NA_Label.Parent = EntryFrame
    NA_Label.Text = "N/A"
    NA_Label.Font = Enum.Font.SourceSans
    NA_Label.TextColor3 = Color3.new(1, 1, 1)
    NA_Label.TextScaled = true
    NA_Label.BackgroundTransparency = 1
    NA_Label.Size = UDim2.new(0.5, 0, 1, 0)
    NA_Label.Position = UDim2.new(0.5, 0, 0, 0)
end

createNAEntry("QB Aimbot")
