library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer


main:Toggle2("Auto Click",function()
  local args = {
      [1] = {
          ["manual"] = {
              ["9999999999999999999999999999"] = 100
          },
          ["bonus"] = {
              ["9999999999999999999999999999"] = 100
          }
      }
  }
  game:GetService("ReplicatedStorage").Events.Client.emitClicks:FireServer()
  game:GetService("ReplicatedStorage").Clicker2:InvokeServer(unpack(args))
  wait(1)
end)

main:Dropdown("TP",game:GetService("Workspace").Zones:GetChildren(),true,function(value)
  lp.Character.HumanoidRootPart.CFrame = value.teleport.CFrame + Vector3.new(0,5,0)
end)

main:Toggle2("Auto Rebirth",function()
  local args = {
      [1] = getgenv().rebirths or 250,
      [2] = false,
      [3] = false
  }

  game:GetService("ReplicatedStorage").Events.Client.requestRebirth:FireServer(unpack(args))
  wait(2)
end)

main:Box("Rebirth number","number",function(value)
  getgenv().rebirths = value or 250
end)
