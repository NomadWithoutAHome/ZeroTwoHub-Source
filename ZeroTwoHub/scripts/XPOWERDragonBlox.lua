if(_G.hub == nil or _G.hub == false) then return error("not loaded via hub") end

local library = loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer
local mob

local pausetraining = false
function attack()
  if(pausetraining) then
    return
  end

  args = {
      [1] = "Combat",
      [2] = true,
      [3] = workspace.CurrentCamera.CFrame, --CurrentCamera
      [4] = lp.Character.HumanoidRootPart.CFrame, --PrimaryPart
      [5] = workspace:FindFirstChild("World Map")["World Areas"]:FindFirstChild("Spawn Island").Pathway.Part.CFrame, --GetTargetPos
      [7] = workspace:FindFirstChild("World Map")["World Areas"]:FindFirstChild("Spawn Island").Pathway.Part, --mouse.target aka Target
      [8] = {
          ["Type"] = 0,
      }
  }
  game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))
  args[2]=false
  args[8]["Hit"]={}
  args[8]["Type"]=2
  game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))
end

main:Toggle2("Auto Hit",function()
  attack()
end)

main:Toggle2("Auto Farm",function()
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.StatsService.RebirthUp:FireServer()
    attack()
end)

function tonum(str)
  mult = string.find(str,"K") and 1000 or string.find(str,"M") and 1000000 or string.find(str,"B") and 1000000000 or 1
  str = string.gsub(str,"K","")
  str = string.gsub(str,"M","")
  str = string.gsub(str,"B","")
  return tonumber(str)*mult
end

-- auto rebirth
local ready
local sacredpowerreq = tonum("35M")
local sacredrebirthreq = 30
local destroyerreq = 80
local lastname
main:Toggle2("Auto Farm Places",function()
  name = ""
  if lp.Stats.Power.Value > sacredpowerreq and lp.Stats.Rebirth.Value > sacredrebirthreq and lp.Stats.Power.Value < destroyerreq then
    tped = false
    name = "1"
  end
  if lp.Stats.Rebirth.Value > destroyerreq then
    tped = false
    name = "2"
  end
  if(not tped and name) then
    if(name ~= lastname) then
      lastname = name
      if(name == "1") then
        lp.Character.Humanoid.HumanoidRootPart.CFrame = game:GetService("Workspace")["World Map"]["Multiplier Zone"]["Sacred Island"].Island["Sacred Land"].Model["Meshes/SacredLake_Circle.005"].CFrame
      end
      if(name == "2") then
        lp.Character.Humanoid.HumanoidRootPart.CFrame = game:GetService("Workspace")["World Map"]["Multiplier Zone"]["Destroyer's Island"]["Destroyer's Planet"].Land["Meshes/Beerus Land_Plane.004"].CFrame
      end
      tped = true
      wait(10)
    end
  end
end)

local lastform
main:Toggle2("Auto Form",function()
  local nextform = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Frame.QuickTransform.Info.TextLabel.Text
  nextform = string.split(nextform,'Next Transformation: [')[2]
  nextform = string.split(nextform,']')[1]
  if(nextform ~= lastform) then
    lastform = nextform
    pausetraining = true
    spawn(function()
      wait(5)
      pausetraining = false
    end)
    wait(1)
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.Props.ModeTransformService.Transformation:FireServer("Off")
    wait(3)
    form = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Frame.QuickTransform.Info.TextLabel.Text
    form = string.split(form,"'")[2]
    form = string.split(form,"'")[1]
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.Props.ModeTransformService.Transformation:FireServer(form)
  end
end)

main:Toggle2("Auto Technique",function()
  local args = {
      [1] = "Technique",
      [2] = true,
      [3] = workspace.CurrentCamera.CFrame, --CurrentCamera
      [4] = lp.Character.HumanoidRootPart.CFrame, --PrimaryPart
      [5] = workspace:FindFirstChild("World Map")["World Areas"]:FindFirstChild("Spawn Island").Pathway.Part.CFrame, --GetTargetPos
      [7] = workspace:FindFirstChild("World Map")["World Areas"]:FindFirstChild("Spawn Island").Pathway.Part, --mouse.target aka Target
  }
  game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))
  wait(5)
end)

main:Toggle2("Auto Mob Farm",function()
  local top,dif,topdif = nil,0,0
  for i,v in pairs(game:GetService("Workspace")["World Mobs"]:GetChildren()) do
    for i2,v2 in pairs(v:GetChildren()) do
      if(v2.Name == mob or mob == "Target Min HP Mob") then
        dif = v2.Humanoid.Health
        if(dif < topdif or topdif == 0) then
          top = v2
          topdif = dif
        end
      elseif(mob == "Target Most DMG Mob") then
        dif = v2.Status.Damage.Value
        if(dif > topdif or topdif == 0) then
          top = v2
          topdif = dif
        end
      end
    end
  end
  if(top) then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = top.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
    args = {
        [1] = "Combat",
        [2] = true,
        [3] = workspace.CurrentCamera.CFrame, --CurrentCamera
        [4] = lp.Character.HumanoidRootPart.CFrame, --PrimaryPart
        [5] = workspace:FindFirstChild("World Map")["World Areas"]:FindFirstChild("Spawn Island").Pathway.Part.CFrame, --GetTargetPos
        [7] = workspace:FindFirstChild("World Map")["World Areas"]:FindFirstChild("Spawn Island").Pathway.Part, --mouse.target aka Target
        [8] = {
            ["Type"] = 0,
        }
    }
    game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))
    args[2]=false
    args[8]["Hit"]={top}
    args[8]["Type"]=2
    game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))
  end
end)

local mobs = {}

local tempmobs = {}
for i,v in pairs(game:GetService("Workspace")["World Mobs"]:GetChildren()) do
  for i2,v2 in pairs(v:GetChildren()) do
    tempmobs[v2.Name]=true
  end
end
for i,v in pairs(tempmobs) do
  mobs[#mobs+1]=i
end
mobs[#mobs+1]="Target Min HP Mob"
mobs[#mobs+1]="Target Most DMG Mob"
main:Dropdown("Mobs", mobs,true,function(val)
  mob = val
end)

main:Toggle2("Pickup Dropped Items",function()
  for i,v in pairs(game:GetService("Workspace").PartStorage:GetChildren()) do
    if(v.Name ~= "Visual" and v:FindFirstChild("Base")) then
      fireproximityprompt(v.Base.Attachment.ProximityPrompt,0)
    end
  end
end)

main:Toggle2("Delete Duplicate Items",function()
local items = {}
for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Frame.Windows.Inventory.Sidebar.Frame.Frame.Body.TabContainer.Inventory.InventoryScrollingFrame:GetChildren()) do
  if(v.Name ~= "UIGridLayout" and v.ViewportFrame:FindFirstChildOfClass("Model")) then
    if(items[v.ViewportFrame:FindFirstChildOfClass("Model").Name] == true)then
      local args = {
          [1] = tonumber(v.Name),
          [2] = v.ViewportFrame:FindFirstChildOfClass("Model").Name
      }
      game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.InventoryService.RemoveItemRequest:FireServer(unpack(args))
    else
      items[v.ViewportFrame:FindFirstChildOfClass("Model").Name] = true
    end
  end
end
end)

main:Button("TP to Potential Unleasher",function()
  if(game:GetService("Workspace").Misc.NPC:FindFirstChild("TechniquePotentialUnleashedGiver")) then
    lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Misc.NPC.TechniquePotentialUnleashedGiver.HumanoidRootPart.CFrame
  else
    error("Not spawned")
  end
end)
--ah I see
