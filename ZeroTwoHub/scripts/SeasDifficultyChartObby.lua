repeat
local v = game.Workspace.Checkpoints:FindFirstChild(game.Players.LocalPlayer.leaderstats.Stage.Value + 1)
if(v) then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame 
wait(0.05)
end
until v == nil
for i,v in pairs(game.Workspace:GetDescendants()) do
    if(v.Name == "Badge") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame 
        wait(0.25)
    end
end
