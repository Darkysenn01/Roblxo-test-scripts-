-- WallHop Pro Script con movimientos locos al saltar sin pared
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local wallDistance = 5
local tweenService = game:GetService("TweenService")

local function checkWalls()
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist

    local leftRay = workspace:Raycast(rootPart.Position, rootPart.CFrame.LeftVector * wallDistance, rayParams)
    local rightRay = workspace:Raycast(rootPart.Position, rootPart.CFrame.RightVector * wallDistance, rayParams)

    return (leftRay or rightRay) ~= nil
end

local function crazyMove()
    local angles = {45, -45, 90, -90, 180}
    local chosenAngle = angles[math.random(1, #angles)]
    local goal = {CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(chosenAngle), 0)}
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    local tween = tweenService:Create(rootPart, tweenInfo, goal)
    tween:Play()
end

humanoid.Jumping:Connect(function()
    if checkWalls() then
        print("WallHop activado")
    else
        print("Movimientos locos activados")
        crazyMove()
    end
end)

-- Interfaz sencilla
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "WallHopProGUI"

local textLabel = Instance.new("TextLabel", screenGui)
textLabel.Size = UDim2.new(0, 200, 0, 50)
textLabel.Position = UDim2.new(0.5, -100, 0, 20)
textLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.Text = "WallHop Pro Activado"
textLabel.TextScaled = true
textLabel.Font = Enum.Font.SourceSansBold