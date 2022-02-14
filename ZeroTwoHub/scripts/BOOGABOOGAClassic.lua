library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/getFile?Filename=uilibtest.lua"))()
local w = library:CreateWindow("ZeroTwoHub")
local main = w:CreateFolder("Chest Dupe")
local item = w:CreateFolder("Item Dupe")
local misc = w:CreateFolder("Misc")
local lp = game.Players.LocalPlayer

function mag(part)
  if(lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and part:IsA("BasePart")) then
    return (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
  else
    return 0
  end
end

main:Toggle2("Pickup",function(this)
  for i,v in pairs(game.Workspace:GetChildren()) do
    if(v:FindFirstChild("Pickup") and v:FindFirstChild("PickupProximityPrompt") and this:IsOn()) then
      if(mag(v) < v.PickupProximityPrompt.MaxActivationDistance*2) then
        fireproximityprompt(v.PickupProximityPrompt)
        wait(0.1)
      end
    end
  end
end)
local Item = "Essence Chest"
local price = 100000
main:Box("Chest","string",function(val)
  if(not string.find(val,"Chest")) then val = val .. " Chest" end
  Item = val
end)

main:Toggle2("Dupe Chest",function()
  amount = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.MainGui.LeftPanel.Shop.Lists.ChestList:FindFirstChild(Item).Quantity.Text) - 0.000000001
  game:GetService("ReplicatedStorage").Events.SubmitTrade:FireServer(Item, amount, price)
  wait(1)
  repeat
    game:GetService("ReplicatedStorage").Events.ChestDrop:FireServer(Item)
    wait(1)
  until tonumber(game:GetService("Players").LocalPlayer.PlayerGui.MainGui.LeftPanel.Shop.Lists.ChestList:FindFirstChild(Item).Quantity.Text) ~= amount
  for i,v in pairs(game.Players.LocalPlayer.PlayerGui.MainGui.RightPanel.Market.List:GetChildren()) do
    if(v:FindFirstChild("From")) then
      if(string.find(v.From.Text,game.Players.LocalPlayer.Name)) then
        game:GetService("ReplicatedStorage").Events.AcceptTrade:FireServer(v.OfferId.Value)
      end
    end
  end
  wait(1.5)
end)
local Item2 = "Goober Bag"
local amount2 = 1.1
local price2 = 100000
item:Box("Item","string",function(val)
  Item2 = val
end)
item:Toggle2("Dupe",function()
  repeat
    count = 0
    for i=1,3 do
      game:GetService("ReplicatedStorage").Events.SubmitTrade:FireServer(Item2, amount2, price2)
      wait(1.5)
    end
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui.MainGui.RightPanel.Market.List:GetChildren()) do
      if(v:FindFirstChild("From")) then
        if(string.find(v.From.Text,game.Players.LocalPlayer.Name)) then
          count = count + 1
        end
      end
    end
    wait()
  until count == 3
  game:GetService("ReplicatedStorage").Events.DropBagItem:FireServer(Item2)
  count = 0
  repeat
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui.MainGui.RightPanel.Market.List:GetChildren()) do
      if(v:FindFirstChild("From")) then
        if(string.find(v.From.Text,game.Players.LocalPlayer.Name)) then
          count = count + 1
          game:GetService("ReplicatedStorage").Events.AcceptTrade:FireServer(v.OfferId.Value)
          wait(0.5)
          for i=1,3 do
            game:GetService("ReplicatedStorage").Events.DropBagItem:FireServer(Item2)
            wait(1)
          end
        end
      end
    end
    wait()
    print("cancel",count)
  until count == 3
  count = 0
  repeat
    for i,v in pairs(game.Workspace:GetChildren()) do
      if(v:FindFirstChild("Pickup") and v:FindFirstChild("PickupProximityPrompt")) then
        if(mag(v) < v.PickupProximityPrompt.MaxActivationDistance and v.Name == Item2 and count ~= 4) then
          fireproximityprompt(v.PickupProximityPrompt)
          count = count + 1
          wait(0.5)
        end
      end
    end
    wait()
  until count == 4
  wait(1)
end)
local item3;
misc:Box("Item Name","string",function(val)
item3 = val
end)
misc:Toggle2("Drop",function()
game:GetService("ReplicatedStorage").Events.DropBagItem:FireServer(item3)
wait(0.2)
end)
