library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/getFile?Filename=uilibtest.lua"))()
local w = library:CreateWindow("ZeroTwoHub")
local main = w:CreateFolder("Main")
local lp = game.Players.LocalPlayer

function mag(part)
  if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and part:IsA("BasePart")) then
    return (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
  else
    return 0
  end
end

local multies = {
  K = 1000,
  M = 1000000,
  B = 1000000000
}

function convert(str)
  local mult = 1
  for i,v in pairs(multies) do
    if(string.find(str,i)) then
      mult = mult * v
      str = tostring(string.gsub(str,i,""))
    end
  end
  return mult * tonumber(str)
end

main:Toggle2("AutoFarm",function()
top,topd,d = nil,0,0
for i,v in pairs(game:GetService("Workspace")["__THINGS"].Items:GetChildren()) do
  d = mag(v.Model.Root)
  if(d < topd or topd == 0) then
    top = v
    topd = d
  end
end
lp.Character.HumanoidRootPart.CFrame = top.Model.Root.CFrame * CFrame.new(0,0,top.Model.Root.Size.Z)
repeat
  fireclickdetector(top.Model.ClickDetector)
  wait()
until not top.Parent or not top or not top:FindFirstChild("Model") or not top.Model:FindFirstChild("Root") or not top.Model.Root:FindFirstChild("ItemUI") or top.Model.Root.ItemUI.Frame.Health.Text == 0 or _G.AutoFarm == false
if(5*convert(lp.leaderstats.Strength.Value) <= convert(lp.leaderstats.Rage.Value)) then
  lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__THINGS"].PunchingBags.City["2"].Prompt.CFrame
  wait()
  repeat
    wait()
    fireproximityprompt(game:GetService("Workspace")["__THINGS"].PunchingBags.City["2"].Prompt.ProximityPrompt)
  until convert(lp.leaderstats.Rage.Value) <= 5*convert(lp.leaderstats.Strength.Value)
end
end)
