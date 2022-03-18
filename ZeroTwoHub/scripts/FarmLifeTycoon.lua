library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

function touch(part)
  if(type(part) == "table") then
    for i,v in pairs(part) do
      touch(v)
      game:GetService("RunService").RenderStepped:Wait()
    end
  else
    if(part:IsA("BasePart")) then
      if(part.Transparency ~= 1 and part:FindFirstChildOfClass("TouchTransmitter")) then
        firetouchinterest(part,lp.Character.HumanoidRootPart,0)
        game:GetService("RunService").Stepped:Wait()
        firetouchinterest(part,lp.Character.HumanoidRootPart,1)
      end
    end
    if(part:IsA("Folder") or part:IsA("Model")) then
      touch(part:GetChildren())
    end
  end
  return true
end


local Tycoon = lp.TycoonPointer.Value
main:Toggle2("auto buy",function()
  for i,v in pairs(Tycoon.Buttons:GetChildren()) do
    if(not v.Configuration:FindFirstChild("DevProductID") and lp.leaderstats.Money.Value >= v.Configuration.Cost.Value) then
      touch(v)
      wait(2)
    end
  end
  wait(1)
end)

main:Toggle2("Auto Collect plants",function()
for i,v in pairs(Tycoon.Entities:GetChildren()) do
  if(v:FindFirstChild("Plant") and v.Plant:FindFirstChild("ProximityPrompt") and v.Configuration.CurrentStage.Value == v.Configuration.NumGrowthStages.Value) then
    lp.Character.HumanoidRootPart.CFrame = v.Plant.CFrame
    wait(0.1)
    fireproximityprompt(v.Plant.ProximityPrompt,0)
    wait(0.1)
  end
  if(v:FindFirstChild("ProximityPrompt") and v.Configuration.CurrentStage.Value == v.Configuration.NumGrowthStages.Value) then
    lp.Character.HumanoidRootPart.CFrame = v:FindFirstChildWhichIsA("BasePart").CFrame
    wait(0.1)
    fireproximityprompt(v.ProximityPrompt,0)
    wait(0.1)
  end
end
end)

main:Toggle2("Auto Collect Cash",function()
  lp.Character.HumanoidRootPart.CFrame = Tycoon.Entities.MoneyCollector.Trigger.CFrame
  touch(Tycoon.Entities.MoneyCollector.Trigger)
  wait(4)
end)
