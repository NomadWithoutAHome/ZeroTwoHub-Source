repeat wait() until game
repeat wait() until game:GetService("VirtualUser")
repeat wait() until game.Players.LocalPlayer

local VirtualUser=game:service'VirtualUser'
game:service('Players').LocalPlayer.Idled:connect(function()
  VirtualUser:CaptureController()
  VirtualUser:ClickButton2(Vector2.new())
end) -- anti afk


local marketplaceService = game:GetService("MarketplaceService")
local lp = game.Players.LocalPlayer

library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilib"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main") -- a folder; that thing at the right side of the gui
local misc = window:CreateFolder("Misc")
local shop = window:CreateFolder("Shop")
local OldWorld = (game.PlaceId == 4520749081)
local NewWorld = (game.PlaceId == 6381829480)
game:GetService("Workspace")["sfx_is"]["Music_Area"].Volume = 0

_G.Tool = game:GetService("Players").LocalPlayer.PlayerStats.FightingStyle.Value
print("You are using " .. _G.Tool .. " now\n")

iswindowactive = iswindowactive or function() return true end

function getquest(name)
if(name == nil) then
  return false
end
if(not(mousemoveabs and mouse1click and _G.AGQ)) then
  return false
end
if(workspace.AntiTPNPC:FindFirstChild(name) == nil) then
  return false
end
local a=workspace.AntiTPNPC[name];
local b=game.Players.LocalPlayer;
repeat
  b.Character.HumanoidRootPart.CFrame=a.HumanoidRootPart.CFrame;
  game:GetService("ReplicatedStorage").Remotes.Functions.CheckQuest:InvokeServer(a)
  wait()
until b.PlayerGui:FindFirstChild(name) and iswindowactive() --get window to accept
local d=b.PlayerGui[name].Dialogue.Accept;
local e=10;
repeat
  f = 50
  repeat wait() until d.Visible or game.Players.LocalPlayer.PlayerGui.Quest.QuestBoard.QuestCount.Visible
  if b.PlayerGui:FindFirstChild(name) and game.Players.LocalPlayer.PlayerGui.Quest.QuestBoard.QuestCount.Visible == false then

    mousemoveabs(d.AbsolutePosition.X+e,d.AbsolutePosition.Y+f) --move to the accept button
    mouse1click() --click accept
  else
    return true
  end;
  wait()
e=e+1
until b.PlayerGui:FindFirstChild(name)==nil

end
local MapFolder
if(game.Workspace:FindFirstChild("MapFolder")) then
  MapFolder = game.Workspace.MapFolder
else
  MapFolder = Instance.new("Folder",game.Workspace)
  MapFolder.Name = "MapFolder"
end
local Bosses = {}
  if(game.Players.LocalPlayer.PlayerScripts.Services:FindFirstChild("RenderDistance")) then
    game.Players.LocalPlayer.PlayerScripts.Services.RenderDistance.Disabled = true
    game.Players.LocalPlayer.PlayerScripts.Services.RenderDistance:Destroy()
  end
  wait(0.1)
    for i,v in pairs(game.ReplicatedStorage.MAP:GetChildren()) do
    	if(string.find(v.Name,"Quest") or string.find(v.Name,"Shop") or string.find(v.Name,"RandomFruit") or string.find(v.Name,"RedBirdTalk") or string.find(v.Name,"Man") or string.find(v.Name,"Buy") or string.find(v.Name,"Girl") or string.find(v.Name,"SetSpawn") or string.find(v.Name,"Traveler") or string.find(v.Name,"Elite Pirate") or string.find(v.Name,"FatOtaku")) then
    		v.Parent = game.Workspace.AntiTPNPC
      else
        v.Parent = MapFolder
    	end
      if(i%10 == 0) then
        wait()
      end
    end
  wait(1)
  for i,v in pairs(game.ReplicatedStorage.MOB:GetChildren()) do
  	v.Parent = game.Workspace.Monster.Mon
    wait()
  end
  if(_G.BossChildCon) then
    _G.BossChildCon:Disconnect()
  end
  _G.BossChildCon = game.Workspace.Monster.Boss.ChildAdded:Connect(function(what)
    repeat
      what.Parent = game.Workspace.Monster.Mon
      wait()
    until what.Parent == game.Workspace.Monster.Mon
  end)
  wait(0.1)
  for i,v in pairs(game.Workspace.Monster.Boss:GetChildren()) do
  	v.Parent = game.Workspace.Monster.Mon
    wait()
  end
  for i,v in pairs(game.Players:GetPlayers()) do
    if(v.Character) then
      v.Character.Parent = game.Workspace
    end
  end

