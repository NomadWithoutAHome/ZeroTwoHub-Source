if(_G.hub == nil or _G.hub == false) then return false end

library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest.lua"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

function mag(part)
  if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and part:IsA("BasePart")) then
    return (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
  else
    return 0
  end
end

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


main:Toggle2("farm rings",function()
  touch(game:GetService("Workspace").Rings)
end)

main:Toggle2("Auto Collect Orbs",function(self)
  for i,v in ipairs(game:GetService("Workspace").ballsFolder:GetChildren()) do
    mdis = 9e9
    top = nil
    for j,k in pairs(v:GetChildren()) do
      if(k:FindFirstChild("Outer")) then
        if(mag(k.Outer) < mdis) then
          mdis = mag(k.Outer)
          top = k
        end
        if(mag(k.Outer) < 20) then
          touch(k.Outer)
        end
      end
    end
    if(top) then
      lp.Character.HumanoidRootPart.CFrame = top.Outer.CFrame
    end
  end
end)

main:Toggle2("Auto Rebirth",function()
  game:GetService("ReplicatedStorage").Networking.Rebirth:FireServer()
  wait(1)
end)
