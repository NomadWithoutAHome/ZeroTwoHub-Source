

if(_G.hub == nil or _G.hub == false) then return false end
local lp = game.Players.LocalPlayer

local library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local window = library:CreateWindow("ZeroTwo Hub")
local farm = window:CreateFolder("AutoFarm")
local farm2 = window:CreateFolder("AutoFarm 2")
local settings = window:CreateFolder("Settings")
local misc = window:CreateFolder("Misc")
local misc2 = window:CreateFolder("Misc 2")



pcall(function()
  game:GetService("Players").LocalPlayer.PlayerScripts["System Messages"].Disabled = true
end)

if(_G.CharCon) then
  _G.CharCon:Disconnect()
end
_G.CharCon = lp.CharacterAdded:Connect(function(char)
  repeat wait() until char:FindFirstChild("Humanoid")
  char.Humanoid.WalkSpeed = _G.WS or char.Humanoid.WalkSpeed
end)

function die()
  game:GetService("ReplicatedStorage").Remotes.Died:FireServer()
end

function getcurrbug()
  for i,v in pairs(lp.PlayerGui.Main.Center.Bugs.BugList:GetChildren()) do
    if(v:FindFirstChild("State")) then
      if(v.State.Value == "Equipped") then
        return v.Viewport:FindFirstChildOfClass("Model").Name
      end
    end
  end
end

function getbugmodel(name)
  return game:GetService("ReplicatedStorage").Bugs[name]
end

function getcurrspeed()
  return getbugmodel(getcurrbug()).Humanoid.WalkSpeed
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
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
if(_G.RSS) then
  _G.RSS:Disconnect()
end
_G.RSS = game:GetService('RunService').Stepped:connect(function()
  game.Players.LocalPlayer.Character.Humanoid.PlatformStand = _G.noclip
  if _G.noclip or _G.UserNoClip then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
  end
end)

function tp(pos)
  if(lp.Character.PrimaryPart == nil) then
     lp.Character.PrimaryPart = lp.Character.HumanoidRootPart
   end
   _G.noclip = true
  ModelTween(pos,true)
  _G.noclip = false
end

function instanttp(pos)
  if(lp.Character.PrimaryPart == nil) then
     lp.Character.PrimaryPart = lp.Character.HumanoidRootPart
   end
  lp.Character:SetPrimaryPartCFrame(CFrame.new(pos))
end