local Quests = {
}
local MobArr = {}

_G.CharAddedEvent = {}

local Plrs = game.Players
local CoreGui = game.CoreGui

function toggleESP(toggle)
	_G.ESP = toggle
	if _G.ESP then
		for _, v in next, game.Players:GetPlayers() do
			if v ~= lp then
				if _G.CharAddedEvent[v.Name] == nil then
					_G.CharAddedEvent[v.Name] = v.CharacterAdded:connect(function(Char)
            RemoveESP(v)
						if _G.ESP then
							CreateESP(v)
						end
						repeat wait() until Char:FindFirstChild("HumanoidRootPart")
					end)
				end
				RemoveESP(v)
				CreateESP(v)
			end
		end
	else
		for _, v in next, game.CoreGui:GetChildren() do
			if(string.find(v.Name,"ESP_")) then
        v:Destroy()
      end
		end
	end
end
if(_G.PLAYERLEFTCON) then
  _G.PLAYERLEFTCON:Disconnect()
end
if(_G.PLAYERJOINCON) then
  _G.PLAYERJOINCON:Disconnect()
end
_G.PLAYERLEFTCON = game.Players.PlayerRemoving:Connect(function(v)
  RemoveESP(v)
  if(_G.CharAddedEvent[v.Name]) then
    _G.CharAddedEvent[v.Name]:Disconnect()
  end
end)
_G.PLAYERJOINCON = game.Players.PlayerAdded:Connect(function(v)
  if _G.CharAddedEvent[v.Name] == nil then
    _G.CharAddedEvent[v.Name] = v.CharacterAdded:connect(function(Char)
      RemoveESP(v)
      if _G.ESP then
        CreateESP(v)
      end
      repeat wait() until Char:FindFirstChild("HumanoidRootPart")
    end)
  end
end)

if(_G.ESPUPCON) then
  _G.ESPUPCON:Disconnect()
end
local ESP = {}
_G.ESPUPCON = game:GetService("RunService").RenderStepped:Connect(function()
  ESP = {}
  for i,v in pairs(game.CoreGui:GetChildren()) do
    if(ESP[v.Name]) then
      v:Destroy()
    else
      if(string.find(v.Name,"ESP_")) then
        ESP[v.Name] = true
      end
    end
  end
  for i,v in pairs(game.Players:GetPlayers()) do
    UpdateESP(v)
  end
end)




