local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local wallDistance = 6 -- distancia para detectar paredes

-- Función para detectar paredes a los lados
local function isNearWall()
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist

    local leftRay = workspace:Raycast(rootPart.Position, rootPart.CFrame.LeftVector * wallDistance, rayParams)
    local rightRay = workspace:Raycast(rootPart.Position, rootPart.CFrame.RightVector * wallDistance, rayParams)

    return leftRay or rightRay
end

-- Movimiento loco: gira el personaje 180 grados rápidamente
local function crazyMove()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
    local goal = {CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(180), 0)}
    local tween = TweenService:Create(rootPart, tweenInfo, goal)
    tween:Play()
end

-- Interfaz en pantalla
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "WallHopProGUI"

local textLabel = Instance.new("TextLabel", screenGui)
textLabel.Size = UDim2.new(0, 300, 0, 50)
textLabel.Position = UDim2.new(0.5, -150, 0, 20)
textLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.SourceSansBold
textLabel.Text = "Esperando salto..."

-- Detectar salto y aplicar lógica
humanoid.Jumping:Connect(function()
    if isNearWall() then
        textLabel.Text = "Pared detectada: WallHop activado"
        print("WallHop activado")
    else
        textLabel.Text = "Movimientos locos activados!"
        crazyMove()
        print("Movimientos locos activados")
    end

    wait(0.5)
    textLabel.Text = "Esperando salto..."
end)
