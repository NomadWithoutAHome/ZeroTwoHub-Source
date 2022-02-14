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

touch(game:GetService("Workspace").BadgeAwarder.Platform)

for i,v in ipairs(game:GetService("Workspace")["Zednov's Tycoon Kit"].Tycoons:GetChildren()) do
    if v.Owner.Value == lp then
        tycoon = v
    end
end

main:Toggle2("Auto Claim money",function()
    touch(tycoon.Essentials.Giver)
end)

main:Toggle2("Auto Buy",function()
  for i,v in ipairs(tycoon.Buttons:GetChildren()) do
    touch(v.Head)
  end
end)
