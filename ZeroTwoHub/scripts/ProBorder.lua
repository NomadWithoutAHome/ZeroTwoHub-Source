library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

if(lp.PlayerGui:FindFirstChild("LoadingScreen")) then
  lp.PlayerGui.LoadingScreen.Enabled = false
end --)

main:Toggle2("Remove Wanted",function()
  if(lp.Character.Head.Overhead.Container:FindFirstChild("Clearance")) then
    lp.Character.Head.Overhead.Container.Clearance:Destroy()
  end
end)


-- fireproximityprompt(game:GetService("Workspace").Keycard.Handle.ProximityPrompt,0)
-- made by ente confirmed
-- 25.12.2021, ente: Ente
--attempt to call a nil value?! NAZE
-- it doesnt even work lmao
--[[
main:Toggle2("Auto quest?",function()
  for i,v in ipairs(game:GetService("Workspace")["Interactable Tasks"]["Facility Maintenance Tasks"]["Transport Boxes"]:GetChildren()) do
    if(v:IsA("Folder")) then
      --omg yes folder me harder daddy
      for i2,v2 in ipairs(v:GetChildren()) do
        fireproximityprompt(v2.ProximityPrompt,0)
      end
    end
  end
end)
]]--
