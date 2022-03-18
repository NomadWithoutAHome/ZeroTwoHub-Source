_G.Credits = {
  "Created by Code002Lover",
  ["Discord"] = "8ytFhuj"
}
local marketplaceService = game:GetService("MarketplaceService")
function getname(id)
  return marketplaceService:GetProductInfo(id, Enum.InfoType.Asset).Name
end
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mystikfluu/uilib/master/uilib.lua"))()
local window = library:CreateWindow(getname(game.PlaceId))
local clicking = window:CreateFolder("Clicking")
local pets = window:CreateFolder("Pets")
pets:Toggle("Hatch tripple eggs", function(toggle)
  _G.tripple = toggle
end)
pets:Box("Hatch for whom?", "string", function(value)
  _G.player = game.Players:FindFirstChild(value) or game:GetService("Players").LocalPlayer
end)
local eggs1 = game.Workspace.Keys:GetChildren()
local eggs = {}
for i, v in pairs(eggs1) do
  eggs[#eggs + 1] = v.Name
end
pets:Dropdown("Eggs", eggs, true, function(value)
  _G.egg = value or "Common"
end)
pets:Toggle("Hatch", function(toggle)
  _G.hatch = toggle
  spawn(function()
    while wait() and _G.hatch do
    local args = {
      [1] = "plsnohackplsnoooooob",
      [2] = _G.player or game:GetService("Players").LocalPlayer,
      [3] = _G.egg or "Common",
      [4] = _G.tripple or false,
      [5] = "",
      [6] = "",
      [7] = ""
    }
    game:GetService("ReplicatedStorage").KeyBind:InvokeServer(unpack(args))
  end
end)
end)
clicking:Box("Clicks per wait", "int", function(value)
if(value < 1) then return false end
if(value > 50) then
  game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
    Text = "If you have more than 50 Clicks per wait you might time out."; --The chat message
    Color = Color3.fromRGB(255, 0, 0); --Chat message color, defaults to white
    Font = Enum.Font.SourceSansBold; --Chat message font, defaults to SourceSansBold
    TextSize = 18 --Text size, defaults to 18
  });
end
if(value > 5000) then
  game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
    Text = "If you have more than 5000 Clicks per wait you might crash, setting it back to 25."; --The chat message
    Color = Color3.fromRGB(255, 0, 0); --Chat message color, defaults to white
    Font = Enum.Font.SourceSansBold; --Chat message font, defaults to SourceSansBold
    TextSize = 18 --Text size, defaults to 18
  });
  value = 25;
end
_G.cps = value or 10
end)
clicking:Toggle("Auto-Clicker", function(toggle)
_G.ac = toggle
spawn(function()
  while _G.ac and wait() do
  local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Coin") or game.Players.LocalPlayer.Character:FindFirstChild("Coin")
  game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
  for i = 0, _G.cps or 10 do
    tool:Activate()
  end
end
end)
end)
function complete()
if(game.Players.LocalPlayer.Character == nil) then
return false
end
if(game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") == nil) then
return false
end
if(game.Players.LocalPlayer.Character.Humanoid.Health == 0) then
return false
end
repeat
wait()
until iswindowactive()
repeat
if(game.Players.LocalPlayer.PlayerGui:FindFirstChild("Minigames") == nil) then return false end
local AP = game.Players.LocalPlayer.PlayerGui.Minigames.Frame.Obby.Play.AbsolutePosition
local X, Y = AP.X, AP.Y
mousemoveabs(X, Y)
mouse1click()
wait()
X, Y = 570, 670
mousemoveabs(X, Y)
mouse1click()
wait()
X, Y = 380, 450
mousemoveabs(X, Y)
mouse1click()
wait()
until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Minigames") == nil or _G.autoobby == false
wait(0.1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.ObbyIsland.FinishObby.CFrame
end
function opengui()
if(game.Players.LocalPlayer.Character == nil) then
return false
end
if(game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") == nil) then
return false
end
if(game.Players.LocalPlayer.Character.Humanoid.Health == 0) then
return false
end
repeat
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace["Main Island"].Shop.Minigames.HitPart.Hitbox.CFrame
until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Minigames") or _G.autoobby == false
return true
end

local tokens = window:CreateFolder("Tokens")
tokens:Toggle("Auto Obby", function(toggle)
_G.autoobby = toggle
spawn(function()
coroutine.wrap(function()
while wait(3) and _G.autoobby do
  if(game.Players.LocalPlayer.Character) then
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
  end
end
coroutine.yield()
end)
while _G.autoobby do
opengui()
complete()
wait()
end
end)
end)

local MoonCoins = window:CreateFolder("MoonCoins")

MoonCoins:Toggle("Teleport MoonCoins",function(toggle)

  _G.MBTC = toggle

  local Coins = game.Workspace.MoonCoins
  local Boxes = game.Workspace.MoonBoxes

  while wait() and _G.MBTC do
    for i, v in pairs(Coins:GetChildren()) do
      if(v.Name ~= "Collect") then
        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
      end
    end
    for i, v in pairs(Boxes:GetChildren()) do
      if(v.Name ~= "Collect") then
        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
      end
    end
  end

end)