function CreateESP(plr)
	if plr ~= nil then
		local GetChar = plr.Character
		if not GetChar then return end
		local GetHead do
			repeat wait() until GetChar:FindFirstChild("Head")
		end
		GetHead = GetChar.Head

		local bb = Instance.new("BillboardGui", CoreGui)
		bb.Adornee = GetHead
		bb.ExtentsOffset = Vector3.new(0, 1, 0)
		bb.AlwaysOnTop = true
		bb.Size = UDim2.new(0, 50, 0, 50)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.Name = "ESP_" .. plr.Name

		local frame = Instance.new("Frame", bb)
		frame.ZIndex = 10
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0,0,0,-240)

		local TxtName = Instance.new("TextLabel", frame)
		TxtName.Name = "Names"
		TxtName.ZIndex = 10
		TxtName.Text = plr.Name
		TxtName.BackgroundTransparency = 1
		TxtName.Position = UDim2.new(0, 0, 0, -45)
		TxtName.Size = UDim2.new(1, 0, 10, 0)
		TxtName.Font = "SourceSansBold"
		TxtName.TextColor3 = Color3.new(0, 0, 0)
		TxtName.TextSize = 14
		TxtName.TextStrokeTransparency = 0.5

    local TxtLevel = Instance.new("TextLabel", frame)
		TxtLevel.Name = "Level"
		TxtLevel.ZIndex = 10
		TxtLevel.Text = ""
		TxtLevel.BackgroundTransparency = 1
		TxtLevel.Position = UDim2.new(0, 0, 0, -35)
		TxtLevel.Size = UDim2.new(1, 0, 10, 0)
		TxtLevel.Font = "SourceSansBold"
		TxtLevel.TextColor3 = Color3.new(0, 0, 0)
		TxtLevel.TextSize = 15
		TxtLevel.TextStrokeTransparency = 0.5

		local TxtDist = Instance.new("TextLabel", frame)
		TxtDist.Name = "Dist"
		TxtDist.ZIndex = 10
		TxtDist.Text = ""
		TxtDist.BackgroundTransparency = 1
		TxtDist.Position = UDim2.new(0, 0, 0, -25)
		TxtDist.Size = UDim2.new(1, 0, 10, 0)
		TxtDist.Font = "SourceSansBold"
		TxtDist.TextColor3 = Color3.new(0, 0, 0)
		TxtDist.TextSize = 15
		TxtDist.TextStrokeTransparency = 0.5

		local TxtHealth = Instance.new("TextLabel", frame)
		TxtHealth.Name = "Health"
		TxtHealth.ZIndex = 10
		TxtHealth.Text = ""
		TxtHealth.BackgroundTransparency = 1
		TxtHealth.Position = UDim2.new(0, 0, 0, -15)
		TxtHealth.Size = UDim2.new(1, 0, 10, 0)
		TxtHealth.Font = "SourceSansBold"
		TxtHealth.TextColor3 = Color3.new(0, 0, 0)
		TxtHealth.TextSize = 15
		TxtHealth.TextStrokeTransparency = 0.5



		local TxtMelee = Instance.new("TextLabel", frame)
		TxtMelee.Name = "Melee"
		TxtMelee.ZIndex = 10
		TxtMelee.Text = ""
		TxtMelee.BackgroundTransparency = 1
		TxtMelee.Position = UDim2.new(0, 0, 0, -5)
		TxtMelee.Size = UDim2.new(1, 0, 10, 0)
		TxtMelee.Font = "SourceSansBold"
		TxtMelee.TextColor3 = Color3.new(0, 0, 0)
		TxtMelee.TextSize = 15
		TxtMelee.TextStrokeTransparency = 0.5

    local TxtFightingStyle = Instance.new("TextLabel", frame)
    TxtFightingStyle.Name = "FightingStyle"
    TxtFightingStyle.ZIndex = 10
    TxtFightingStyle.Text = ""
    TxtFightingStyle.BackgroundTransparency = 1
    TxtFightingStyle.Position = UDim2.new(0, 0, 0, 5)
    TxtFightingStyle.Size = UDim2.new(1, 0, 10, 0)
    TxtFightingStyle.Font = "SourceSansBold"
    TxtFightingStyle.TextColor3 = Color3.new(0, 0, 0)
    TxtFightingStyle.TextSize = 15
    TxtFightingStyle.TextStrokeTransparency = 0.5

		local TxtDF = Instance.new("TextLabel", frame)
		TxtDF.Name = "DF"
		TxtDF.ZIndex = 10
		TxtDF.Text = ""
		TxtDF.BackgroundTransparency = 1
		TxtDF.Position = UDim2.new(0, 0, 0, 15)
		TxtDF.Size = UDim2.new(1, 0, 10, 0)
		TxtDF.Font = "SourceSansBold"
		TxtDF.TextColor3 = Color3.new(0, 0, 0)
		TxtDF.TextSize = 15
		TxtDF.TextStrokeTransparency = 0.5

    local TxtDFName = Instance.new("TextLabel", frame)
    TxtDFName.Name = "DFName"
    TxtDFName.ZIndex = 10
    TxtDFName.Text = ""
    TxtDFName.BackgroundTransparency = 1
    TxtDFName.Position = UDim2.new(0, 0, 0, 25)
    TxtDFName.Size = UDim2.new(1, 0, 10, 0)
    TxtDFName.Font = "SourceSansBold"
    TxtDFName.TextColor3 = Color3.new(0, 0, 0)
    TxtDFName.TextSize = 15
    TxtDFName.TextStrokeTransparency = 0.5

    local TxtSword = Instance.new("TextLabel", frame)
		TxtSword.Name = "Sword"
		TxtSword.ZIndex = 10
		TxtSword.Text = ""
		TxtSword.BackgroundTransparency = 1
		TxtSword.Position = UDim2.new(0, 0, 0, 35)
		TxtSword.Size = UDim2.new(1, 0, 10, 0)
		TxtSword.Font = "SourceSansBold"
		TxtSword.TextColor3 = Color3.new(0, 0, 0)
		TxtSword.TextSize = 15
		TxtSword.TextStrokeTransparency = 0.5

    local TxtSwordName = Instance.new("TextLabel", frame)
		TxtSwordName.Name = "SwordName"
		TxtSwordName.ZIndex = 10
		TxtSwordName.Text = ""
		TxtSwordName.BackgroundTransparency = 1
		TxtSwordName.Position = UDim2.new(0, 0, 0, 45)
		TxtSwordName.Size = UDim2.new(1, 0, 10, 0)
		TxtSwordName.Font = "SourceSansBold"
		TxtSwordName.TextColor3 = Color3.new(0, 0, 0)
		TxtSwordName.TextSize = 15
		TxtSwordName.TextStrokeTransparency = 0.5

    return true

	end
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function converttoletter(num)
	if num / 1e03 >=1 then
		newnum = num / 1e03
		return round(newnum, 6).. "K"
	else
    return num
	end