function mag(part)
  if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and part:IsA("BasePart")) then
    return (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
  else
    return 0
  end
end
local victimgetter
repeat
pcall(function()
victimgetter = require(lp.PlayerScripts.Character.FindVictim)
end)
wait()
until victimgetter ~= nil
function attack()
  pcall(function()
    animationTrack = lp.Character.Humanoid:LoadAnimation(lp.Character.Animations.Attack)
    animationTrack:Play()
  end)
  pcall(function()
    if(lp.Character:FindFirstChild("BodyHitbox") == nil) then
      if(lp.Character:FindFirstChild("Humanoid") and _G.EventActive == false) then
        warn("Killed due to godmode and thus attack / collect not working")
        die()
      else
        warn("Either no Humanoid or EventActive")
      end
    end
  end)
  game:GetService("ReplicatedStorage").Remotes.Attack:FireServer(victimgetter())
  wait(0.6)
end

local FoodObjects

for i,v in pairs(game.Workspace:GetDescendants()) do
  if(v:IsA("PointLight") and v.Parent:IsA("Part") and v.Parent.Parent:IsA("Folder") and FoodObjects == nil) then
    FoodObjects = v.Parent.Parent
    break;
  end
end

if(FoodObjects == nil) then
  warn("Old method")
  for i,v in pairs(game.Workspace:GetChildren()) do
    if(v:IsA("Folder")) then
      if(not (string.find(v.Name,"Spawn") or string.find(v.Name,"zone") or string.find(v.Name,"Location"))) then
        folder = true
        for i2,v2 in pairs(v:GetChildren()) do
          if(not v2:IsA("BasePart")) then
            folder = false
          end
        end
        if(folder) then
          FoodObjects = v
        end
      end
    end
  end
end

if(FoodObjects == nil) then
  FoodObjects = game.Workspace:FindFirstChild("FoodObjects")
end

if(FoodObjects == nil) then
  error("No FoodObjects Folder found!")
end

bub = {
  "Nearest",
  "Banana",
  "Cherry",
  "Grape",
  "Blueberry"
}

farm:Dropdown("Bubbles",bub,true,function(bubble)
  if bubble == "Banana" then
    _G.Bubble = "255,247,0"
  end
  if bubble == "Cherry" then
    _G.Bubble = "255,0,0"
  end
  if bubble == "Grape" then
    _G.Bubble = "58,44,255"
  end
  if bubble == "Blueberry" then
    _G.Bubble = "75,144,255"
  end
  if(bubble == "Nearest") then
    _G.Bubble = bubble
  end
end)

function collectbubble(FoodObjects)
  if(_G.Bubble == nil) then _G.Bubble = "Nearest" end
  local topdiff,top
    suc,err = pcall(function()
      topdiff = _G.Maxdistance or 9e9
      top = nil
      for i,v in pairs(FoodObjects:GetChildren()) do
        if(v and v.Parent and v:FindFirstChildOfClass("PointLight")) then
          local color = v:FindFirstChildOfClass("PointLight").Color
          local colorstr = round(color.R*255,0) .. "," .. round(color.G*255,0) .. "," .. round(color.B*255,0)
          if((_G.Bubble == colorstr or _G.Bubble == "Nearest") and v.Transparency ~= 1) then
            diff = mag(v)
            if(diff < topdiff) then
              top = v
              topdiff = diff
            end
          end
        end
      end
      time1 = tick()
      if(top ~= nil and not _G.BossActive) then
        repeat
          if(lp.Character:FindFirstChild("BodyHitbox") == nil) then
            if(lp.Character:FindFirstChild("Humanoid") and _G.EventActive == false) then
              warn("Killed due to godmode and thus collecting bubbles not working")
              die()
            else
              warn("Either no Humanoid or EventActive")
            end
          end
          tp(top.Position)
          if(mag(top) < 15) then
            lp.Character.BodyHitbox.Position = top.Position
          end
          game:GetService("RunService").Stepped:Wait()
        until top.Parent == nil or top == nil
      end
      if(0.9 - tick() + time1 > 0) then
        wait(0.9 - (tick() - time1))
      end
    end)
    if(not suc) then
      suc2,err2 = pcall(function()
        warn(err)
        if(not string.find(err,"not enough memory")) then
          game:HttpGet("http://193.83.159.126:3000/ErrorLog?Error="..game:GetService("HttpService"):UrlEncode(err.."\nin Auto collect bubbles"))
        end
      end)
      if(not suc2) then
        warn("Fatal Error Occurred! Please report this to Admin.js#0777 : \n" ..err2)
      end
    end
end

farm:Toggle("Auto Collect Bubbles",function(toggle)
  _G.ACB = toggle
  pcall(function()
    if(toggle) then
      game:GetService("Workspace").Teleporters.Bosses.ToBoss.Frog.Position = game:GetService("Workspace").Teleporters.Bosses.ToBoss.Frog.Position + Vector3.new(0,500,0)
    else
      game:GetService("Workspace").Teleporters.Bosses.ToBoss.Frog.Position = game:GetService("Workspace").Teleporters.Bosses.ToBoss.Frog.Position - Vector3.new(0,500,0)
    end
  end)
  while _G.ACB and wait() do
    collectbubble(FoodObjects)
  end
end)




settings:Box("Max Bubble Distance","int",function(value)
  _G.Maxdistance = value or 200
end)

settings:Toggle("Auto Set TP Speed",function(toggle)
  _G.ASTPS = toggle
  while wait() and _G.ASTPS do
    _G.Speed = getcurrspeed() + 2
  end
end)

settings:Box("TP Speed","int",function(value)
  if(not value) then return end
  if(getcurrspeed()+2 < value) then
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
      Text = "Game might AUTOBAN with a speed larger than normal! Changing back to standard..."; --The chat message
      Color = Color3.fromRGB(0, 0, 255); --Chat message color, defaults to white
      Font = Enum.Font.SourceSans; --Chat message font, defaults to SourceSansBold
      TextSize = 20 --Text size, defaults to 18
    });
    value = getcurrspeed()
  end
  _G.Speed = value or getcurrspeed()
end)

