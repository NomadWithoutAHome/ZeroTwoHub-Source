library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest.lua"))()
local w = library:CreateWindow("ZeroTwoHub")
local b = w:CreateFolder("AutoFarm")


b:Toggle2("Swing",function()
  if(game:GetService("Players").LocalPlayer.Backpack:FindFirstChildOfClass("Tool")) then
    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChildOfClass("Tool"))
  end
  game:GetService("ReplicatedStorage").Events.Clicked:FireServer()
  game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").RemoteClick:FireServer()
  wait(0.2)
end)
b:Toggle2("Sell",function()
  game:GetService("ReplicatedStorage").Events.Sell:FireServer()
  wait(0.2)
end)
b:Toggle2("Buy Swords",function()
  game:GetService("ReplicatedStorage").Events.BuyAll:FireServer("Swords")
  wait(5)
end)
b:Toggle2("Buy Backpacks",function()
  game:GetService("ReplicatedStorage").Events.BuyAll:FireServer("Backpacks")
  wait(5)
end)
b:Toggle2("Buy Classes",function()
  buynext=false
  for i,v in pairs(game:GetService("ReplicatedStorage").ShopItems.Classes:GetChildren()) do
    if(buynext) then
      game:GetService("ReplicatedStorage").Events.BuyItem:FireServer(v)
      buynext=false
      break
    end
    if(v.Name == game.Players.LocalPlayer.leaderstats.Class.Value) then
      buynext = true
    end
  end
  wait(1)
end)


--[[


game:GetService("ReplicatedStorage").Events.Clicked:FireServer()
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").RemoteClick:FireServer()
game:GetService("ReplicatedStorage").Events.Sell:FireServer()
game:GetService("ReplicatedStorage").Events.BuyAll:FireServer("Swords")
game:GetService("ReplicatedStorage").Events.BuyAll:FireServer("Backpacks")


]]
