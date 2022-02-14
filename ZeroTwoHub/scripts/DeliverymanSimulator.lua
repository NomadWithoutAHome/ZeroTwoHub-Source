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

function tp(part,ydif)
  if(type(part) == "table") then
    for i,v in pairs(part) do
      tp(v)
    end
  else
    lp.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0,ydif or 0,0)
    wait(0.5)
  end
end

function ModelTween(pos,yield)
    local CF = CFrame.new(pos)
    local model = game.Players.LocalPlayer.Character
	local tweenService = game:GetService("TweenService")
	local diff = (model.PrimaryPart.Position - pos).magnitude
	local speed = (diff / (_G.Speed or 25))
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
      until CFrameValue == nil or CFrameValue.Parent == nil or yield == false or (_G.BossActive == true) or (_G.EventActive == true)
      pcall(function()
        if(_G.BossActive == true or _G.EventActive == true) then
          CFrameValue:Destroy()
        end
      end)
	end
	tweenModel(model,CF)
end

function mag(part)
  if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and part:IsA("BasePart")) then
    return (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
  else
    return 0
  end
end
function pickup(part)
  if(mag(part) > 30) then
    tp(part,part.Size.Y+5)
    wait(0.3)
  end
  time1 = tick()
  repeat
    lp.Character.Humanoid:MoveTo(part.Position)
    fireproximityprompt(part.ProximityPrompt,0)
    wait(0.5)
  until lp.PlayerGui.Main.pickupsEquipped.Visible==true or tick()-time1 > 5
  if(tick()-time1 > 5) then
    tp(part,part.Size.Y+5)
    wait(0.3)
    pickup(part)
  end
end

function getnearestpart(folder)
  local top,maxdis,dis = nil,9e9,0
  for i,v in pairs(folder:GetChildren()) do
    dis = mag(v)
    if(dis < maxdis) then
      top = v
      maxdis = dis
    end
  end
  return top
end

local mults = {
  ["K"] = 1000,
  ["M"] = 1000000
}

function parsenum(str)
  mult = 1
  for i,v in pairs(mults) do
    if(string.find(str,i)) then
      str = string.gsub(str,i,"")
      mult = mult * v
    end
  end
  return tonumber(str)*mult or 9e9
end

chests = {"Normal","Group"}
for i,v in pairs(chests) do
  game:GetService("ReplicatedStorage").Assets.Events.RemoteFunction:InvokeServer("Redeem Chest Rewards", v)
end

main:Toggle2("Farm",function()
  mindiff = 9e9
  top = nil
  diff = 0
  for i,v in pairs(game:GetService("Workspace")["__MAP"].Collectibles:GetChildren()) do
    for i2,v2 in pairs(v:GetChildren()) do
      sreq = parsenum(string.split(string.split(v2.ProximityPrompt.ObjectText,"Req. ")[2]," Strength")[1])
      diff = parsenum(lp.leaderstats.Strength.Value) - sreq
      if(diff >= 0) then
        if(diff < mindiff) then
          mindiff = diff
          top = v2
        end
      end
    end
   end
  pickup(top)
  top = getnearestpart(game:GetService("Workspace")["__MAP"].FinishParts).Position
  top = Vector3.new(top.X,lp.Character.HumanoidRootPart.Position.Y,top.Z)
  repeat
    lp.Character.Humanoid:MoveTo(top)
    wait()
  until not lp.PlayerGui.Main.pickupsEquipped.Visible
end)

main:Toggle2("Train",function()
  if(not lp.PlayerGui.Main.pickupsEquipped.Visible) then
    plate = getnearestpart(game:GetService("Workspace")["__MAP"].Training)
    if(parsenum(lp.leaderstats.Energy.Value)>=parsenum(plate.CostBoard.TextLabel.Text)) then
      --lp.Stats.IsTraining.Value
      repeat
        tp(plate)
        fireproximityprompt(plate.ProximityPrompt)
        wait(0.5)
      until lp.Stats.IsTraining.Value
      repeat
        wait()
      until not (parsenum(lp.leaderstats.Energy.Value)>=parsenum(plate.CostBoard.TextLabel.Text)) or not lp.Stats.IsTraining.Value
      --game:GetService("ReplicatedStorage").Assets.Events.RemoteEvent:FireServer("exitTraining")
    end
  end
end)
local egg = "Egg1"
main:Dropdown("Eggs",game:GetService("ReplicatedStorage").Game.Eggs:GetChildren(),true,function(egg2)
  egg = egg2.Name
end)

main:Toggle2("Auto Buy Pets",function()
  local args = {
      [1] = "Buy Egg",
      [2] = egg,
      [3] = false
  }
  game:GetService("ReplicatedStorage").Assets.Events.RemoteFunction:InvokeServer(unpack(args))
end)

main:Toggle2("Auto Rebirth",function()
  game:GetService("ReplicatedStorage").Assets.Events.RemoteFunction:InvokeServer("Rebirth")
  wait(5)
end)
