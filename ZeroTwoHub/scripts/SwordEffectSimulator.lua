repeat wait() until game
repeat wait() until game.Players
repeat wait() until game.Players.LocalPlayer

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mystikfluu/uilib/master/uilib.lua"))()
local w = library:CreateWindow("Sword Effect Simulator")
local main = w:CreateFolder("Main")
main:Toggle("Instant Heal (nearly godmode)", function(value)
  _G.godmode = value
end)
main:Toggle("Grind Power", function(value)
  _G.grind = value
  _G.count = _G.count or 8
  while wait() and _G.grind do
    local lp = game:GetService("Players").LocalPlayer
    local chars = lp.Character
    local tool = chars:FindFirstChild("sword") or lp.Backpack:FindFirstChild("sword")
    if(tool and tool:FindFirstChild("Handle")) then
    if(tool.Handle:FindFirstChild("up")) then
      if(tool.Handle.up:FindFirstChild("RemoteEvent")) then
        local RE = tool.Handle.up.RemoteEvent
        for a=1,_G.count do
          RE:FireServer()
        end
      end
    end
    end
  end

end)
main:Box("Power Thingy", "int", function(value)
  _G.count = value or 8
end)

main:Box("Effect name", "string", function(value)
  for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
    if(v:IsA("RemoteEvent")) then
      v:FireServer(value)
    end
  end
end)
main:Box("Speed", "Number", function(value)
  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value or 16
end)
main:Box("JumpPower", "Number", function(value)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = value or 52
end)
main:Button("Kill ALL you can kill(not yet:tm:)", function()
print("never :tm:")
end)


if(_G.godmodecon) then
  _G.godmodecon:Disconnect()
end
_G.godmodecon = game:GetService("RunService").RenderStepped:Connect(function()
  if(_G.godmode) then
  game.ReplicatedStorage.Heal:FireServer()
  end
end)
if(_G.charcon) then
  _G.charcon:Disconnect()
end
if(_G.humcon) then
  _G.humcon:Disconnect()
end
_G.humcon = game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function()
  if(_G.godmode) then
  game.ReplicatedStorage.Heal:FireServer()
  end
end)
_G.charcon = game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
_G.humcon = char.Humanoid.Changed:Connect(function()
  if(_G.godmode) then
  game.ReplicatedStorage.Heal:FireServer()
  end
end)
end)
