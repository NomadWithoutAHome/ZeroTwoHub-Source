if(_G.hub == nil or _G.hub == false) then return false end

local library = loadstring(game:HttpGet("http://zerotwohub.tk/getFile?Filename=uilibtest.lua"))()
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
      lp.Character.HumanoidRootPart.CFrame = part.CFrame
      wait(0.5)
    end
  end

local tycoon = game.Players.LocalPlayer.Team.Name

main:Toggle2("Auto Collect Money",function()
  touch(game:GetService("Workspace")["Twin's Tycoon Kit 3.0"].Tycoons[tycoon].Essentials.Giver)
end)

main:Toggle2("Auto Buy",function(self)
  for i,v in ipairs(game:GetService("Workspace")["Twin's Tycoon Kit 3.0"].Tycoons[tycoon].Buttons:GetChildren()) do
    if(v.Head.Transparency == 0 and self:IsOn() and not v:FindFirstChild("Gamepass")) then
      touch(v.Head)
    end
  end
end)

main:Toggle2("Gain Money",function()
    for i,v in ipairs(game:GetService("Workspace"):GetChildren()) do
        if(v.Name == "Model" and v:FindFirstChild("Winners") and not lp:FindFirstChildOfClass("ForceField")) then
            tp(v.Winners)
            wait(1)
            if(lp.Character:FindFirstChild("Head")) then
                lp.Character.Head:Destroy()
            end
            break
        end
    end
end)