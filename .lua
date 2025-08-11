-- WallHop Pro Script con movimientos locos al saltar sin pared
-- Por [Amabley13]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local wallDistance = 5 -- distancia para detectar pared
local jumpPower = humanoid.JumpPower
local isWallNearby = false

-- Función para detectar paredes a los lados
local function checkWalls()
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist

    local leftRay = workspace:Raycast(rootPart.Position, rootPart.CFrame.LeftVector * wallDistance, rayParams)
    local rightRay = workspace:Raycast(rootPart.Position, rootPart.CFrame.RightVector * wallDistance, rayParams)

    isWallNearby = (leftRay or rightRay) ~= nil
end

-- Función para movimientos locos cuando no hay pared y saltas
local function crazyMove()
    local tweenService = game:GetService("TweenService")
    local angles = {45, -45, 90, -90, 180}
    local chosenAngle = angles[math.random(1, #angles)]

    local goal = {CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(chosenAngle), 0)}
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

    local tween = tweenService:Create(rootPart, tweenInfo, goal)
    tween:Play()
end

-- Detectar cuando el jugador salta
humanoid.Jumping:Connect(function()
    checkWalls()
    if isWallNearby then
        -- Aquí podrías hacer el WallHop normal (p. ej. saltar y moverse pegado a la pared)
        print("WallHop activado")
        -- Puedes agregar aquí más lógica para saltar pegado a la pared si quieres
    else
        print("Sin pared, haciendo movimientos locos")
        crazyMove()
    end
end)

-- Interfaz básica (ScreenGui con texto)
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

print("Script WallHop listo para usar")
