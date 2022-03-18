if(_G.hub == nil or _G.hub == false) then return false end

library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest.lua"))()
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

function tp(part)
  if(type(part) == "table") then
    for i,v in pairs(part) do
      tp(v)
    end
  else
    if(part:IsA("BasePart")) then
      part = part.CFrame
    end
    lp.Character.HumanoidRootPart.CFrame = part
    wait(0.5)
  end
end

main:Button("Remove all KillBricks",function() --game:GetService("Workspace").Model.Kill
  for i,v in ipairs(game:GetService("Workspace"):GetChildren()) do
    if(v:FindFirstChild("Kill")) then
      v:Destroy()
    end
  end
end)

main:Toggle2("Rebirth",function()
  lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Checkpoints["91"].CFrame
  game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.PlayerData.Rebirth:InvokeServer()
end)

main:Toggle2("Honk Honk",function()
  game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.VehicleSpawner.Honk:InvokeServer()
  wait(0.5)
end)