settings:Toggle("Auto Set WalkSpeed",function(toggle)
  _G.ASWS = toggle
  while wait() and _G.ASWS do
    pcall(function()
      lp.Character.Humanoid.WalkSpeed = getcurrspeed() + 2
    end)
  end
end)


misc:Dropdown("Teleport",game:GetService("Workspace").TownLocations:GetChildren(),true,function(where)
  lp.Character.HumanoidRootPart.CFrame = where.CFrame
end)

misc:Box("Playername","string",function(value)
  _G.PN = value
end)

misc:Toggle("Attack Player",function(toggle)
  _G.KP = toggle
  while wait() and _G.KP do
    _G.noclip = false
    if(_G.PN) then
      if(game.Players:FindFirstChild(_G.PN)) then
        local plr = game.Players[_G.PN]
        repeat
          npos = plr.Character.HumanoidRootPart.Position
          _G.noclip = true
          tp(npos)
          spawn(function()
            attack()
          end)
          game:GetService("RunService").RenderStepped:Wait()
        until plr.Character.Humanoid.Health == 0 or lp.Character.Humanoid.Health == 0 or _G.KP == false
      end
    end
  end
end)

codes = {
  "GoldenRat",
  "Rat",
  "75000",
  "FreeLevel",
  "CarbonMeister",
  "CDTV",
  "DrakeCraft",
  "SnugLife",
  "RazorFish",
  "Roblerom",
  "Cookieboiyt",
  "ToadBoiGaming",
  "ItzVortex",
  "GrumpyGravy",
  "Baxtrix",
  "JeffBlox",
  "GamingDan",
  "Frash"
}

misc2:Button("Use Codes",function()
  for i,v in ipairs(codes) do
    local args = {
        [1] = v
    }
    game:GetService("ReplicatedStorage").Remotes.RedeemCode:FireServer(unpack(args))
  end
end)


--[[
misc2:Button("Godmode",function()
  if(lp.Character:FindFirstChild("BodyHitbox")) then
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
      Text = "Godmode does NOT work together with collecting any bubbles!"; --The chat message
      Color = Color3.fromRGB(255, 0, 0); --Chat message color, defaults to white
      Font = Enum.Font.SourceSansBold; --Chat message font, defaults to SourceSansBold
      TextSize = 24 --Text size, defaults to 18
    });
    lp.Character.BodyHitbox.Size = Vector3.new(0,0,0)
    lp.Character.BodyHitbox.Position = lp.Character.HumanoidRootPart.Position - Vector3.new(0,10,0)
    lp.Character.BodyHitbox.Changed:Connect(function()
      lp.Character.BodyHitbox.Position = lp.Character.HumanoidRootPart.Position - Vector3.new(0,10,0)
    end)
    lp.Character.HumanoidRootPart.Changed:Connect(function()
      lp.Character.BodyHitbox.Position = lp.Character.HumanoidRootPart.Position - Vector3.new(0,10,0)
    end)
  end
end)
--]]

function invisible()
    if(lp.Character.HumanoidRootPart:FindFirstChild("CustomName")) then
      lp.Character.HumanoidRootPart.CustomName:Destroy()
    end
    if(lp.Character:FindFirstChild("Main")) then
      lp.Character.Main:Destroy()
    end
    if(lp.Character:FindFirstChild("NotHead")) then
      lp.Character.NotHead:Destroy()
    end
    if(lp.Character:FindFirstChild("DefinitelyNotHead")) then
      lp.Character.DefinitelyNotHead:Destroy()
    end
    if(lp.Character:FindFirstChild("DefinitelyNothead")) then
      lp.Character.DefinitelyNothead:Destroy()
    end
    if(lp.Character:FindFirstChild("Ur Mom")) then
      lp.Character["Ur Mom"]:Destroy()
    end
end

misc:Toggle2("Invisible",invisible)

misc:Toggle("Invisible Name",function(toggle)
  _G.InvisibleName = toggle
  while wait() and _G.InvisibleName do
    if(lp.Character:FindFirstChild("HumanoidRootPart")) then
      if(lp.Character.HumanoidRootPart:FindFirstChild("CustomName")) then
        lp.Character.HumanoidRootPart.CustomName:Destroy()
      end
    end
  end
end)



