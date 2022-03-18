library = library or _G.library or loadstring(game:HttpGet("http://zerotwohub.tk/uilibtest"))()
local window = library:CreateWindow("ZeroTwo Hub")
local main = window:CreateFolder("Main")

local lp = game.Players.LocalPlayer

main:Toggle2("Spam light",function()
  game:GetService("Players").LocalPlayer.Character:FindFirstChild("Advanced Flashlight").Remote:FireServer("ToggleLight")
end)
local distance = 3
main:Toggle2("TP behind saba",function()

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.saba_373.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,distance)

end)

main:Box("Distance","int",function(v)
distance = v
end)
