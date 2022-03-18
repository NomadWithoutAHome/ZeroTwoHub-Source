library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

function touch(part)
  if(type(part) == "table") then
    for i,v in pairs(part) do
      touch(v)
      game:GetService("RunService").RenderStepped:Wait()
    end
  else
    if(part:IsA("BasePart")) then
      if(part.Transparency ~= 1 and part:FindFirstChildOfClass("TouchTransmitter")) then
        firetouchinterest(part,lp.Character.HumanoidRootPart,0)
        game:GetService("RunService").Stepped:Wait()
        firetouchinterest(part,lp.Character.HumanoidRootPart,1)
      end
    end
    if(part:IsA("Folder") or part:IsA("Model")) then
      touch(part:GetChildren())
    end
  end
  return true
end

--[[

get all special stats(on earth not in separate games),
auto farm orpiment,
get silver board if you have orpiment (takes all attainable normal stats to get silver board) walkspeed,
fly,
and teleport

]]--

main:Button("Buy All",function()

  for j,k in pairs(game:GetService("Workspace").Areas["#1 | Grasslands"].Buttons:GetChildren()) do
    touch(k.ButtonPart)
    print(k.InfoGUI.Give.Text)
  end
  -- for i,v in pairs(game:GetService("Workspace").Areas:GetChildren()) do
  --   if(v:FindFirstChild("Buttons")) then
  --     for j,k in pairs(v.Buttons:GetChildren()) do
  --       touch(k.ButtonPart)
  --       print(k.InfoGUI.Give.Text)
  --     end
  --   end
  -- end
end)