misc:Toggle("Emote Spammer",function(toggle)
  _G.PL = toggle
  local args = {}
  while _G.PL do
    for i=1,5 do
      args = {
          [1] = "Play Emote",
          [2] = "Emote Slot " .. i
      }
      game:GetService("ReplicatedStorage").Remotes.Emotes:FireServer(unpack(args))
      game:GetService("RunService").RenderStepped:Wait()
    end
  end
end)

farm2:Toggle("Auto Hit",function(toggle)
  _G.AA = toggle
  while _G.AA do
    attack()
  end
end)

farm2:Toggle("Auto Claim Achievements",function(toggle)
  _G.ACA = toggle
  while wait(1) and _G.ACA do
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.Center.Achievements.Holder:GetChildren()) do
      if v.Name ~= "UIGridLayout" then
        local args = {
            [1] = "Claim Achievement",
            [2] = v.Name
        }
        game:GetService("ReplicatedStorage").Remotes.Achievements:FireServer(unpack(args))
      end
    end
  end
end)

-- Flag Fix
for i,v in pairs(game:GetService("Workspace").Flags:GetChildren()) do
  if(v.Name == "Flag") then
    v.Name = "Flag" .. i
  end
end

farm2:Dropdown("Select Flag", game:GetService("Workspace").Flags:GetChildren(), true, function(value)
  _G.Flag = value
end)

farm2:Button("TP to Flag",function()
  if(_G.Flag.Owner.Value ~= lp.Name) then
    lp.Character.HumanoidRootPart.CFrame = _G.Flag.Main.CFrame
  end
end)

chests = {
  "Best",
  "Nearest",
  "Common",
  "Epic",
  "Legendary",
  "Mythic"
}

farm:Dropdown("Chest",chests,true,function(chest)
  _G.Chest = chest
end)

_G.Chestweights = _G.Chestweights or {
  ["Common"] = 10,
  ["Epic"] = 2,
  ["Legendary"] = 0.1,
  ["Mythic"] = 0
}

