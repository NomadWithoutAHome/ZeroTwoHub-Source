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

  end
end

main:Toggle2("Auto Checkpoint",function(self)
  checkpoints = game:GetService("Workspace").Checkpoints
  curstage = lp.leaderstats.Stage.Value
  if(checkpoints:FindFirstChild(curstage+1)) then
    repeat
      tp(checkpoints:FindFirstChild(curstage+1))
      wait(0.1)
      touch(checkpoints:FindFirstChild(curstage+1))
    until curstage ~= lp.leaderstats.Stage.Value or not self:IsOn()
  else
    wait(1)
    if(self:IsOn()) then
      game:GetService("ReplicatedStorage").Remotes.Prestige:FireServer()
    end
  end
end)
