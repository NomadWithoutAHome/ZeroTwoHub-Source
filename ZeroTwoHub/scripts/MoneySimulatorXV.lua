library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/getFile?Filename=uilibtest.lua"))()
local w = library:CreateWindow("ZeroTwoHub")
local main = w:CreateFolder("Main")
local mining = w:CreateFolder("Mining")


main:Toggle2("Auto Farm",function()
game:GetService("ReplicatedStorage").GetMoney:FireServer("DropOn")
game:GetService("ReplicatedStorage").FillMoney:FireServer()
wait(0.1)
end)

main:Toggle2("Upgrade Power",function()
game:GetService("ReplicatedStorage").UpgradePower:FireServer()
wait(1)
end)

main:Toggle2("Upgrade Bag",function()
game:GetService("ReplicatedStorage").UpgradeBag:FireServer()
wait(1)
end)

main:Toggle2("Rank & Tier up",function()
game:GetService("ReplicatedStorage").UpgradeRank:FireServer()
game:GetService("ReplicatedStorage").TierUp:FireServer()
wait(5)
end)

main:Toggle2("More Money(gems)",function()
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("More money")
wait(1)
end)

main:Toggle2("Auto Buy Runes",function()
game:GetService("ReplicatedStorage").BuyRune:FireServer(1)
wait(1)
end)

main:Toggle2("Auto Rune Upgrades",function()
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("RuneLuck")
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("MoreClickPoints")
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("MoreMoney4")
wait(1)
end)

main:Toggle2("Claim Goals",function()
game:GetService("ReplicatedStorage").Goals:FireServer("Money")
game:GetService("ReplicatedStorage").Goals:FireServer("Time")
game:GetService("ReplicatedStorage").Goals:FireServer("Ores")
wait(1)
end)

main:Toggle2("Upgrade (Ores/Pumpkins)",function()
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("OreDamage")
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("CriticalChance")
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("MoreMoney5")
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("MoreGems")
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("MorePumpkins")
game:GetService("ReplicatedStorage").OreUpgrades:FireServer("CriticalBonus")
wait(2)
end)
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
  if(tonumber(str) and mult) then
    return tonumber(str)*mult or 9e9
  else
    return 9e9
  end
end
function getcurhealth(str)
  return parsenum(string.split(string.split(str,"[")[2],"/")[1])
end
local mode = "Balanced"
function miningfunc(this)
  local top,curhealth,minhealth = nil,0,0
  for i,v in pairs(game:GetService("Workspace").Ores:GetChildren()) do
    if(string.find(v.Name,this.GetName())) then --"SilverOre"
      if(mode == "MinHP") then
        curhealth = getcurhealth(v.Gui.HPBar.HP.Text)
        if(curhealth ~= nil and curhealth ~= 0) then
          if(curhealth < minhealth or minhealth == 0) then
            top = v
            minhealth = curhealth
          end
        end
      end
      if(mode == "Balanced") then
        curhealth = getcurhealth(v.Gui.HPBar.HP.Text)
        if(curhealth ~= nil and curhealth ~= 0) then
          curhealth = parsenum(v.Gui.HPBar.AmountReward.Text)/curhealth
          if(minhealth < curhealth or minhealth == 0) then
            top = v
            minhealth = curhealth
          end
        end
      end--mode
      if(mode == "BalancedV2") then
        curhealth = getcurhealth(v.Gui.HPBar.HP.Text)
        if(curhealth ~= nil and curhealth ~= 0) then
          damage = 1--gotta add damage calculations
          hits = curhealth/damage
          curhealth = parsenum(v.Gui.HPBar.AmountReward.Text)/hits
          if(minhealth < curhealth or minhealth == 0) then
            top = v
            minhealth = curhealth
          end
        end
      end--mode
    end
  end
  if(not top) then
    return warn("No top!")
  end
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (top.CFrame * CFrame.new(0,0,3)).Position+Vector3.new(0,5,0))
  wait(0.3)
  repeat
    fireclickdetector(top.ClickDetector)
    wait()
    curhealth = getcurhealth(top.Gui.HPBar.HP.Text)
  until curhealth == 0 or curhealth == nil
end
mining:Dropdown("Mining Modes",{"Balanced","MinHP","BalancedV2"},true,function(val)
  mode = val
end)
mining:Toggle2("Silver",miningfunc)
mining:Toggle2("Gold",miningfunc)
mining:Toggle2("Diamond",miningfunc)
mining:Toggle2("Ruby",miningfunc)
mining:Toggle2("Uranium",miningfunc)
mining:Toggle2("Gem",miningfunc)
mining:Toggle2("Obsidian",miningfunc)
mining:Toggle2("Kryptonite",miningfunc)
mining:Toggle2("Crystal",miningfunc)
mining:Toggle2("Pumpkin",miningfunc)
