repeat wait() until game
repeat wait() until game:GetService("VirtualUser")
repeat wait() until game.Players.LocalPlayer

local VirtualUser=game:service'VirtualUser'
game:service('Players').LocalPlayer.Idled:connect(function()
  VirtualUser:CaptureController()
  VirtualUser:ClickButton2(Vector2.new())
end)





_G.Credits = {
  "Created by Ente_sama",
  ["Discord"] = "8ytFhuj"
}

local lp = game.Players.LocalPlayer

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mystikfluu/uilib/master/uilib.lua"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

stats = {
  "Strength",
  "Agility",
  "Cardio"
}

main:Toggle("Auto Stats",function(toggle)
  _G.AS = toggle
  while wait(0.1) and _G.AS do
    for i,v in pairs(stats) do
      local args = {
          [1] = "Level",
          [2] = v
      }
      game:GetService("ReplicatedStorage").Events.GlobalEvent:FireServer(unpack(args))
    end
  end
end)

main:Toggle("Auto Rebirth",function(toggle)
  _G.AR = toggle
  while wait(1) and _G.AR do
    local args = {
        [1] = "Rebirth"
    }
    game:GetService("ReplicatedStorage").Events.Global:InvokeServer(unpack(args))
  end
end)

main:Toggle("Kill Aura",function(toggle)
  _G.KA = toggle
  while wait() and _G.KA do
    for i,v in pairs(game.Players:GetPlayers()) do
      if(v.Character and v.Character:FindFirstChild("Humanoid") and v ~= lp) then
        if((v.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude <= 10) then
          local args = {
              [1] = "Damage",
              [2] = v.Character.Humanoid,
              [3] = v.Character.Humanoid.Health
          }
          game:GetService("ReplicatedStorage").Events.GlobalEvent:FireServer(unpack(args))
        end
      end
    end
  end
end)

main:Button("God Mode",function()
  game:GetService("Players").LocalPlayer.PlayerGui.Interactions.LocalScript.Disabled = true
  local args = {
      [1] = "Safezone",
      [2] = true
  }
  game:GetService("ReplicatedStorage").Events.Global:InvokeServer(unpack(args))
end)
