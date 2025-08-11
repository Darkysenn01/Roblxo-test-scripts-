local player = game.Players.LocalPlayer
local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid") or player.CharacterAdded:Wait():WaitForChild("Humanoid")

while true do
    if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
        humanoid.Jump = true
    end
    wait(0.1)
end