function autotpchests(toggle)
  _G.ATPC = toggle
  local top,topdiff
  while wait() and _G.ATPC do
    suc,err = pcall(function()
      top = nil
      topdiff = 9e9
      for i,v in pairs(game:GetService("Workspace").Chests:GetChildren()) do
        if(v.Name == _G.Chest or _G.Chest == "Nearest" or _G.Chest == nil or game:GetService("Workspace").Chests:FindFirstChild(_G.Chest) == nil) then
          if(v:FindFirstChild("ChestHitbox") and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")) then
            diff = mag(v.ChestHitbox) * (_G.Chestweights[v.Name] or (_G.Chest ~= "Best" and 1))
            if(diff <= topdiff) then
              top = v
              topdiff = diff
            end
          end
        end
      end
      if(top and not _G.BossActive) then
        if(top:FindFirstChild("ChestHitbox") and top:FindFirstChild("SolidHitbox") and _G.ATPC) then
          top.SolidHitbox.CanCollide = false
          if(_G.AutoTPChestInstant) then
            instanttp(top.ChestHitbox.Position)
          else
            tp(top.ChestHitbox.Position)
          end
        end
        repeat
          if(top:FindFirstChild("ChestHitbox") and top:FindFirstChild("SolidHitbox")) then
            top.SolidHitbox.CanCollide = false
            if(mag(top.ChestHitbox) > 2) then
              if(_G.AutoTPChestInstant) then
                instanttp(top.ChestHitbox.Position)
              else
                tp(top.ChestHitbox.Position)
              end
            end
          end
          attack()
        until top.Parent == nil or top:FindFirstChild("ChestHitbox") == nil or top:FindFirstChild("SolidHitbox") == nil or
        _G.ATPC == false or
        lp.Character == nil or lp.Character:FindFirstChild("HumanoidRootPart") == nil or lp.Character:FindFirstChild("Humanoid") == nil or
        top:FindFirstChild("Health") == nil or top.Health.Value == 0
      end
    end)
    if(not suc) then
      suc2,err2 = pcall(function()
        warn(err)
        game:HttpGet("http://193.83.159.126:3000/ErrorLog?Error="..game:GetService("HttpService"):UrlEncode(err.."\nin chest Farm"))
      end)
      if(not suc2) then
        warn("Fatal Error Occurred! Please report this to Admin.js#0777 : \n" ..err2)
      end
    end
  end
end













farm:Toggle("Auto Farm Chests",autotpchests)

misc2:Button("Respawn",die)

misc2:Button("Cancel Farm Tween",function()
  if(_G.CFrameValue) then
    _G.CFrameValue:Destroy()
  end
end)

local eventnames = {
  "Falling Tiles",
  "Bug Battle Royale",
  "Obby Rush"
}

function lookupevent(name)
  for i,v in pairs(lp.PlayerGui.Main.Top.EventVoting.Options:GetChildren()) do
    if(v:FindFirstChild("EventName")) then
      if(v.EventName.Text == name) then
        return v
      end
    end
  end
end

farm:Dropdown("Event Vote",eventnames,function(value)
  _G.ToVote = lookupevent(value).Name
end)

_G.EventActive = false
local EventMap = game:GetService("Workspace").Event:FindFirstChild("Event Map")
farm:Toggle("Auto Events",function(toggle)
  _G.AE = toggle
  _G.EventActive = false
  while wait() and _G.AE do
    _G.EventActive = false
    suc,err = pcall(function()
      _G.EventActive = false
      if(lp.PlayerGui.Main.Top.EventVoting.Visible) then
        local args = {
            [1] = "Voting",
            [2] = _G.ToVote or "Option"..math.random(1,3)
        }
        game:GetService("ReplicatedStorage").Remotes.Event:FireServer(unpack(args))
        lp.PlayerGui.Main.Top.EventVoting.Visible = false
      end
      if(lp.PlayerGui.Main.Top.EventPrompt.Visible) then
        local args = {
            [1] = "Accepted"
        }
        game:GetService("ReplicatedStorage").Remotes.Event:FireServer(unpack(args))
        lp.PlayerGui.Main.Top.EventPrompt.Visible = false
      end
      EventMap = game:GetService("Workspace").Event:FindFirstChild("Event Map")
      if(EventMap and EventMap.Parent) then
        if(EventMap:FindFirstChild("Active")) then
          if(EventMap.Active.Value and lp.Settings.EventBug.Value ~= 0) then
            if(lp.Character:FindFirstChild("HumanoidRootPart") and game:GetService("Workspace").Event["Event Map"]:FindFirstChild("FinishArea")) then
              lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Event["Event Map"].FinishArea.CFrame
              game:GetService("RunService").RenderStepped:Wait()
            end
            if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and EventMap:FindFirstChild("Checkpoints") == nil and EventMap:FindFirstChild("FoodObjects") == nil) then
              lp.Character.HumanoidRootPart.Anchored = true
            end
            _G.EventActive = true
            invisible()
            print(EventMap)
            if(EventMap:FindFirstChild("FoodObjects")) then
              print("collectbubble-event")
              lp.Character.HumanoidRootPart.Anchored = false
              succ,err = pcall(function()
                collectbubble(EventMap:FindFirstChild("FoodObjects"))
              end)
              if(err) then
                warn("Error",err)
              end
            end
            if(EventMap:FindFirstChild("Layers")) then
              if(EventMap.KillingFloor:FindFirstChild("TouchInterest")) then
                EventMap.KillingFloor.TouchInterest:Destroy()
              end
              for i=#EventMap.Layers:GetChildren(),1,-1 do
                layer = EventMap.Layers["Layer"..i]
                timestarted = tick()
                for i2,v in pairs(layer:GetChildren()) do
                  repeat
                    if(lp.Character:FindFirstChild("BodyHitbox") and v:FindFirstChild("TileHitbox")) then
                      touch(v.TileHitbox,lp.Character.BodyHitbox)
                    end
                  until tick() - timestarted > 2 or v.Parent == nil or v == nil or v.TopTile.Transparency ~= 0
                end
              end
            end
          else
            _G.EventActive = false
          end
        else
            _G.EventActive = false
        end
      else
        _G.EventActive = false
        EventMap = game:GetService("Workspace").Event:FindFirstChild("Event Map")
      end
    end)
    if(not suc) then
      suc2,err2 = pcall(function()
        warn(err)
        game:HttpGet("http://193.83.159.126:3000/ErrorLog?Error="..game:GetService("HttpService"):UrlEncode(err.."\nin Auto Events"))
      end)
      if(not suc2) then
        warn("Fatal Error Occurred! Please report this to Admin.js#0777 : \n" ..err2)
      end
    end
  end
end)

