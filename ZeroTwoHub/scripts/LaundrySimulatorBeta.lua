local a = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest.lua"))
local b = a:CreateWindow("ZeroTwo Hub")
local c = b:CreateFolder("Main")
local d = game.Players.LocalPlayer
local e

function tpcfr(cfr)
  d.Character.HumanoidRootPart.CFrame = cfr
end


repeat
    for f, g in pairs(workspace.Plots:GetChildren()) do
        if (g.Owner.Value == d) then
            e = g
        end
    end
    wait()
until e ~= nil
c:Toggle2("Grab Clothing",function()
  for g, h in pairs(game:GetService("Workspace").Debris.Clothing:GetChildren()) do
      if (h:IsA("MeshPart")) then
          game:GetService("ReplicatedStorage").Events.GrabClothing:FireServer(h) --optimization be like
          wait()
      end
  end
end)
c:Toggle2("Load clothing",function(f)
  for g, h in pairs(e.WashingMachines:GetChildren()) do
    if (h:FindFirstChild("Config")) then
      if (not h.Config.Started.Value) then
        game:GetService("ReplicatedStorage").Events.LoadWashingMachine:FireServer(h)
        wait()
      end
    end
  end
end)
c:Toggle2("Unload clothing",function(f)
  for g, h in pairs(e.WashingMachines:GetChildren()) do
    if (h:FindFirstChild("Config")) then
      if (h.Config.CycleFinished.Value) then
        game:GetService("ReplicatedStorage").Events.UnloadWashingMachine:FireServer(h)
        wait()
      end
    end
  end
end)
c:Toggle2("Drop clothes off",function(f)
  game:GetService("ReplicatedStorage").Events.DropClothesInChute:FireServer()
end)
c:Button("Open Shop",function()
  firetouchinterest(game:GetService("Workspace").ArchysShopEntrance.Open, d.Character.HumanoidRootPart, 0)
  wait()
  firetouchinterest(game:GetService("Workspace").ArchysShopEntrance.Open, d.Character.HumanoidRootPart, 1)
end)
c:Button("Plot TP",function()
  tpcfr(e.Base.CFrame + Vector3.new(0, 4, 0))
end)
c:Toggle2("Auto TP",function()
  tpcfr(CFrame.new(-67.0951385, 1, -10.8704834))
  wait(1)
  tpcfr(game:GetService("Workspace")["_FinishChute"].Entrance.CFrame + Vector3.new(-10, 5, 0))
  wait(0.5)
  tpcfr(e.Base.CFrame + Vector3.new(0, 5, 0))
end)
