-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

-- Variables
local Coins = 1000000 -- Default coins value
local Football = 3 -- Default football hitbox size
local MECH_WalkSpeed = 15 -- Default walk speed

-- Configure GUI properties
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

-- Function to create a slider entry
local function createEntry(name, hasSlider)
    local EntryFrame = Instance.new("Frame")
    local NameLabel = Instance.new("TextLabel")
    local SliderFrame = Instance.new("Frame")
    local SliderText = Instance.new("TextLabel")
    
    EntryFrame.Parent = MainFrame
    EntryFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    EntryFrame.Size = UDim2.new(1, 0, 0, 40)
    
    NameLabel.Parent = EntryFrame
    NameLabel.Text = name
    NameLabel.Font = Enum.Font.SourceSans
    NameLabel.TextColor3 = Color3.new(1, 1, 1)
    NameLabel.TextScaled = true
    NameLabel.BackgroundTransparency = 1
    NameLabel.Size = UDim2.new(0.5, 0, 1, 0)
    
    SliderFrame.Parent = EntryFrame
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Size = UDim2.new(0.5, 0, 1, 0)
    SliderFrame.Position = UDim2.new(0.5, 0, 0, 0)
    
    if hasSlider then
        if name == "Walk Speed" then
            -- Slider for Walk Speed
            local Slider = Instance.new("TextButton")
            local Display = Instance.new("TextLabel")

            Slider.Parent = SliderFrame
            Slider.Text = "Adjust Speed"
            Slider.Font = Enum.Font.SourceSans
            Slider.TextColor3 = Color3.new(1, 1, 1)
            Slider.TextScaled = true
            Slider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            Slider.Size = UDim2.new(0.9, 0, 0.4, 0)
            Slider.Position = UDim2.new(0.05, 0, 0.1, 0)

            Display.Parent = SliderFrame
            Display.Text = tostring(MECH_WalkSpeed)
            Display.Font = Enum.Font.SourceSans
            Display.TextColor3 = Color3.new(1, 1, 1)
            Display.TextScaled = true
            Display.BackgroundTransparency = 1
            Display.Position = UDim2.new(0, 0, 0.5, 0)
            Display.Size = UDim2.new(1, 0, 0.5, 0)

            Slider.MouseButton1Click:Connect(function()
                -- Cycle through walk speed values
                MECH_WalkSpeed = MECH_WalkSpeed + 1
                if MECH_WalkSpeed > 35 then
                    MECH_WalkSpeed = 15
                end
                Display.Text = tostring(MECH_WalkSpeed)
                -- Update walk speed
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = MECH_WalkSpeed
                end
                print("Walk Speed set to: " .. MECH_WalkSpeed)
            end)
        elseif name == "Coins" then
            -- Slider for Coins
            local Slider = Instance.new("TextButton")
            local Display = Instance.new("TextLabel")

            Slider.Parent = SliderFrame
            Slider.Text = "Set Coins"
            Slider.Font = Enum.Font.SourceSans
            Slider.TextColor3 = Color3.new(1, 1, 1)
            Slider.TextScaled = true
            Slider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            Slider.Size = UDim2.new(0.9, 0, 0.4, 0)
            Slider.Position = UDim2.new(0.05, 0, 0.1, 0)

            Display.Parent = SliderFrame
            Display.Text = tostring(Coins)
            Display.Font = Enum.Font.SourceSans
            Display.TextColor3 = Color3.new(1, 1, 1)
            Display.TextScaled = true
            Display.BackgroundTransparency = 1
            Display.Position = UDim2.new(0, 0, 0.5, 0)
            Display.Size = UDim2.new(1, 0, 0.5, 0)

            Slider.MouseButton1Click:Connect(function()
                -- Cycle through values
                Coins = Coins + 1000000
                if Coins > 20000000 then
                    Coins = 1000000
                end
                Display.Text = tostring(Coins)
                print("Coins set to: " .. Coins)
            end)
        elseif name == "Hitbox Resizer" then
            -- Slider for Football hitbox
            local Slider = Instance.new("TextButton")
            local Display = Instance.new("TextLabel")

            Slider.Parent = SliderFrame
            Slider.Text = "Adjust Hitbox"
            Slider.Font = Enum.Font.SourceSans
            Slider.TextColor3 = Color3.new(1, 1, 1)
            Slider.TextScaled = true
            Slider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            Slider.Size = UDim2.new(0.9, 0, 0.4, 0)
            Slider.Position = UDim2.new(0.05, 0, 0.1, 0)

            Display.Parent = SliderFrame
            Display.Text = tostring(Football) .. " studs"
            Display.Font = Enum.Font.SourceSans
            Display.TextColor3 = Color3.new(1, 1, 1)
            Display.TextScaled = true
            Display.BackgroundTransparency = 1
            Display.Position = UDim2.new(0, 0, 0.5, 0)
            Display.Size = UDim2.new(1, 0, 0.5, 0)

            Slider.MouseButton1Click:Connect(function()
                -- Cycle through hitbox sizes
                Football = Football + 1
                if Football > 50 then
                    Football = 3
                end
                Display.Text = tostring(Football) .. " studs"
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local football = character:FindFirstChild("Football")
                if football then
                    football.Size = Vector3.new(Football, Football, Football)
                end
                print("Football hitbox set to: " .. Football .. " studs")
            end)
        end
    else
        SliderText.Parent = SliderFrame
        SliderText.Text = "N/A"
        SliderText.Font = Enum.Font.SourceSans
        SliderText.TextColor3 = Color3.new(1, 1, 1)
        SliderText.TextScaled = true
        SliderText.BackgroundTransparency = 1
        SliderText.Size = UDim2.new(1, 0, 1, 0)
    end
end

-- Add entries
createEntry("Coins", true)
createEntry("Walk Speed", true)
createEntry("Magnets", true)
createEntry("Hitbox Resizer", true)
createEntry("QB Aimbot", false)
