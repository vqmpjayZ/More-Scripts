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
