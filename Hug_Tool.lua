--[[

     __   __   ______     _____     ______     __     ______   ______   ______    
    /\ \ / /  /\  __ \   /\  __-.  /\  == \   /\ \   /\  ___\ /\__  _\ /\  ___\   
    \ \ \'/   \ \  __ \  \ \ \/\ \ \ \  __<   \ \ \  \ \  __\ \/_/\ \/ \ \___  \  
     \ \__|    \ \_\ \_\  \ \____-  \ \_\ \_\  \ \_\  \ \_\      \ \_\  \/\_____\ 
      \/_/      \/_/\/_/   \/____/   \/_/ /_/   \/_/   \/_/       \/_/   \/_____/ 
                                   dsc.gg/vadriftz
]]

-- Basically an Roblox Script which gives you a tool that allows you to 'Hug'/Kiss
-- Supports All Executors, Open Sourced, Works on R6 ONLY, Works on all rig types

HugTool = Instance.new("Tool")
HugTool.Name = "Hug Tool\nOff"
HugTool.RequiresHandle = false
HugTool.ToolTip = "Hug Tool R6"
HugTool.Parent = game.Players.LocalPlayer.Backpack

HugTool.Equipped:Connect(function()
HugTool.Name = "Hug Tool\nOn"
Anim_1 = Instance.new("Animation")
Anim_1.AnimationId = "rbxassetid://283545583"
Play_1 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim_1)
Anim_2 = Instance.new("Animation")
Anim_2.AnimationId = "rbxassetid://225975820"
Play_2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim_2)
Play_1:Play()
Play_2:Play()
end)

HugTool.Unequipped:Connect(function()
HugTool.Name = "Hug Tool\nOff"
Play_1:Stop()
Play_2:Stop()
end)
