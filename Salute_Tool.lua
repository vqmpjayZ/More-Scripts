--[[

     __   __   ______     _____     ______     __     ______   ______   ______    
    /\ \ / /  /\  __ \   /\  __-.  /\  == \   /\ \   /\  ___\ /\__  _\ /\  ___\   
    \ \ \'/   \ \  __ \  \ \ \/\ \ \ \  __<   \ \ \  \ \  __\ \/_/\ \/ \ \___  \  
     \ \__|    \ \_\ \_\  \ \____-  \ \_\ \_\  \ \_\  \ \_\      \ \_\  \/\_____\ 
      \/_/      \/_/\/_/   \/____/   \/_/ /_/   \/_/   \/_/       \/_/   \/_____/ 
                                   dsc.gg/vadriftz
]]

-- Basically an Roblox Script which gives you a tool that allows you to do the german Salute
-- Supports All Executors, Open Sourced, Works on R6 and R15, Works on all rig types
-- Credits: plague.1 (sorry bro it doesn't work obfuscated)

local SusTool = Instance.new("Tool")
SusTool.Name = "Salute\nOff"
SusTool.RequiresHandle = false
SusTool.ToolTip = "funny german guy"
SusTool.Parent = game.Players.LocalPlayer.Backpack

local activeAnimation

SusTool.Equipped:Connect(function()
    SusTool.Name = "Salute\nOn"
    local char = game.Players.LocalPlayer.Character
    local humanoid = char:WaitForChild("Humanoid")
    local description = humanoid:WaitForChild("HumanoidDescription")
    
    local animation = Instance.new("Animation")
    
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        animation.AnimationId = "rbxassetid://2524329075"
        activeAnimation = humanoid:LoadAnimation(animation)
        activeAnimation:Play()
        activeAnimation.Looped = true
        task.wait(0.01)
        activeAnimation:AdjustSpeed(0)
    else
        animation.AnimationId = "rbxassetid://176236333"
        activeAnimation = humanoid:LoadAnimation(animation)
        activeAnimation:Play()
        activeAnimation.Looped = true
        
        if description.LeftArm == 0 and description.RightArm == 0 and 
           description.LeftLeg == 0 and description.RightLeg == 0 and 
           description.Torso == 0 then
            task.wait(0.04)
        else
            task.wait(0.01)
        end
        activeAnimation:AdjustSpeed(0)
    end
end)

SusTool.Unequipped:Connect(function()
    SusTool.Name = "Salute\nOff"
    if activeAnimation then
        activeAnimation:Stop()
        activeAnimation = nil
    end
end)
