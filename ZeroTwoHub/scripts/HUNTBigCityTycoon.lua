if(_G.hub == nil or _G.hub == false) then return false end

local library = loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest.lua"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

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

main:Toggle2("Auto Parkour",function(self)
    for i,v in ipairs(game:GetService("Workspace").Camera:GetChildren()) do
        if(self:IsOn()) then
            if(v:IsA("Model")) then
                tp(v.Primary)
                wait(5)
            end
        else
            break
        end
    end
end)
