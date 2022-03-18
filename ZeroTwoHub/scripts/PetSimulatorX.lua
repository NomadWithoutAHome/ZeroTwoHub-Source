library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest.lua"))()
local w = library:CreateWindow("ZeroTwoHub")
local b = w:CreateFolder("AutoFarm")
local f = w:CreateFolder("AutoBuy")
local e = w:CreateFolder("Misc")

function RemoveTableDupes(tab)
	local hash = {}
	local res = {}
	for _,v in ipairs(tab) do
		if (not hash[v]) then
			res[#res+1] = v
			hash[v] = true
		end
	end
	return res
end

function equippedpets()
  local arr = {}
  for i,v in pairs(game.Players.LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets:GetChildren()) do
    if(v:FindFirstChild("Equipped")) then
      if(v.Equipped.Visible) then
        arr[#arr+1] = v
      end
    end
  end
  return arr
end

function ClosestPart()
    local dist = math.huge
    local target = nil
    for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
        if v.ClassName == "Folder" then
            if v:FindFirstChild("Coin") then
                if v.Coin.Transparency == 0 then
                    local magnitude = (v.Coin.Position - game:GetService("Players").LocalPlayer.Character.Head.Position).magnitude
                    if magnitude < dist then
                        dist = magnitude
                        target = v.Name
                    end
                end
            end
        end
    end
    return target
end


SelectedEgg = "Cracked"
Eggs = {}
succ,err = pcall(function()
  for i,v in pairs(game:GetService("ReplicatedStorage").Game.Eggs:GetChildren()) do
    Eggs[#Eggs+1] = "---"..v.Name.."---"
    for i2,v2 in pairs(v:GetChildren()) do
      str = string.gsub(v2.Name,"Egg","")
      str = string.gsub(str,"Golden","")
      str = string.gsub(str," ","")
      str = tostring(str)
      Eggs[#Eggs+1]= str
    end
  end
end)

Eggs = RemoveTableDupes(Eggs)


local acf1,acf2
acf1 = b:Toggle2("Auto Coin Farm ",function()
  acf2:Deactivate()
  for i,v in pairs(equippedpets()) do
    workspace.__THINGS.__REMOTES["join coin"]:InvokeServer({tostring(ClosestPart()),{tostring(v.Name)}})
    workspace.__THINGS.__REMOTES["farm coin"]:FireServer({tostring(ClosestPart()),tostring(v.Name)})
  end
end)

acf2 = b:Toggle2("Auto Coin TrashFarm",function()
  acf1:Deactivate()
  for i,v in pairs(game:GetService("Workspace")["__THINGS"].Pets:GetChildren()) do
      if v.ClassName == "Part" then
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace")["__THINGS"].Coins[ClosestPart()].Coin.CFrame.Position + Vector3.new(0,0,0))
          spawn(function()
              workspace.__THINGS.__REMOTES["join coin"]:InvokeServer({tostring(ClosestPart()),{tostring(v.Name)}})
              workspace.__THINGS.__REMOTES["farm coin"]:FireServer({tostring(ClosestPart()),tostring(v.Name)})
          end)
      end
  end
end)

b:Toggle2("AutoCollectDrop",function(bool)
  for i,v in pairs(game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()) do
      v.CanCollide = false
      v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,0)
  end
end)
f:Dropdown("Eggs",Eggs,true,function(a)
  SelectedEgg = a
end)
local golden = false
f:Toggle("Golden Egg",function(a)
  golden = a
end)

f:Toggle2("Buy Egg",function(bool)
  local egg = SelectedEgg.." Egg"
  if(golden) then
    egg = "Golden "..egg
  end
  workspace.__THINGS.__REMOTES["buy egg"]:InvokeServer({egg,false})
end)

repeat wait() until game.Workspace:FindFirstChild("__MAP")

f:Toggle2("Auto buy Areas",function()
  for i,v in pairs(game:GetService("Workspace")["__MAP"].Gates:GetChildren()) do

    local args = {
        [1] = {
            [1] = v.Name
        }
    }

    workspace.__THINGS.__REMOTES:FindFirstChild("buy area"):InvokeServer(unpack(args))
  end
end)

f:Toggle2("Auto buy Upgrades",function()
  for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Upgrades.Frame.Container.Holder:GetChildren()) do
    local args = {
        [1] = {
            [1] = v.Name
        }
    }

    workspace.__THINGS.__REMOTES:FindFirstChild("buy upgrade"):InvokeServer(unpack(args))
  end
end)

-- f:Toggle2("Auto gold/rainbow unequipped pets",function()
--   for i,v in pairs(game.Players.LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets:GetChildren()) do
--     if(v:FindFirstChild("Equipped")) then
--       if(not v.Equipped.Visible) then
--         game:GetService("Workspace")["__THINGS"]["__REMOTES"]["use golden machine"]:InvokeServer({{v.Name}})
--         game:GetService("Workspace")["__THINGS"]["__REMOTES"]["use rainbow machine"]:InvokeServer({{v.Name}})
--       end
--     end
--   end
-- end)

e:Dropdown("TP",game:GetService("Workspace")["__MAP"].Areas:GetChildren(),true,function(a)
  g = a:FindFirstChild("Floor") or a:FindFirstChild("Ground") or a:FindFIrstChildWhichIsA("BasePart")
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = g.CFrame + Vector3.new(0,30,0)
end)
