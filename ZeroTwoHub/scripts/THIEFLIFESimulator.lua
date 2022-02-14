repeat wait() until game
repeat wait() until game:GetService("VirtualUser")
repeat wait() until game.Players.LocalPlayer

if(_G.hub == nil or _G.hub == false) then return false end

local VirtualUser=game:service'VirtualUser'
game:service('Players').LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
_G.Credits = {
  "Created by Code002Lover & Ente",
  ["Discord"] = "vQBYBsvWhW"
}
local marketplaceService = game:GetService("MarketplaceService")
local lp = game.Players.LocalPlayer

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mystikfluu/uilib/master/uilib.lua"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local LootUI = game:GetService("Players").LocalPlayer.PlayerGui.LootGUI.LootWindow.Loot

function sellall()
  game:GetService("ReplicatedStorage").Events.Player.RequestViewBackpack:FireServer()
  for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.ViewBackpack.LootWindow:GetChildren()) do
    if(not v:IsA("LocalScript")) then
      v.Visible = false
    end
  end
  count = 0
  for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.ViewBackpack.LootWindow.Backpack:GetChildren()) do
    if(not v:FindFirstChild("isWeapon")) then
      count = count + 1
      game:GetService("ReplicatedStorage").Events.Shop.RequestSellItem:FireServer(i-1)
    end
  end
  game:GetService("Players").LocalPlayer.PlayerGui.SellGUI.Enabled = false
end

function pickup(id)
  local args = {
      [1] = id
  }
  game:GetService("ReplicatedStorage").Events.Loot.RequestPickUp:FireServer(unpack(args))
end

function getloot()
  return LootUI:GetChildren()
end

function requestloot(id)
  local args = {
      [1] = id
  }
  game:GetService("ReplicatedStorage").Events.Loot.RequestLoot:FireServer(unpack(args))
end

main:Toggle("Auto Sell",function(toggle)
  _G.AS = toggle
  while wait(0.1) and _G.AS do
    sellall()
  end
end)

main:Toggle("Auto collect loot",function(toggle)
  _G.ACL = toggle
  while wait() and _G.ACL do
    for i,v in pairs(getloot()) do
      if(tonumber(v.Name)) then
        pickup(v.Name)
        print(v.Name)
      end
      game:GetService("Workspace").Camera.Blur.Enabled = false
      game:GetService("Workspace").Camera.Blur.Size = 0
    end
  end
end)

main:Toggle("Auto Open loot",function(toggle)
  _G.AOL = toggle
  while wait() and _G.AOL do
    game:GetService("Players").LocalPlayer.PlayerGui.LootGUI.Enabled = false
    for i,v in pairs(game:GetService("Workspace").Loot.Places:GetChildren()) do
      if(v:FindFirstChild("Hitbox")) then
        if((v.Hitbox.Position - lp.Character.HumanoidRootPart.Position).Magnitude <= 30) then
          requestloot(v.Name)
        end
      end
    end
  end
end)

main:Toggle("Auto open loot (tp)",function(toggle)
  _G.AOLTP = toggle
  while wait() and _G.AOLTP do
    game:GetService("Players").LocalPlayer.PlayerGui.LootGUI.Enabled = false
    for i,v in pairs(game:GetService("Workspace").Loot.Places:GetChildren()) do
      if(v:FindFirstChild("Hitbox") and _G.AOLTP) then
        repeat
          lp.Character.HumanoidRootPart.CFrame = v.Hitbox.CFrame
          wait()
          requestloot(v.Name)
          wait()
        until #getloot() == 1 or #getloot() == 0 or _G.AOLTP == false
      end
    end
  end
end)