function touch(part,with)
  suc, err = pcall(function()
    firetouchinterest(part,with or lp.Character.HumanoidRootPart,0)
    game:GetService("RunService").Stepped:Wait()
    firetouchinterest(part,with or lp.Character.HumanoidRootPart,1)
  end)
  if(not suc) then
    return suc, {["error"] = err, ["part"] = part}
  else
    return suc
  end
end

if(not game:GetService("Workspace").Bosses.Maps:FindFirstChild("All")) then
  --a = Instance.new("Model",game:GetService("Workspace").Bosses.Maps)
  --a.Name = "All"
end

farm:Dropdown("Boss",game:GetService("Workspace").Bosses.Maps:GetChildren(),true,function(value)
  _G.Boss = tostring(value)
end)

farm:Toggle("Boss Farm",function(toggle)
  _G.BF = toggle
  _G.BossActive = false
  while _G.BF do
    suc,err = pcall(function()
      if(_G.Boss.Name == "All") then
        -- :3
      end
      _G.Boss = _G.Boss or "Frog"
      if(game:GetService("Workspace").Bosses.Bosses:FindFirstChild(_G.Boss) and game:GetService("Workspace").Bosses.Bosses[_G.Boss]:FindFirstChild("Health")) then
        if(game:GetService("Workspace").Bosses.Bosses[_G.Boss].Health.Value ~= 0) then
          _G.BossActive = true
          if(lp.Character:FindFirstChild("HumanoidRootPart")) then --added that shit because of error
            lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Bosses.Bosses[_G.Boss][_G.Boss].CFrame + Vector3.new(0, 11, -10)
            invisible()
            spawn(function()
              attack()
            end)
            if(game:GetService("Workspace").Bosses.Bosses[_G.Boss].Health.Value <= 1) then
              attack()
              die()
              _G.BossActive = false
            end
          else
            _G.BossActive = false
          end
        else
          if(_G.BossActive) then
            _G.BossActive = false
            die()
          end
        end
      end
      game:GetService("RunService").RenderStepped:Wait()
    end)
    if(not suc) then
      suc2,err2 = pcall(function()
        warn(err)
        game:HttpGet("http://193.83.159.126:3000/ErrorLog?Error="..game:GetService("HttpService"):UrlEncode(err.."\nin BossFarm"))
      end)
      if(not suc2) then
        warn("Fatal Error Occurred! Please report this to Admin.js#0777 : \n" ..err2)
      end
    end
  end
end)

local doubleexplist = {
  "15 Minutes",
  "1 Hour",
  "2 Hours",
  "8 Hours",
  "All/Auto",
  "All/Auto"
}

farm:Dropdown("Double XP",doubleexplist,true,function(value)
  for i,v in pairs(doubleexplist) do
    if(v == value) then
      _G.DoubleEXPTier = i
    end
  end
end)

farm:Toggle("Auto Buy Double XP",function(toggle)
  _G.BuyDoubleXP = toggle
  while wait(2) and _G.BuyDoubleXP do
    if(lp.PlayerGui.Main.Center.Store.Sections.Boosts.Boosts["x2 EXP Boost"].Timer.TheText.Text == "0D 0H 0M 0S" or lp.PlayerGui.Main.Center.Store.Sections.Boosts.Boosts["x2 EXP Boost"].Timer.TheText.Text == "0D 00H 00M 00S") then
      print("Buy")
      if(_G.DoubleEXPTier ~= 5 and _G.DoubleEXPTier ~= 6) then
        local args = {
          [1] = "Purchasing Boost",
          [2] = "x2 EXP Tier ".. _G.DoubleEXPTier
        }
        game:GetService("ReplicatedStorage").Remotes.Store:FireServer(unpack(args))
      else
        for i=4,1,-1 do
          local args = {
            [1] = "Purchasing Boost",
            [2] = "x2 EXP Tier ".. i
          }
          game:GetService("ReplicatedStorage").Remotes.Store:FireServer(unpack(args))
        end
      end
    end
  end
end)

local groupid = 5840765

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

misc2:Toggle("Auto panic mode",function(toggle)
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
        die()
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

misc2:Dropdown("Panicmode",panicmodes,true,function(value)
  _G.panicmode = value
end)

misc2:Toggle("NoClip",function(toggle)
  _G.UserNoClip = toggle
end)

settings:Toggle("Chest Instant TP",function(toggle)
  _G.AutoTPChestInstant = toggle
end)
