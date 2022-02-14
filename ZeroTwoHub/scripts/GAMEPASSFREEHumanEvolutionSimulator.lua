local library = loadstring(game:HttpGet("http://193.83.159.126:3000/getFile?Filename=uilib.lua"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

local misc = window:CreateFolder("Misc")

main:Toggle("Auto Click",function(toggle)
  _G.AC = toggle
  while _G.AC do
    if lp.Backpack:FindFirstChildOfClass("Tool") then
      lp.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChildOfClass("Tool"))
    end
    wait()
    lp.Character:FindFirstChildOfClass("Tool").Main.RemoteFunction:InvokeServer()

  end
end)

main:Toggle("Auto Sell",function(toggle)
  _G.AS = toggle
  while _G.AS do
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(-41.2140923, 111.150909, 1211.49231, -0.430447906, 5.07076834e-08, 0.902615428, 3.80383938e-08, 1, -3.80385003e-08, -0.902615428, 1.79604474e-08, -0.430447906)
    wait(0.5)
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(39.3930016, 122.612991, 1250.16394) + Vector3.new(0, 10, 0)
    wait(4)
  end
end)

misc:Button("Claim Daily",function()
  for i,v in pairs(game:GetService("Workspace").Daily:GetChildren()) do
    lp.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 4, 0)
    wait(0.5)
  end
end)

main:Toggle("Auto Buy Weapon",function(toggle)
  _G.ABW = toggle
  local Buy = "\240\159\146\158\240\159\140\158\240\159\140\136\240\159\165\147\240\159\141\153\240\159\165\170\240\159\164\190\226\128\141\226\153\130\240\159\164\150"
  while _G.ABW and wait(0.3)do
    for i=2,50 do
      local args = {
          [1] = "Weapons",
          [2] = "Buy",
          [3] = i
      }

      game:GetService("ReplicatedStorage").Remotes[Buy]:FireServer(unpack(args))
    end
  end
end)

main:Toggle("Auto Buy Energy",function(toggle)
  _G.ABE = toggle
  local Buy = "\240\159\146\158\240\159\140\158\240\159\140\136\240\159\165\147\240\159\141\153\240\159\165\170\240\159\164\190\226\128\141\226\153\130\240\159\164\150"
  while _G.ABE and wait(0.3) do
    for i=2,50 do
      wait()
      local args = {
          [1] = "Energy",
          [2] = "Buy",
          [3] = i
      }

      game:GetService("ReplicatedStorage").Remotes[Buy]:FireServer(unpack(args))
    end
  end
end)

main:Toggle("Auto Buy Upgrade",function(toggle)
  _G.ABU = toggle
  local Buy = "\240\159\146\158\240\159\140\158\240\159\140\136\240\159\165\147\240\159\141\153\240\159\165\170\240\159\164\190\226\128\141\226\153\130\240\159\164\150"
  while _G.ABU and wait(0.3)do
    for i=2,50 do
      wait()
      local args = {
          [1] = "Upgrades",
          [2] = "Buy",
          [3] = i
      }

      game:GetService("ReplicatedStorage").Remotes[Buy]:FireServer(unpack(args))
    end
  end
end)

misc:Button("Unlock All Islands",function()
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(-75.8689728, 585.355652, 1229.59521)
  wait(0.5)
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(-75.8689728, 1268.85571, 1229.59521)
  wait(0.5)
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(-71.3927383, 2189.41772, 1225.44189)
  wait(0.5)
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(-72.4281921, 3013.9209, 1229.03625)
  wait(0.5)
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(-51.1896019, 4334.9751, 1250.99744)
  wait(0.5)
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(-48.0510139, 6537.78955, 1254.57471)
  wait(0.5)
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(-36.2226639, 9255.25195, 1256.17908)
  wait(0.5)
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(1.0940932, 13402.1895, 1262.34778)
  wait(0.5)
  lp.Character.HumanoidRootPart.CFrame = CFrame.new(15.7339277, 17017.6875, 1283.61389)
  wait(0.5)
end)

misc:Button("INF MultiJump",function()
  game:GetService("ReplicatedStorage").Players[lp.Name].Stats.Jumps.Value = 9999999999999
end)
