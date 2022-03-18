library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

main:Toggle2("Auto Attack",function()
  mh,top = 9e9,nil
  for i,v in pairs(game.workspace.__AREAS.Spawn:GetChildren()) do
    if(v:FindFirstChildOfClass("MeshPart") and v:FindFirstChildOfClass("MeshPart"):FindFirstChild("Health") and (v:FindFirstChildOfClass("MeshPart").Health.Value < mh or mh == 9e9 or mh<=0) and v:FindFirstChildOfClass("MeshPart").Health.Value>=0) then
      mh=v:FindFirstChildOfClass("MeshPart").Health.Value
      top=v
    end
  end
  local args = {
      [1] = top,
      [2] = game:GetService("Workspace")["__CLIENT"]["__PLAYER"][lp.Name]:FindFirstChildOfClass("Model")
  }

  game:GetService("ReplicatedStorage").__REMOTES.__Cannon_Attack:FireServer(unpack(args))
end)
