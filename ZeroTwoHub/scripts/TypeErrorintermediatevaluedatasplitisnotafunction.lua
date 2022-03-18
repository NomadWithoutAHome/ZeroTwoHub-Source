library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
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
    if(part:IsA("BasePart")) then
      part = part.CFrame
    end
    lp.Character.HumanoidRootPart.CFrame = part
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

function getGui(base)
  for i,v in pairs(lp.PlayerGui.WorkspaceGui:GetChildren()) do
    if(not v:IsA("ScreenGui")) then
      if(v.Adornee == base) then
        return v
      end
    end
  end
end

if(game.PlaceId == 3475397644) then
  local plot = workspace.Interactions.Plots.Plots[lp.Name.."_Plot"]
  main:Toggle2("Auto Farm crops",function()
    for i,v in pairs(plot.Base.Buildings:GetChildren()) do
      if(v:FindFirstChild("HarvestRemote") and v:FindFirstChild("Base")) then
        if(getGui(v.Base).TimeLabel.Text == "Ready to harvest!") then
          v.HarvestRemote:InvokeServer()
        end
      end
    end
  end)
end

main:Toggle2("Hold Dragon Fire",function()
  lp.Character.Dragons:FindFirstChild("1").Remotes.BreathFireRemote:FireServer(true)
  wait(1)
end)
local top,topdis
main:Toggle2("Auto Farm Mobs",function(self)
  top,topdis = nil,150
  for i,v in ipairs(game:GetService("Workspace").Camera.ClientMobs:GetChildren()) do
    if(v:FindFirstChild("HumanoidRootPart") and mag(v.HumanoidRootPart) < topdis) then
      top = v
      topdis = mag(v.HumanoidRootPart)
    end
  end
  if(top) then
    --game:GetService("Workspace").Camera.ClientMobs.Fox
    mesh = nil
    for i,v in pairs(top:GetChildren()) do
      if(string.find(v.Name,"Meshes/Cube")) then
        mesh = v
      end
    end
    assert(mesh~=nil,"how is mesh nil")
    while
    mesh.Transparency == 0
    and self:IsOn() do
      lp.Character.Dragons:FindFirstChildOfClass("Model").PrimaryPart.CFrame = top.HumanoidRootPart.CFrame * CFrame.new(0,0,40)
      pos = workspace.CurrentCamera:WorldToScreenPoint(top.HumanoidRootPart.Position)
      mousemoveabs(pos.X,pos.Y)
      -- rconsoleclear()
      -- rconsoleprint("moving mouse to the dude")
      wait()
    end
  end
end)

local food = "Apple"
main:Box("Food","string",function(value)
  food = value
end)

main:Toggle2("Auto Feed Dragons",function()
  maxamount = string.split(lp.PlayerGui.MyDragonsGui.ContainerFrame.LimitLabel.Text,"/")[1]
  for i=1,maxamount do
    local args = {
        [1] = i,
        [2] = {
            ["Amount"] = 10000, --Max uses the needed amount
            ["ItemName"] = food
        }
    }
    game:GetService("ReplicatedStorage").Remotes.FeedDragonRemote:InvokeServer(unpack(args))
  end
  wait(5)
end)

main:Toggle2("Pickup Drops",function()
  for i,v in ipairs(game:GetService("Workspace").Camera:GetChildren()) do
    if(v:IsA("Model")) then
      touch(v.Handle)
    end
  end
end)

main:Toggle2("Auto Farm food bushes",function(self)

-- [[ \ >.< / ]] --

  local top,topdis = nil,75
  for i,v in ipairs(game:GetService("Workspace").Interactions.Nodes.Harvest.Food.ActiveNodes:GetChildren()) do
    if(v:FindFirstChildOfClass("MeshPart")) then
      lp.Character.HumanoidRootPart.CFrame = v:FindFirstChildOfClass("MeshPart").CFrame * CFrame.new(0,0,5)
      wait(1)
      v.StateRemote:InvokeServer(true)
      wait(1)
      i=-1
      while(v:FindFirstChildOfClass("MeshPart") and self:IsOn()) do
        i = (i+1)%5
        v.BoostRemote:InvokeServer(true,"Food"..i)
        wait(2)
      end
      break
    end
  end
end)