end


function UpdateESP(plr)
	local Find = CoreGui:FindFirstChild("ESP_" .. plr.Name)
  local MyChar = game.Players.LocalPlayer.Character
	if Find then
		Find.Frame.Names.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.Dist.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.Health.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.Melee.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.DF.TextColor3 = Color3.new(1, 1, 1)
    Find.Frame.DFName.TextColor3 = Color3.new(1, 1, 1)
    Find.Frame.Sword.TextColor3 = Color3.new(1, 1, 1)
    Find.Frame.SwordName.TextColor3 = Color3.new(1, 1, 1)
    Find.Frame.Level.TextColor3 = Color3.new(1, 1, 1)
    Find.Frame.FightingStyle.TextColor3 = Color3.new(1, 1, 1)
		local GetChar = plr.Character
		if MyChar and GetChar then
			local Find2 = MyChar:FindFirstChild("HumanoidRootPart")
			local Find3 = GetChar:FindFirstChild("HumanoidRootPart")
			local Find4 = GetChar:FindFirstChildOfClass("Humanoid")
			if Find2 and Find3 then
				local pos = Find3.Position
				local Dist = (Find2.Position - pos).magnitude
				if Dist > 1e9 then
					Find.Frame.Names.Visible = false
					Find.Frame.Dist.Visible = false
					Find.Frame.Health.Visible = false
					Find.Frame.Melee.Visible = false
					Find.Frame.DF.Visible = false
          Find.Frame.DFName.Visible = false
          Find.Frame.Sword.Visible = false
          Find.Frame.SwordName.Visible = false
          Find.Frame.Level.Visible = false
          Find.Frame.FightingStyle.Visible = false
					return
				else
					Find.Frame.Names.Visible = true
					Find.Frame.Dist.Visible = true
					Find.Frame.Health.Visible = true
					Find.Frame.Melee.Visible = true
					Find.Frame.DF.Visible = true
          Find.Frame.DFName.Visible = true
          Find.Frame.Sword.Visible = true
          Find.Frame.SwordName.Visible = true
          Find.Frame.Level.Visible = true
          Find.Frame.FightingStyle.Visible = true
				end
				Find.Frame.Dist.Text = "Distance: " .. converttoletter(string.format("%.0f", Dist))
        if(Find4) then
				      Find.Frame.Health.Text = "Health: " ..converttoletter(string.format("%.0f", Find4.Health))
        else
              Find.Frame.Health.Text = "Health: 0"
        end
				Find.Frame.Melee.Text = "Melee: " ..converttoletter(string.format("%.0f", game.Players[plr.Name].PlayerStats.Melee.Value))
				Find.Frame.DF.Text = "DF: " ..converttoletter(string.format("%.0f", game.Players[plr.Name].PlayerStats.DF.Value))
        Find.Frame.DFName.Text = "DFName: " ..game.Players[plr.Name].PlayerStats.DFName.Value
        Find.Frame.Sword.Text = "Sword: " ..converttoletter(string.format("%.0f", game.Players[plr.Name].PlayerStats.sword.Value))
        Find.Frame.SwordName.Text = "SwordName: " ..game.Players[plr.Name].PlayerStats.SwordName.Value
        Find.Frame.Level.Text = "Level: " ..converttoletter(string.format("%.0f", game.Players[plr.Name].PlayerStats.lvl.Value))
        Find.Frame.FightingStyle.Text = "FightingStyle: " ..game.Players[plr.Name].PlayerStats.FightingStyle.Value
			end
		end
	end
end

function RemoveESP(plr)
  for i,v in pairs(CoreGui:GetChildren()) do
    if(v.Name == "ESP_" .. plr.Name) then
      v:Destroy()
	   end
   end
end







function parseInt(text)
  if(text) then
  str = string.split(text,"[Lv. ")[2]
  if(str) then
  str = string.split(str,"]")[1]
  if(str) then
  num = tonumber(str)
  end
  end
  end
  return num
end

