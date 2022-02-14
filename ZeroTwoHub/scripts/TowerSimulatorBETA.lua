local lp = game.Players.LocalPlayer

local library = loadstring(game:HttpGet("http://zerotwohub.tk/getFile?Filename=uilibtest.lua"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

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


local Tower;
for i,v in pairs(game.Workspace:GetChildren()) do
  if(v:FindFirstChild("Owner")) then
    if(v.Owner.Value == lp) then
      Tower = v
      break;
    end
  end
end

main:Toggle2("Click",function()
  for i=1,getgenv().clickspeed or 1 do
    fireclickdetector(Tower.ClickDetector)
  end
end)

main:Box("Click Speed","int",function(val)
  getgenv().clickspeed = val
end)


main:Toggle2("Auto Collect",function()
  for i,v in pairs(game.Workspace:GetChildren()) do
    if(v:FindFirstChild("Hitbox")) then
      lp.Character.TouchTheSky.RemoteEvent:FireServer(v.Hitbox)
    end
    if(v:FindFirstChild("ClickDetector")) then
      fireclickdetector(v.ClickDetector)
      wait()
    end
    if(v.Name == "seagolls") then
      for i2,v2 in pairs(v:GetChildren()) do
        if(v2:FindFirstChild("ClickDetector")) then
          fireclickdetector(v2.ClickDetector)
          wait()
        end
      end
    end
  end
end)

main:Toggle2("Auto Upgrade",function()
  touch(Tower.PurchaseUpgradeButtonRight.Head)
  touch(Tower.PurchaseUpgradeButtonLeft.Head)
end)
