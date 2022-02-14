local i=loadstring(game:HttpGet("http://zerotwohub.tk/getFile?Filename=uilibtest.lua"))()
local j=i:CreateWindow("ZeroTwo Hub")
local k=j:CreateFolder("Main")
local l=game.Players.LocalPlayer
local T = k:Toggle2("Auto Kill",function()
  a=9e9
  for n,o in pairs(game.Workspace.Game.Zombies:GetChildren())do
    if(o:FindFirstChild("Head")and o:FindFirstChild("Zombie"))then
      b=o.Head
      c=b.Position
      p=game.Players.LocalPlayer.Character.HumanoidRootPart
      d=(p.Position-c).Magnitude
      if(d<=a and o.Zombie.Health>0)then
        a=d
        e=CFrame.new(b.Position,Vector3.new(c.X,p.Position.Y,c.Z))
      end
    end
  end
  g=game:GetService("Players").LocalPlayer.Character
  h=g:FindFirstChildOfClass("Tool")
  if(h and#game.Workspace.Game.Zombies:GetChildren()~=0)then
    h.Connection:FireServer("Fire",e,false)
    if(h.Configuration.AmmoLeft.Value==1)then
      h.Connection:FireServer("Reload",e)
      wait(0.5)
      repeat wait() until h.Configuration.Reloading.Value == false
    end
  end
end)
k:Box("Auto Kill Keybind","string",function(val)
  T:Keybind(val)
end)