for i,v in pairs(game.Workspace.Monster.Mon:GetChildren()) do
  MobArr[#MobArr+1] = v.Name
  lvl = parseInt(v.Name)
  Quests[v.Name] = "QuestLvl"..lvl
end


local Mobs = {} --Namensliste an mobs
for i,v in pairs(Quests) do
  Mobs[#Mobs+1] = i
end
local Levels = {}
for i,v in pairs(Quests) do
  Levels[i] = parseInt(i)
end

function getenemy()
  local level = game:GetService("Players").LocalPlayer.PlayerStats.lvl.Value
  local enemy = ""
  local curlevel = 0
  for i,v in pairs(Levels) do
    if(v <= level) then
      if(v > curlevel) then
        enemy = i
        curlevel = v
      end
    end
  end
return enemy
end




Cooldown = {}
function farm(Name)
  repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  local arg  = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(-0.69579249620438, -0.51927709579468, 0.49620991945267))
  local Folder = game.Workspace.Monster.Mon
  local Boss = Bosses[Name]
  if(Boss) then
    Folder = game.Workspace.Monster.Boss
  end
  if(game.PlaceId == 5931540094) then
    Folder = game.Workspace.MOB
  end
  for i,v in pairs(Folder:GetChildren()) do
    if(v:FindFirstChild("Humanoid")) then
      if((v.Name == Name or game.PlaceId == 5931540094) and v.Humanoid.Health ~= 0) then
        if(game.Players.LocalPlayer.PlayerGui.Quest.QuestBoard.QuestCount.Visible == false)then
          if(mousemoveabs and mouse1click) then
            getquest(Quests[Name])
          end
        end --visible
        local time1 = tick()
        repeat
          local tool = lp.Character:FindFirstChild(_G.Tool)
          if(tool == nil) then
            tool = lp.Backpack:FindFirstChild(_G.Tool)
            if(tool) then
              lp.Character.Humanoid:EquipTool(tool)
            else
              repeat wait() until lp.Backpack:FindFirstChild(_G.Tool)
              tool = lp.Backpack:FindFirstChild(_G.Tool)
              lp.Character.Humanoid:EquipTool(tool)
            end --tool
          end --not tool
          if(tool) then

            tool:Activate()
            if(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
              game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,_G.Distance)
            end
            game:GetService("RunService").RenderStepped:Wait()
            spawn(function()
              arg = v.HumanoidRootPart.CFrame
              if(tool:FindFirstChild("V")) then
                tool.V:InvokeServer(arg)
              end
              for i,v in pairs(tool:GetChildren()) do
                if(v:IsA("RemoteFunction") and v.Name ~= "V" and v.Name ~= "E") then
                  v:InvokeServer(arg,"Hold")
                  v:InvokeServer(arg,"Fire")
                  wait()
                end
              end
            end)
          end --tool
        until v.Humanoid.Health == 0 or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game.Players.LocalPlayer.Character.Humanoid.Health == 0 or _G.AF == false --repeat
      end --vName == Name & health
    end
  end
end




main:Toggle("Auto Farm Mobs",function(toggle)
  _G.AF = toggle
  while wait() and _G.AF do
    farm(getenemy());
  end
end)

main:Box("Attack with (F9 for info)","string",function(name)
  _G.Tool = name
  if _G.Tool == "Melee" then
    _G.Tool = lp.PlayerStats.FightingStyle.Value
  end
  if _G.Tool == "Sword" then
    _G.Tool = lp.PlayerStats.SwordName.Value
  end
  if _G.Tool == "DF" then
    _G.Tool = lp.PlayerStats.DFName.Value
  end
  if _G.Tool ~= lp.PlayerStats.DFName.Value and _G.Tool ~= lp.PlayerStats.SwordName.Value and _G.Tool ~= lp.PlayerStats.FightingStyle.Value then
    print("You dont have " .. _G.Tool .." as an equipable Weapon, use one of these three: " .. lp.PlayerStats.DFName.Value .. ", " .. lp.PlayerStats.SwordName.Value .. " or " .. lp.PlayerStats.FightingStyle.Value)
    _G.Tool = game:GetService("Players").LocalPlayer.PlayerStats.FightingStyle.Value
  end
  print("You are using " .. _G.Tool .. " now\n")
end)

main:Box("Distance","int",function(distance)
  _G.Distance = distance or 4
end)

main:Toggle("Auto Get Quest",function(toggle)
  _G.AGQ = toggle
end)

StatChoice = {
    "Melee",
    "Defense",
    "Sword",
    "Devil Fruit"
}

if(OldWorld) then
  main:Toggle("Oars Farm",function(toggle)
    _G.AO = toggle
    while wait() and _G.AO do
      if(game.Players.LocalPlayer.Backpack:FindFirstChild("Gem")) then
        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
        wait()
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Gem"))
        wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Island["K - Zombie Island"].SummonAltar.CFrame
        repeat wait() until game.Workspace.Monster.Mon:FindFirstChild("Monster [Lv. 2500]")
      end
      if(game.Workspace.Monster.Mon:FindFirstChild("Monster [Lv. 2500]")) then
        farm("Monster [Lv. 2500]")
      else
        farm("Shadow Master [Lv. 1600]")
      end
    end
  end)

  main:Toggle("Shanks Farm",function(toggle)
    _G.SF = toggle
    while wait() and _G.SF do
      farm("Expert Swordman [Lv. 3000]")
      farm("Santa [Lv. 5000]")
    end
  end)
end

if(NewWorld) then
  main:Toggle("Oden Farm",function(toggle)
    _G.ODEN = toggle
    while wait() and _G.ODEN do
      farm("King Samurai [Lv.3500]")
    end
  end)
end

main:Dropdown("Add",StatChoice,true,function(value)
_G.Stat = value
end)
main:Toggle("Auto Stat",function(toggle)
  _G.AS = toggle
  while wait() and _G.AS do
    if(_G.Stat) then
      if(game:GetService("Players").LocalPlayer.PlayerStats.Points.Value ~= 0) then
        local args = {
            [1] = game:GetService("Players").LocalPlayer.PlayerStats,
            [2] = game:GetService("Players").LocalPlayer.PlayerStats.Points.Value
        }
        game:GetService("Players").LocalPlayer.PlayerGui.Stats.Button.StatsFrame[_G.Stat].RemoteEvent:FireServer(unpack(args))
      end
    end
  end
end)

main:Toggle("Auto Buso",function(toggle)
  _G.AH = toggle
end)

main:Toggle("ESP",toggleESP)

misc:Button("Use Codes",function()
  local table = {
    "Peodiz",
    "BeckyStyle",
    "KingPieceComeBack",
    "80MVISITS",
    "100kFAV",
    "DragonIsStrong",
    "REDBIRD",
    "Merry Christmas",
    "DinoxLive",
    "Snow",
    "String",
    "Shadow"
  }
  for i,v in pairs(table) do
    local args = {
        [1] = v
    }
    game:GetService("ReplicatedStorage").redeemcode:InvokeServer(unpack(args))
  end
end)


if(_G.hakicon) then
  _G.hakicon:Disconnect()
end
_G.hakicon = game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
  repeat wait() until char:FindFirstChild("Services")
  repeat wait() until char.Services:FindFirstChild("Client")
  repeat wait() until char.Services.Client:FindFirstChild("BusoEvent")
  if(_G.AH) then
    char.Services.Client.BusoEvent:FireServer()
  end
end)


