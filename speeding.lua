local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local assistForce = 10
local moveForward = false
local moveBackward = false
local guiVisible = true
local boostEnabled = true
local boostToggleKey = Enum.KeyCode.E
local menuToggleKey = Enum.KeyCode.Insert


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VelocityGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 240)
frame.Position = UDim2.new(0.5, -110, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = screenGui


local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(1, 12, 99)
titleBar.TextColor3 = Color3.fromRGB(255, 233, 0)
titleBar.Text = "Brick Booster     by VAC2"
titleBar.Font = Enum.Font.SourceSansBold
titleBar.TextSize = 24
titleBar.Parent = frame


local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 180, 0, 20)
speedLabel.Position = UDim2.new(0, 20, 0, 40)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Text = "Boost Speed:"
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextSize = 16
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 180, 0, 30)
textBox.Position = UDim2.new(0, 20, 0, 60)
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
textBox.PlaceholderText = "Enter speed (e.g., 10)"
textBox.Text = tostring(assistForce)
textBox.Font = Enum.Font.SourceSans
textBox.TextSize = 16
textBox.Parent = frame

local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0, 180, 0, 30)
applyButton.Position = UDim2.new(0, 20, 0, 100)
applyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.Text = "Apply Speed"
applyButton.Font = Enum.Font.SourceSans
applyButton.TextSize = 16
applyButton.Parent = frame


local toggleKeyLabel = Instance.new("TextLabel")
toggleKeyLabel.Size = UDim2.new(0, 180, 0, 20)
toggleKeyLabel.Position = UDim2.new(0, 20, 0, 140)
toggleKeyLabel.BackgroundTransparency = 1
toggleKeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleKeyLabel.Text = "Toggle Key:"
toggleKeyLabel.Font = Enum.Font.SourceSans
toggleKeyLabel.TextSize = 16
toggleKeyLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleKeyLabel.Parent = frame

local toggleBoostButton = Instance.new("TextButton")
toggleBoostButton.Size = UDim2.new(0, 120, 0, 30)
toggleBoostButton.Position = UDim2.new(0, 20, 0, 160)
toggleBoostButton.BackgroundColor3 = Color3.fromRGB(0, 100, 16)
toggleBoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBoostButton.Text = "ON"
toggleBoostButton.Font = Enum.Font.SourceSans
toggleBoostButton.TextSize = 16
toggleBoostButton.Parent = frame

local boostKeybindButton = Instance.new("TextButton")
boostKeybindButton.Size = UDim2.new(0, 50, 0, 30)
boostKeybindButton.Position = UDim2.new(0, 150, 0, 160)
boostKeybindButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
boostKeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
boostKeybindButton.Text = boostToggleKey.Name
boostKeybindButton.Font = Enum.Font.SourceSans
boostKeybindButton.TextSize = 14
boostKeybindButton.Parent = frame


local menuKeyLabel = Instance.new("TextLabel")
menuKeyLabel.Size = UDim2.new(0, 180, 0, 20)
menuKeyLabel.Position = UDim2.new(0, 20, 0, 200)
menuKeyLabel.BackgroundTransparency = 1
menuKeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
menuKeyLabel.Text = "Menu Key:"
menuKeyLabel.Font = Enum.Font.SourceSans
menuKeyLabel.TextSize = 16
menuKeyLabel.TextXAlignment = Enum.TextXAlignment.Left
menuKeyLabel.Parent = frame

local menuKeybindButton = Instance.new("TextButton")
menuKeybindButton.Size = UDim2.new(0, 50, 0, 30)
menuKeybindButton.Position = UDim2.new(0, 150, 0, 200)
menuKeybindButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
menuKeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
menuKeybindButton.Text = menuToggleKey.Name
menuKeybindButton.Font = Enum.Font.SourceSans
menuKeybindButton.TextSize = 14
menuKeybindButton.Parent = frame


local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
uiCorner:Clone().Parent = titleBar
uiCorner:Clone().Parent = textBox
uiCorner:Clone().Parent = applyButton
uiCorner:Clone().Parent = toggleBoostButton
uiCorner:Clone().Parent = boostKeybindButton
uiCorner:Clone().Parent = menuKeybindButton


