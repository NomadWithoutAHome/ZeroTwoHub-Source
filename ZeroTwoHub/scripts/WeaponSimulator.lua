repeat wait()until game
repeat wait()until game.Players
repeat wait()until game.Players.LocalPlayer
local a=loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local b=a:CreateWindow("ZeroTwo Hub")
local c=b:CreateFolder("Main")
local christmas = b:CreateFolder("Christmas")


local lp = game.Players.LocalPlayer
lp.CameraMaxZoomDistance = 170
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
function mag(part)
  if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and part:IsA("BasePart")) then
    return (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
  else
    return 0
  end
end

local godmode = false

c:Toggle("Instant Heal (nearly godmode)",function(d)godmode=d end)
c:Toggle2("Grind Power",function()
    e=lp
    local f=e.Character
    local g= f:FindFirstChild("sword") or e.Backpack:FindFirstChild("sword")
    if(g and g:FindFirstChild("Handle"))then
-- game:GetService("Players").LocalPlayer.Character.sword.Handle.pr.RemoteEvent:FireServer()
      if(g.Handle:FindFirstChild("up"))then
        if(g.Handle.up:FindFirstChild("RemoteEvent"))then
          local h=g.Handle.up.RemoteEvent
          for i=1,_G.count or 8 do
            h:FireServer()
          end
        end
      end
      if(g.Handle:FindFirstChild("pr"))then
        if(g.Handle.pr:FindFirstChild("RemoteEvent"))then
          local h=g.Handle.pr.RemoteEvent
          for i=1,_G.count do
            h:FireServer()
          end
        end
      end
    end
end)
c:Toggle2("Attack",function()
    e=lp
    local f=e.Character
    local g= f:FindFirstChild("sword") or f:FindFirstChildOfClass("Tool") or e.Backpack:FindFirstChild("sword") or e.Backpack:FindFirstChildOfClass("Tool")
    f:FindFirstChildOfClass("Humanoid"):EquipTool(g)
    if(g and g:FindFirstChild("Handle"))then
      g:Activate()
      if(g.Handle:FindFirstChild("up"))then
        if(g.Handle.up:FindFirstChild("RemoteEvent"))then
          g.Handle.up.RemoteEvent:FireServer()
        end
      end
      if(g.Handle:FindFirstChild("pr"))then
        if(g.Handle.pr:FindFirstChild("RemoteEvent"))then
          g.Handle.pr.RemoteEvent:FireServer()
        end
      end
    end
end)
c:Box("Power Thingy","int",function(d)
  _G.count=d or 8
end)
c:Box("Speed","Number",function(d)
  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=d or 16
end)
c:Box("JumpPower","Number",function(d)
  game.Players.LocalPlayer.Character.Humanoid.JumpPower=d or 52
end)
c:Button("Kill ALL you can kill(not yet:tm:)",function()
  print("never :tm:")
end)

christmas:Toggle2("Auto collect candy",function()
  for i,v in pairs(game.workspace:GetChildren()) do
    --game:GetService("Workspace").fakeCandyCane
    if(v.Name == "fakeCandyCane") then
      touch(v)
    end
  end
end)
christmas:Toggle2("Auto Upgrade Christmas sword",function()
workspace.__EVENTS.upgrading:InvokeServer()
end)
christmas:Dropdown("AutoFarm Mode",{"Min","Max"},true,function(val)
_G.am = val
end)
christmas:Toggle2("Auto Farm Candy",function()
  minhealth = 0
  top = nil
  for i,v in pairs(game:GetService("Workspace").CandyCanes:GetChildren()) do
    if(not(v:FindFirstChild("Title") == nil or v.Title:FindFirstChild("TextLabel") == nil)) then
      health = tonumber(string.split(v.Title.TextLabel.Text,"Damage:")[2])
      --game:GetService("Workspace").CandyCanes.SmallCandyCane.Title.TextLabel
      if(_G.am == "Max") then
        if(health > minhealth or minhealth == 0) then
          top = v
          minhealth = health or minhealth
        end
      else
        if(health < minhealth or minhealth == 0) then
          top = v
          minhealth = health or minhealth
        end
      end
    end
  end
  top.CanCollide = false
  lp.Character.HumanoidRootPart.CFrame = top.CFrame*CFrame.new(0,lp.Character.HumanoidRootPart.Position.Y - top.Position.Y,top.Size.Z*0.5)
  e=lp
  local f=e.Character
  local g= f:FindFirstChild("ChristmasTreeSword") or e.Backpack:FindFirstChild("ChristmasTreeSword")
  f:FindFirstChildOfClass("Humanoid"):EquipTool(g)
  repeat
    g:Activate()
    wait()
  until v== nil or v.Parent == nil or v:FindFirstChild("Title") == nil or v.Title:FindFirstChild("TextLabel") == nil or tonumber(v.Title.TextLabel.Text.split("Damage:")[2]) <= 0
  repeat
    ds = false
    for i,v in pairs(game.workspace:GetChildren()) do
      --game:GetService("Workspace").fakeCandyCane
      if(v.Name == "fakeCandyCane" and mag(v) < 50) then
        touch(v)
        ds = true
      end
    end
    wait()
  until not ds
end)

c:Button("Safe Spot",function()
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(342.457, 3.12002, 168.456)
end)

if(godmodecon)then
  godmodecon:Disconnect()
end
godmodecon=game:GetService("RunService").RenderStepped:Connect(function()
  if(godmode)then
    workspace.__EVENTS.Heal:FireServer()
  end
end)