misc:Box("Player Name to kill","string",function(value)
  _G.PTK = game.Players:FindFirstChild(value)
  _G.PTK = _G.PTK or lp
end)

misc:Toggle("Kill Player",function(toggle)
  _G.KP = toggle
  while wait() and _G.KP do
    if(_G.PTK ~= lp) then
      v = _G.PTK.Character
      local time1 = tick()
      repeat
        local tool = lp.Character:FindFirstChild(_G.Tool)
        if(tool == nil) then
          tool = lp.Backpack:FindFirstChild(_G.Tool)
          if(tool) then
            lp.Character.Humanoid:EquipTool(tool)
          else
            repeat wait() until lp.Backpack:FindFirstChild(_G.Tool)
            tool = lp.Backpack:FindFirstChild(_G.Tool)
            lp.Character.Humanoid:EquipTool(tool)
          end --tool
        end --not tool
        if(tool) then
          tool:Activate()
          if(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,_G.Distance)
          end
          game:GetService("RunService").RenderStepped:Wait()
          spawn(function()
            arg = v.HumanoidRootPart.CFrame
            if(tool:FindFirstChild("V")) then
              tool.V:InvokeServer(arg)
            end
            for i,v in pairs(tool:GetChildren()) do
              if(v:IsA("RemoteFunction")) then
                v:InvokeServer(arg)
              end
            end
          end)
        end --tool
      until v.Humanoid.Health == 0 or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game.Players.LocalPlayer.Character.Humanoid.Health == 0 or _G.KP == false
    end
  end
end)

