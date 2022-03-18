if(_G.hub == nil or _G.hub == false) then return false end

local library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest.lua"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

function tonum(str)
  str = string.split(str,"+")[1]
  mult = string.find(str,"K") and 1000 or string.find(str,"M") and 1000000 or string.find(str,"B") and 1000000000 or string.find(str,"B") and 1000000000000 or 1
  str = string.gsub(str,"K","")
  str = string.gsub(str,"M","")
  str = string.gsub(str,"B","")
  str = string.gsub(str,"T","")

  return tonumber(str)*mult
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

function mag(part)
  if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and part:IsA("BasePart")) then
    return (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
  else
    return 0
  end
end

local tycoon = lp.Team.Name --here
if(tycoon == "For Hire") then
  wait(2)
  repeat
    for i,v in ipairs(game:GetService("Workspace").Tycoon.Tycoons:GetChildren()) do
      if(v.Entrance:FindFirstChild("Touch to claim ownership!")) then
        touch(v.Entrance["Touch to claim ownership!"].Head)
      end
    end
    tycoon = lp.Team.Name
    wait()
  until tycoon ~= "For Hire"
end

local ac = main:Toggle2("Auto Collect",function()
  touch(game:GetService("Workspace").Tycoon.Tycoons[tycoon].Essentials.Giver)
end)



local ab = main:Toggle2("Auto Buy",function(ab)
    for i,v in ipairs(game:GetService("Workspace").Tycoon.Tycoons[tycoon].Buttons:GetChildren()) do
      if(v.Head.Transparency == 0 and ab:IsOn() and not v:FindFirstChild("Gamepass")) then
        if(tonum(lp.leaderstats.Cash.Value) >= v.Price.Value) then
          touch(v.Head)
        end
      end
    end
end)

local cmc = main:Toggle2("Collect Money Crates",function()
    for i,v in ipairs(game:GetService("Workspace"):GetChildren()) do
        if(v.Name == "C1") then
            touch(v.Part)
        end
    end
end)

main:Toggle2("Collect Weapon Crates",function()
    for i,v in ipairs(game:GetService("Workspace"):GetChildren()) do
        if(v.Name == "C2") then
            touch(v.Part)
        end
    end
end)

local im = main:Toggle2("Infinite Money",function()
  local args = {
      [1] = 100000,
      [2] = "CrateMoney"
  }
  for i=1,10 do
    game:GetService("ReplicatedStorage").Give_Quest_Money:FireServer(unpack(args))
  end
end)

local ar = main:Toggle2("Auto Rebirth",function()
  --fireclickdetector(game:GetService("Workspace").Tycoon.Tycoons[tycoon].Essentials.Deleter.ClickDetector)
  for i=1,5 do
    game:GetService("ReplicatedStorage").Events.Rebirth.RebirthClient:FireServer()
  end
end)

if(autofarm) then
  ar:Activate()
  im:Activate()
  ab:Activate()
  ac:Activate()
  cmc:Activate()
end
