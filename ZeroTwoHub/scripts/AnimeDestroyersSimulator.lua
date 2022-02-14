
library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/getFile?Filename=uilibtest.lua"))()
local w = library:CreateWindow("ZeroTwoHub")
local main = w:CreateFolder("Main")
local settings = w:CreateFolder("Settings")
local lp = game.Players.LocalPlayer

function mag(part)
  if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and part:IsA("BasePart")) then
    return (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
  else
    return 0
  end
end
_G.FarmArea = _G.FarmArea or workspace.Buildings:FindFirstChild("One Blox Docks")
main:Toggle2("AutoFarm",function()
  top,topd,d = nil,0,0
  for i,v in pairs(_G.FarmArea:GetChildren()) do
    anchored = false
    for i2,v2 in pairs(v:GetDescendants()) do
      if(v2:IsA("BasePart") and v2.Name ~= "Hitbox") then
        if(v2.Anchored) then
          anchored = true
        end
      end
    end
    if(anchored) then
      d = mag(v.Hitbox)
      if(_G.FarmMode == "Nearest") then
        if(d < topd or topd == 0) then
          top = v
          topd = d
        end
      end
      if(_G.FarmMode == "Furthest") then
        if(d > topd or topd == 0) then
          top = v
          topd = d
        end
      end
      d = v.MaxHealth.Value
      if(_G.FarmMode == "MaxHP") then
        if(d > topd or topd == 0) then
          top = v
          topd = d
        end
      end
      if(_G.FarmMode == "MinHP") then
        if(d < topd or topd == 0) then
          top = v
          topd = d
        end
      end
    end
  end
  if(top == nil)then return end
  lp.Character.HumanoidRootPart.CFrame = top.Hitbox.CFrame + Vector3.new(top.Hitbox.Size.Y)
  local args = {
      [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"),
      [2] = {
          [1] = {
              [1] = top,
              [2] = top.Hitbox.Position
          }
      }
  }
  lasthealth = 0
  anchored = false
  repeat
    lasthealth = top.Health.Value
    for i=1,10 do
      spawn(function()
        game:GetService("ReplicatedStorage").Remotes.UseSword:InvokeServer(unpack(args))
      end)
    end --lol
    wait()
    anchored = false
    for i,v in pairs(top:GetDescendants()) do
      if(v:IsA("BasePart") and v.Name ~= "Hitbox") then
        if(v.Anchored) then
          anchored = true
        end
      end
    end
    print(top,top.Parent,top:FindFirstChild("Hitbox"),top.Broken.Value,top.Health.Value,top:FindFirstChild("Part"),top.Health.Value,lasthealth,anchored)
  until not top or not top.Parent or not top:FindFirstChild("Hitbox") or top.Broken.Value or top.Health.Value <= 0 or not top:FindFirstChild("Part") or top.Health.Value == lasthealth or anchored == false
  for i,v in pairs(game:GetService("Workspace").Coins:GetChildren()) do
    v.CFrame = lp.Character.HumanoidRootPart.CFrame
  end
end)

main:Toggle2("Upgrade Sword",function()
  game:GetService("ReplicatedStorage").Remotes.Upgrade:InvokeServer("Melee")
  game:GetService("ReplicatedStorage").Remotes.Upgrade:InvokeServer("Cooldown")
end)

settings:Dropdown("AutoFarm Mode",{"Nearest","MaxHP","Furthest","MinHP"},true,function(val)
  _G.FarmMode = val
end)

settings:Text("")

settings:Dropdown("AutoFarm Area",workspace.Buildings:GetChildren(),true,function(val)
  _G.FarmArea = val
end)
