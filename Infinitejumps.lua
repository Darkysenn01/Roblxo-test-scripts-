local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Función para saltar infinitamente
RunService.Heartbeat:Connect(function()
    if humanoid.FloorMaterial ~= Enum.Material.Air then
        humanoid.Jump = true
    end
end)