local function lerpColor(color1, color2, t)
    return Color3.new(
        color1.R + (color2.R - color1.R) * t,
        color1.G + (color2.G - color1.G) * t,
        color1.B + (color2.B - color1.B) * t
    )
end

local colors = {
    Color3.fromRGB(50, 50, 50),
    Color3.fromRGB(70, 50, 70),
    Color3.fromRGB(50, 70, 50),
    Color3.fromRGB(70, 70, 50)
}
local colorIndex = 1
local colorTransitionTime = 3
local elapsedTime = 0

RunService.RenderStepped:Connect(function(dt)
    elapsedTime = elapsedTime + dt
    local t = elapsedTime / colorTransitionTime
    if t > 1 then
        t = 0
        elapsedTime = 0
        colorIndex = colorIndex % #colors + 1
    end
    local nextIndex = colorIndex % #colors + 1
    frame.BackgroundColor3 = lerpColor(colors[colorIndex], colors[nextIndex], t)
end)


local isDragging = false
local lastMousePos = nil


local function clampToScreen(position)
    local screenSize = workspace.CurrentCamera.ViewportSize
    local frameSize = frame.AbsoluteSize
    local minX = 0
    local maxX = screenSize.X - frameSize.X
    local minY = 0
    local maxY = screenSize.Y - frameSize.Y
    return Vector2.new(
        math.clamp(position.X, minX, maxX),
        math.clamp(position.Y, minY, maxY)
    )
end


titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        lastMousePos = input.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local currentMousePos = input.Position
        if lastMousePos then
            local delta = Vector2.new(currentMousePos.X - lastMousePos.X, currentMousePos.Y - lastMousePos.Y)
            local currentPos = frame.AbsolutePosition
            local newPos = clampToScreen(currentPos + delta)
            frame.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
        end
        lastMousePos = currentMousePos
    end
end)


UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == menuToggleKey then
        guiVisible = not guiVisible
        frame.Visible = guiVisible
    elseif input.KeyCode == boostToggleKey then
        boostEnabled = not boostEnabled
        toggleBoostButton.BackgroundColor3 = boostEnabled and Color3.fromRGB(0, 100, 16) or Color3.fromRGB(200, 0, 0)
        toggleBoostButton.Text = boostEnabled and "ON" or "OFF"
    elseif input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.ButtonR2 then
        moveForward = true
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.ButtonL2 then
        moveBackward = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.ButtonR2 then
        moveForward = false
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.ButtonL2 then
        moveBackward = false
    end
end)


applyButton.MouseButton1Click:Connect(function()
    local inputSpeed = tonumber(textBox.Text)
    if inputSpeed and inputSpeed >= 0 then
        assistForce = inputSpeed
        textBox.Text = tostring(assistForce)
    else
        textBox.Text = tostring(assistForce)
        textBox.PlaceholderText = "Invalid speed!"
    end
end)


local settingBoostKeybind = false
boostKeybindButton.MouseButton1Click:Connect(function()
    settingBoostKeybind = true
    boostKeybindButton.Text = "..."
end)


local settingMenuKeybind = false
menuKeybindButton.MouseButton1Click:Connect(function()
    settingMenuKeybind = true
    menuKeybindButton.Text = "..."
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if settingBoostKeybind then
            boostToggleKey = input.KeyCode
            boostKeybindButton.Text = boostToggleKey.Name
            settingBoostKeybind = false
        elseif settingMenuKeybind then
            menuToggleKey = input.KeyCode
            menuKeybindButton.Text = menuToggleKey.Name
            settingMenuKeybind = false
        end
    end
end)


local heartbeatConnection = nil

local function setupCharacter(character)
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end

    local model = workspace:WaitForChild(player.Name, 5)
    if not model then
        warn("Character model not found in workspace")
        return
    end

    local root = model:WaitForChild("Root", 5)
    if not root then
        warn("Root part not found in character model")
        return
    end
p
    heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
        if not root:IsDescendantOf(workspace) or not boostEnabled then return end

        local direction = Vector3.zero
        if moveForward then
            direction = root.CFrame.LookVector * assistForce
        elseif moveBackward then
            direction = -root.CFrame.LookVector * assistForce
        end

        root.Velocity = root.Velocity + (direction * dt)
    end)
end


if player.Character then
    setupCharacter(player.Character)
end


player.CharacterAdded:Connect(setupCharacter)