misc:Button("No Water Damage",function()
  game:GetService("Players").LocalPlayer.Backpack.SwimScript.Disabled = true
  local args = {
      [1] = "out"
  }
  game:GetService("Players").LocalPlayer.Backpack.SwimScript.RemoteEvent:FireServer(unpack(args))

  local l__RunService__1 = game:GetService("RunService");
  local l__UserInputService__2 = game:GetService("UserInputService");
  wait(0.05);
  local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
  while true do
  wait();
  if l__LocalPlayer__3.Character then
    break;
  end;
  end;
  local l__Character__4 = l__LocalPlayer__3.Character;
  local u1 = {
  Idle = nil,
  Moving = nil,
  Up = nil,
  Down = nil,
  Jump = nil
  };
  local l__Humanoid__2 = l__Character__4:WaitForChild("Humanoid", 30);
  local u3 = {
  Idle = game.ReplicatedStorage.Chest.Animation.SwimAnimation.Animation,
  Moving = game.ReplicatedStorage.Chest.Animation.SwimAnimation.test,
  Up = game.ReplicatedStorage.Chest.Animation.SwimAnimation.Animation,
  Down = game.ReplicatedStorage.Chest.Animation.SwimAnimation.Animation,
  Jump = game.ReplicatedStorage.Chest.Animation.SwimAnimation.Jump
  };
  function PlayAnimate(p1)
  local v5, v6, v7 = pairs(u1);
  while true do
    local v8, v9 = v5(v6, v7);
    if v8 then

    else
      break;
    end;
    v7 = v8;
    if v8 ~= p1 then
      u1[v8]:Stop();
      u1[v8] = nil;
    end;
  end;
  if u1[p1] == nil then
    u1[p1] = l__Humanoid__2:LoadAnimation(u3[p1]);
    u1[p1]:Play();
  end;
  end;
  local l__HumanoidRootPart__4 = l__Character__4:WaitForChild("HumanoidRootPart", 30);
  local u5 = true;
  local u6 = false;
  local u7 = -2;
  local l__CurrentCamera__8 = workspace.CurrentCamera;
  local v10 = l__RunService__1.RenderStepped:Connect(function()
  local v11 = l__Character__4:findFirstChild("HumanoidRootPart");
  local l__Swim__12 = l__HumanoidRootPart__4:FindFirstChild("Swim");
  if v11 and l__HumanoidRootPart__4.Position.Y <= -2 and u5 then
    local l__Swim__13 = l__HumanoidRootPart__4:FindFirstChild("Swim");
    if not l__Swim__13 then
      local v14 = Instance.new("BodyPosition");
      v14.Name = "Swim";
      v14.MaxForce = Vector3.new(0, 1000000, 0);
      v14.Position = Vector3.new(0, -2, 0);
      v14.Parent = l__HumanoidRootPart__4;
      u7 = -2;
      return;
    end;
    if l__Swim__13 then
      l__HumanoidRootPart__4.Swim.Position = Vector3.new(0, math.max(u7, -80), 0);
      if l__Humanoid__2.MoveDirection.Magnitude > 0 and l__CurrentCamera__8.CoordinateFrame:vectorToWorldSpace(Vector3.new(0, 0, -2)).Y < -1.5 then
        u7 = u7 - 0.7;
        PlayAnimate("Moving");
        return;
      elseif l__Humanoid__2.MoveDirection.Magnitude > 0 and l__CurrentCamera__8.CoordinateFrame:vectorToWorldSpace(Vector3.new(0, 0, -2)).Y > 1 then
        u7 = u7 + 0.7;
        if u7 > -2 then
          u7 = -2;
        end;
        PlayAnimate("Moving");
        return;
      elseif l__Humanoid__2.MoveDirection.Magnitude <= 0 then
        PlayAnimate("Idle");
        return;
      else
        PlayAnimate("Moving");
        return;
      end;
    end;
  elseif v11 and l__Swim__12 and l__HumanoidRootPart__4.Position.Y > -1.5 then
    if u6 then
      u6 = false;
      script.RemoteEvent:FireServer("out");
    end;
    local l__Swim__15 = l__HumanoidRootPart__4:FindFirstChild("Swim");
    if l__Swim__15 then
      l__Swim__15:Destroy();
    end;
    PlayAnimate("Jump");
  end;
  end);
  l__UserInputService__2.JumpRequest:Connect(function()
  if l__HumanoidRootPart__4:FindFirstChild("Swim") and u7 > -4 then
    u5 = false;
    local l__Swim__16 = l__HumanoidRootPart__4.Swim;
    l__Swim__16.Position = Vector3.new(0, math.abs(-32), 0);
    PlayAnimate("Jump");
    spawn(function()
      wait(0.15);
      l__Swim__16:Destroy();
      u5 = true;
    end);
  end;
  end);
  l__Humanoid__2.Died:Connect(function()
  if v10 then
    v10:Disconnect();
  end;
  end);
end)

  misc:Toggle("Infinite Geppo",function(toggle)
  _G.IG = toggle
  while wait() and _G.IG do
    game:GetService("Players").LocalPlayer.Backpack.GeppoNew.cds.Value = 2
  end
end)

