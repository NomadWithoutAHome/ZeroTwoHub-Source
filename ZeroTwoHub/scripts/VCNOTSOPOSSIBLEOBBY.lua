while game.Players.LocalPlayer.leaderstats.Stage.Value ~= 27 and wait() do
for i,v in pairs(game.Workspace:GetDescendants()) do
    if(v:IsA("SpawnLocation")) then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame 
        wait(0.05)
    end
end
end
