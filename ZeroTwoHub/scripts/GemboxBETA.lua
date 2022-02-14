local library = loadstring(game:HttpGet("http://zerotwohub.tk/getFile?Filename=uilibtest.lua"))()
local window = library:CreateWindow("ZeroTwo Hub")
local farm = window:CreateFolder("AutoFarm")

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


lp = game.Players.LocalPlayer
function ModelTween(pos,yield)
  local CF = CFrame.new(pos)
  local model = game.Players.LocalPlayer.Character
  local tweenService = game:GetService("TweenService")
	local diff = (model.PrimaryPart.Position - pos).magnitude
	local speed = (diff / (lp.PlayerData.Speed.Value+10))
	local info = TweenInfo.new(speed,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0)

	local function tweenModel(model, CF)
	    CFrameValue = Instance.new("CFrameValue")
	    CFrameValue.Value = model:GetPrimaryPartCFrame()
      _G.CFrameValue = CFrameValue
	    CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
        if(model.PrimaryPart) then
	        model:SetPrimaryPartCFrame(CFrameValue.Value)
        else
          CFrameValue:Destroy()
        end
	    end)

	    local tween = tweenService:Create(CFrameValue, info, {Value = CF})
	    tween:Play()

	    tween.Completed:Connect(function()
	        CFrameValue:Destroy()
	    end)
      repeat
        game:GetService("RunService").Stepped:Wait()
      until CFrameValue == nil or CFrameValue.Parent == nil or yield == false
	end
	tweenModel(model,CF)
end

function moveto(zombie,destination)

  lp.PlayerScripts.SpeedChecker.Disabled = true
  zombie:FindFirstChildOfClass("Humanoid").WalkSpeed = lp.PlayerData.Speed.Value + 10

  zombie:FindFirstChildOfClass("Humanoid"):MoveTo(destination.Position)








end







function collect()
  local child,value
  local top,topvalue = nil,0
  local safe = false
  for i,v in pairs(game:GetService("Workspace").FirstZoneItems:GetChildren()) do
    child=nil
    value = 0
    for i2,v2 in pairs(v:GetChildren()) do
      if(v2:FindFirstChildOfClass("TouchTransmitter")) then
        child=v2
      end
    end
    if(not child) then
      v:Destroy()
    end
    for i2,v2 in pairs(child:GetTouchingParts()) do
      if(v2.Parent.Name == "Rocks" or v2.Parent.Name == "Rock") then
        child:Destroy()
        v:Destroy()
      end
    end
    if(child and not child.Anchored and child.Transparency ~= 1 and child.Position.Y < 10) then
      value = mag(child)
      if(not(value > topvalue) or topvalue == 0) then
        topvalue=value
        top=child
      end
    end
  end
  --print("TOP",topvalue,top)

  if(mag(top) < 3) then top:Destroy() top.Parent:Destroy() end


  if(mag(top) > 10) then
    lp.Character.Humanoid.Jump = true

    repeat wait() until not lp.Character.Humanoid.Jump
  end
  moveto(lp.Character,top)

  wait(0.5)

end

farm:Button("Collect item",collect)

farm:Toggle2("Collect item",collect)

local l__ShopEvents__2 = game:GetService("ReplicatedStorage"):WaitForChild("ShopEvents");
local u1 = nil;
l__ShopEvents__2.OnClientEvent:Connect(function(p1)
    u1 = p1;
end);

farm:Toggle2("Upgrade",function()
  game:GetService("ReplicatedStorage").ShopEvents:FireServer("Buy100000x",u1)
  game:GetService("ReplicatedStorage").ShopEvents:FireServer("Buy1000x",u1)
  game:GetService("ReplicatedStorage").ShopEvents:FireServer("Buy100x",u1)
  game:GetService("ReplicatedStorage").ShopEvents:FireServer("Buy10x",u1)
  game:GetService("ReplicatedStorage").ShopEvents:FireServer("Buy1x",u1)
  wait(1)
end)

farm:Toggle2("Auto Rebirth",function()
  game:GetService("ReplicatedStorage").ShopEvents:FireServer("Rebirth")
end)
farm:Toggle2("Auto Prestige (might not work)",function()
  game:GetService("ReplicatedStorage").ShopEvents:FireServer("Prestige")
end)

farm:Toggle2("Hide Information",function()
  for i,v in pairs(lp.Character.Head:GetChildren()) do
    if(v:IsA("BillboardGui")) then
      v:Destroy()
    end
  end --destroyed uis (Money,Name,Multiplier,Tag)
  pcall(function()
    lp.Character.Head.face:Destroy()
    --roblox patched being naked
  end)
  for i,v in pairs(lp.Character:GetChildren()) do
    if(v:IsA("Accessory")) then
      pcall(function()
        v.Handle.AccessoryWeld:Destroy()
      end)
    end
  end
end)

local groupid = 5368250

game.Players.PlayerAdded:Connect(function(player)
    if(_G.Autopanic) then
      role = player:GetRoleInGroup(groupid)
      if(role ~= "Guest" and role ~= "Member") then
        _G.panic = true
      end
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
  if(_G.Autopanic) then
    role = player:GetRoleInGroup(groupid)
    if(role ~= "Guest" and role ~= "Member") then
      _G.panic = false
      for i,v in pairs(game.Players:GetPlayers()) do
        role = v:GetRoleInGroup(groupid)
        if(role ~= "Guest" and role ~= "Member") then
          _G.panic = true
        end
      end
    end
  end
end)

farm:Toggle("Auto panic mode",function(toggle)
  _G.Autopanic = toggle
  spanic = false
  for i,v in pairs(game.Players:GetPlayers()) do
    role = v:GetRoleInGroup(groupid)
    if(role ~= "Guest" and role ~= "Member") then
      spanic = true
    end
  end
  _G.panic = spanic
  while game:GetService("RunService").RenderStepped:Wait() and _G.Autopanic do
    if(_G.panic) then
      _G.panicmode = _G.panicmode or "Client-sided kick"
      local pm = _G.panicmode
      if(pm == "Client-sided kick") then
        lp:Kick("Panic")
      end
      if(pm == "Client-sided crash") then
        repeat until nil
      end
      if(pm == "Client-sided crash (with kick)") then
        lp:Kick("Panic")
        wait(1)
        repeat
          lp:Kick("Panic")
        until nil
      end
      if(pm == "Rejoin") then
        game:GetService("TeleportService"):Teleport(game.PlaceId)
        print("Server Kick Message: ")
      end
      if(pm == "Timeout") then
        loadstring("settings().Network.IncomingReplicationLag = 10000")()
      end
      pcall(function()
        rconsolewarn("PANIC")
      end)
    else
      loadstring("settings().Network.IncomingReplicationLag = 0")()
    end
  end
end)


local panicmodes = {
  "Client-sided kick",
  "Client-sided crash",
  "Client-sided crash (with kick)",
  "Rejoin",
  "Timeout"
}

farm:Dropdown("Panicmode",panicmodes,true,function(value)
  _G.panicmode = value
end)