misc:Toggle("Infinite Soru",function(toggle)
  game:GetService("Players").LocalPlayer.Backpack.Soru.Disabled = toggle
  if(_G.SoruCon) then
    _G.SoruCon:Disconnect()
    _G.SoruCon = nil
  end
  if(toggle) then
    local mouse = lp:GetMouse();
    _G.SoruCon = game:GetService("UserInputService").InputBegan:Connect(function(p1, p2)
    	if p2 then
    		return;
    	end;
    	if p1.KeyCode == Enum.KeyCode.F then
    		game:GetService("Players").LocalPlayer.Backpack.Soru.RemoteSoru:FireServer(mouse.hit);
    	end;
    end);
  end
end)
if(_G.DFTPCon) then
  _G.DFTPCon:Disconnect()
end
_G.DFTPCon = game.Workspace.ChildAdded:Connect(function(v)
  v:WaitForChild("Handle",1)
  if v:IsA("Tool") and v:FindFirstChild("Handle") and v:FindFirstChild("DevilFruit") and _G.DFT then
    repeat
      v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
      wait()
    until v.Parent == nil or v.Parent == lp.Character or v.Parent == lp.Backpack or v == nil or v:FindFirstChild("Handle") == nil
  end
end)

misc:Toggle("Devil Fruit TP",function(toggle)
  _G.DFT = toggle
  if(toggle) then
    for i,v in pairs(game.Workspace:GetDescendants()) do
      if v:IsA("Tool") and v:FindFirstChild("Handle") and v:FindFirstChild("DevilFruit") then
        v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait()
      end
    end
  end
end)

local kenhaki = 0
misc:Toggle("Semi-Inf Ken",function(toggle)
  _G.SIK = toggle
  while wait() and _G.SIK do
    local char = game.Players.LocalPlayer.Character
    if(char==nil or char:FindFirstChild("HumanoidRootPart") == nil) then
    else
      kenhaki = char.KenHaki.Value
      if(kenhaki == 0 or kenhaki == 1) then
        char.Services.Client.KenEvent:InvokeServer(false)
        if(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Soru")) then
          game:GetService("Players").LocalPlayer.Backpack.Soru.RemoteSoru:FireServer(char.HumanoidRootPart.CFrame + Vector3.new(0,25,0));
        else
          char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0,25,0)
        end
        char.Services.Client.KenEvent:InvokeServer(true)
      end
    end
  end
end)


FruitList = {
"None",
"BarrierBarrier",
"BombBomb",
"BuddhaBuddha",
"DarkDark",
"DragonDragon",
"FlameFlame",
"GiraffeGiraffe",
"GravityGravity",
"GumGum",
"HumanHuman",
"IceIce",
"LeopardLeopard",
"LightLight",
"LoveLove",
"MagmaMagma",
"OpOp",
"PawPaw",
"PhoenixPhoenix",
"QuakeQuake",
"RumbleRumble",
"SandSand",
"ShadowShadow",
"SnowSnow",
"StringString",
"VenomVenom",
"WolfWolf"
}

shop:Toggle("Shop Sniper",function(toggle)
  _G.SS = toggle
  while wait() and _G.SS do
    local TimeLeft = game:GetService("ReplicatedStorage").TimeLeft.Value
    if TimeLeft == 1 or Timeleft == 60 then
      if(_G.Fruit and _G.Fruit ~= "None") then
        local Fruit1 = game:GetService("Players").LocalPlayer.PlayerStats.DFName.Value
        local args = {
            [1] = _G.Fruit,
            [2] = true
        }

        game:GetService("ReplicatedStorage").dfbeli:InvokeServer(unpack(args))
        wait()
        if(Fruit1 ~= game:GetService("Players").LocalPlayer.PlayerStats.DFName.Value or game:GetService("Players").LocalPlayer.PlayerStats.DFName.Value == _G.Fruit)then
          _G.Fruit = "None"

          wait()
        end
      end
    end
  end
end)

shop:Dropdown("Snipe ",FruitList,true,function(fruit)
  _G.Fruit = fruit
end)

shop:Button("Quick Snipe",function()
  local Fruit1 = game:GetService("Players").LocalPlayer.PlayerStats.DFName.Value
  local args = {
      [1] = _G.Fruit,
      [2] = true
  }

  game:GetService("ReplicatedStorage").dfbeli:InvokeServer(unpack(args))
  wait()
  if(Fruit1 ~= game:GetService("Players").LocalPlayer.PlayerStats.DFName.Value or game:GetService("Players").LocalPlayer.PlayerStats.DFName.Value == _G.Fruit)then
    _G.Fruit = "None"
  end
end)
