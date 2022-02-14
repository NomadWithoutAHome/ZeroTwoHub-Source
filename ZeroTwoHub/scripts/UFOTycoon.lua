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
local tycoon
for i,v in ipairs(game:GetService("Workspace").Tycoons:GetChildren()) do
  if(v.OwnerPointer.Value == lp) then
    tycoon = v
  end
end
function tp(part)
  if(type(part) == "table") then
    for i,v in pairs(part) do
      tp(v)
    end
  else
    lp.Character.HumanoidRootPart.CFrame = part
    wait(0.5)
  end
end
main:Toggle2("Gem Collector",function()
  for i,v in ipairs(game:GetService("Workspace").GlobalEntities:GetChildren()) do
    touch(v.Trigger)
  end
end)
main:Toggle2("Auto Collect Money",function()
  touch(tycoon.Entities.MoneyCollector.Trigger)
end)

function checkcollect(v)
  for j,k in pairs(v:GetDescendants()) do
    if(k:IsA("TextLabel") and k.Text == "Collect") then
      return true
    end
  end
  return false
end

main:Toggle2("TP Collect Plants",function()
  for i,v in ipairs(tycoon.Entities:GetChildren()) do
    if(string.find(v.Name:lower(),"plant")) then
      if(checkcollect(v)) then
        if(v:FindFirstChildOfClass("Model") and v:FindFirstChildOfClass("Model"):FindFirstChild("ProximityPrompt")) then
          tp(v:FindFirstChildOfClass("Model").MeshPart.CFrame + Vector3.new(0,5,0))
          repeat
            fireproximityprompt(v:FindFirstChildOfClass("Model").ProximityPrompt, 10)
            wait()
          until not checkcollect(v)
        end
        if(v:FindFirstChildOfClass("MeshPart") and v:FindFirstChildOfClass("MeshPart"):FindFirstChild("ProximityPrompt")) then
          tp(v:FindFirstChildOfClass("MeshPart").CFrame + Vector3.new(0,5,0))
          repeat
            fireproximityprompt(v:FindFirstChildOfClass("MeshPart").ProximityPrompt, 10)
            wait()
          until not checkcollect(v)
        end
        if(v:FindFirstChild("ProximityPrompt")) then
          tp(v:FindFirstChildOfClass("Model").MeshPart.CFrame + Vector3.new(0,5,0))
          repeat
            fireproximityprompt(v.ProximityPrompt, 10)
            wait()
          until not checkcollect(v)

        end
      end
    end
  end
end)

main:Toggle2("Auto Buy",function()
  for i,v in pairs(tycoon.Buttons:GetChildren()) do
    if(not v.Configuration:FindFirstChild("DevProductID") and lp.leaderstats.Money.Value >= v.Configuration.Cost.Value) then
      touch(v.Trigger)
    end
  end
end)

main:Box("Walkspeed","int",function(value)
  lp.Character.Humanoid.WalkSpeed = value
end)

main:Button("Get a Jelp Burger",function()
  local cfr = lp.Character.HumanoidRootPart.CFrame
  tp(game:GetService("Workspace")["Jelp's Burgers"].Jelp.HumanoidRootPart.CFrame)
  wait(0.5)
  fireproximityprompt(game:GetService("Workspace")["Jelp's Burgers"].Jelp.HumanoidRootPart.ProximityPrompt,10)
  wait(0.5)
  tp(cfr)
end)
