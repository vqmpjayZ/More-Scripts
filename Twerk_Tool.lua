--[[

     __   __   ______     _____     ______     __     ______   ______   ______    
    /\ \ / /  /\  __ \   /\  __-.  /\  == \   /\ \   /\  ___\ /\__  _\ /\  ___\   
    \ \ \'/   \ \  __ \  \ \ \/\ \ \ \  __<   \ \ \  \ \  __\ \/_/\ \/ \ \___  \  
     \ \__|    \ \_\ \_\  \ \____-  \ \_\ \_\  \ \_\  \ \_\      \ \_\  \/\_____\ 
      \/_/      \/_/\/_/   \/____/   \/_/ /_/   \/_/   \/_/       \/_/   \/_____/ 
                                   dsc.gg/vadriftz
]]

-- Basically an Roblox Script which gives you a tool that allows you to Twerk it
-- Supports All Executors, Open Sourced, Works on R15 ONLY, Works on all rig types

local SleepTool = Instance.new("Tool")
SleepTool.Name = "Twerk\nOff"
SleepTool.RequiresHandle = false
SleepTool.ToolTip = "Shake that ahh!1!"
SleepTool.Parent = game.Players.LocalPlayer.Backpack

local activeAnimation

SleepTool.Equipped:Connect(function()
    SleepTool.Name = "Twerk\nOn"
    local char = game.Players.LocalPlayer.Character
    local humanoid = char:WaitForChild("Humanoid")
    local description = humanoid:WaitForChild("HumanoidDescription")
    
    local animation = Instance.new("Animation")
    
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        animation.AnimationId = "rbxassetid://4686925579"
        activeAnimation = humanoid:LoadAnimation(animation)
        activeAnimation:Play()
        activeAnimation.Looped = true
        activeAnimation:AdjustSpeed(15)
    end
end)

SleepTool.Unequipped:Connect(function()
    SleepTool.Name = "Twerk\nOff"
    if activeAnimation then
        activeAnimation:Stop()
        activeAnimation = nil
    end
end)
