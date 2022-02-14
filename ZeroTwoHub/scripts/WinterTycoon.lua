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
        firetouchinterest(part,lp.Character.UpperTorso,0)
        game:GetService("RunService").Stepped:Wait()
        firetouchinterest(part,lp.Character.UpperTorso,1)
      end
    end
    if(part:IsA("Folder") or part:IsA("Model")) then
      touch(part:GetChildren())
    end
  end
  return true
end
repeat
for i,v in ipairs(game:GetService("Workspace").Tycoons:GetChildren()) do
    if v.Owner.Value == lp.Name then
        tycoon = v
    end
end
wait()
until tycoon ~= nil
main:Toggle2("Auto Click",function()
    fireclickdetector(tycoon.Buyable.ClickDropper.Clicker.ClickDetector)
end)

main:Toggle2("Auto Click all",function()
    for i,v in ipairs(game:GetService("Workspace").Tycoons:GetChildren()) do
        fireclickdetector(v.Buyable.ClickDropper.Clicker.ClickDetector)
    end
end)

main:Toggle2("Auto Collect",function()
    touch(tycoon["Money_Collector"].Extras.Collect)
end)

main:Toggle2("Auto Collect all",function()
    for i,v in ipairs(game:GetService("Workspace").Tycoons:GetChildren()) do
        touch(v["Money_Collector"].Extras.Collect)
    end
end)
