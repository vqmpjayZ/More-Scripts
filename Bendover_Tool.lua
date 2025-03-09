--[[

     __   __   ______     _____     ______     __     ______   ______   ______    
    /\ \ / /  /\  __ \   /\  __-.  /\  == \   /\ \   /\  ___\ /\__  _\ /\  ___\   
    \ \ \'/   \ \  __ \  \ \ \/\ \ \ \  __<   \ \ \  \ \  __\ \/_/\ \/ \ \___  \  
     \ \__|    \ \_\ \_\  \ \____-  \ \_\ \_\  \ \_\  \ \_\      \ \_\  \/\_____\ 
      \/_/      \/_/\/_/   \/____/   \/_/ /_/   \/_/   \/_/       \/_/   \/_____/ 
                                   dsc.gg/vadriftz
]]

-- Basically an Roblox Script which gives you a tool that allows you to bend over.
-- Supports All Executors, Open Sourced, Works on R6 and R15, Works on all rig types

local SleepTool = Instance.new("Tool")
SleepTool.Name = "Bend Over\nOff"
SleepTool.RequiresHandle = false
SleepTool.ToolTip = "Bend Over"
SleepTool.Parent = game.Players.LocalPlayer.Backpack

local b={} local c={} local _={ID=0;Type="Animation";Properties={Name="Sleep";AnimationId="http://www.roblox.com/asset/?id=4686925579"};Children={{ID=1;Type="NumberValue";Properties={Name="ThumbnailBundleId";Value=515};Children={}};{ID=2;Type="NumberValue";Properties={Name="ThumbnailKeyframe";Value=13};Children={}};{ID=3;Type="NumberValue";Properties={Name="ThumbnailZoom";Value=1.1576576576577};Children={}};{ID=4;Type="NumberValue";Properties={Name="ThumbnailHorizontalOffset";Value=-0.0025025025025025};Children={}};{ID=5;Type="NumberValue";Properties={Name="ThumbnailVerticalOffset";Value=-0.0025025025025025};Children={}};{ID=6;Type="NumberValue";Properties={Name="ThumbnailCharacterRotation"};Children={}}}} local function a(d,_)local e=Instance.new(d.Type) if(d.ID)then local _=c[d.ID] if(_)then _[1][_[2]]=e c[d.ID]=nil else b[d.ID]=e end end for _,d in pairs(d.Properties)do if(type(d)=="string")then local a=tonumber(d:match("^_R:(%w+)_$")) if(a)then if(b[a])then d=b[a]else c[a]={e,_} d=nil end end end e[_]=d end for _,_ in pairs(d.Children)do a(_,e)end e.Parent=_ return e end

create=function()return a(_,nil)end

local savedAnimate
local activeTrack

SleepTool.Equipped:Connect(function()
    SleepTool.Name = "Bend Over\nOn"
    local character = game.Players.LocalPlayer.Character
    local humanoid = character:WaitForChild("Humanoid")
    
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        savedAnimate = character:FindFirstChild("Animate"):Clone()
        local animation = create()
        local animate = character:WaitForChild("Animate")
        local bindable = animate:WaitForChild("PlayEmote")
        bindable:Invoke(animation)
		for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do if track.Animation.AnimationId:match("4686925579") then track:AdjustSpeed(0) break end end
        task.wait(0.6)
        animate:Destroy()
    else
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://189854234"
        activeTrack = humanoid:LoadAnimation(animation)
        activeTrack:Play()
        task.wait(0.6)
        activeTrack:AdjustSpeed(0)
    end
end)

SleepTool.Unequipped:Connect(function()
    SleepTool.Name = "Bend Over\nOff"
    local character = game.Players.LocalPlayer.Character
    
    if activeTrack then
        activeTrack:Stop()
        activeTrack = nil
    end
    
    if savedAnimate then
        local oldAnimate = character:FindFirstChild("Animate")
        if oldAnimate then
            oldAnimate:Destroy()
        end
        local newAnimate = savedAnimate:Clone()
        newAnimate.Parent = character
        savedAnimate = nil
    end
end)
