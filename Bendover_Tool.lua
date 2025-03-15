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

local b = {}
local c = {}
local _ = {
    ID = 0;
    Type = "Animation";
    Properties = {
        Name = "Sleep";
        AnimationId = "http://www.roblox.com/asset/?id=4686925579"
    };
    Children = {
        {ID = 1; Type = "NumberValue"; Properties = {Name = "ThumbnailBundleId"; Value = 515}; Children = {}};
        {ID = 2; Type = "NumberValue"; Properties = {Name = "ThumbnailKeyframe"; Value = 13}; Children = {}};
        {ID = 3; Type = "NumberValue"; Properties = {Name = "ThumbnailZoom"; Value = 1.1576576576577}; Children = {}};
        {ID = 4; Type = "NumberValue"; Properties = {Name = "ThumbnailHorizontalOffset"; Value = -0.0025025025025025}; Children = {}};
        {ID = 5; Type = "NumberValue"; Properties = {Name = "ThumbnailVerticalOffset"; Value = -0.0025025025025025}; Children = {}};
        {ID = 6; Type = "NumberValue"; Properties = {Name = "ThumbnailCharacterRotation"}; Children = {}}
    }
}

local function a(d, _)
    local e = Instance.new(d.Type)
    if (d.ID) then
        local _ = c[d.ID]
        if (_) then
            _[1][_[2]] = e
            c[d.ID] = nil
        else
            b[d.ID] = e
        end
    end
    for _, d in pairs(d.Properties) do
        if (type(d) == "string") then
            local a = tonumber(d:match("^_R:(%w+)_$"))
            if (a) then
                if (b[a]) then
                    d = b[a]
                else
                    c[a] = {e, _}
                    d = nil
                end
            end
        end
        e[_] = d
    end
    for _, _ in pairs(d.Children) do
        a(_, e)
    end
    e.Parent = _
    return e
end

local create = function()
    return a(_, nil)
end

local savedAnimate
local activeTrack
local isPlaying = false

local function getCharacterAndHumanoid()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if not character then return nil, nil end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return character, humanoid
end

local function playBendOverAnimation()
    local character, humanoid = getCharacterAndHumanoid()
    if not character or not humanoid then return end
    
    SleepTool.Name = "Bend Over\nOn"

    if character:FindFirstChild("Animate") then
        savedAnimate = character.Animate:Clone()
    end
    
    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        local animation = create()
        local animate = character:WaitForChild("Animate")
        local bindable = animate:WaitForChild("PlayEmote")
        
        bindable:Invoke(animation)
        
        task.spawn(function()
            task.wait(0.1)
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do 
                if track.Animation.AnimationId:match("4686925579") then 
                    track:AdjustSpeed(0)
                    activeTrack = track
                    break 
                end
            end
        end)
        
        task.wait(0.3)
        if character:FindFirstChild("Animate") then
            character.Animate:Destroy()
        end
    else

        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://189854234"
        activeTrack = humanoid:LoadAnimation(animation)
        activeTrack:Play()
        task.wait(0.3)
        activeTrack:AdjustSpeed(0)
    end
    
    isPlaying = true
end

local function restoreOriginalAnimation()
    local character, humanoid = getCharacterAndHumanoid()
    if not character then return end
    
    SleepTool.Name = "Bend Over\nOff"
    
    if activeTrack then
        activeTrack:Stop()
        activeTrack = nil
    end
    
    if savedAnimate and character then
        local oldAnimate = character:FindFirstChild("Animate")
        if oldAnimate then
            oldAnimate:Destroy()
        end
        
        local newAnimate = savedAnimate:Clone()
        newAnimate.Parent = character
        savedAnimate = nil
    end
    
    isPlaying = false
end

SleepTool.Equipped:Connect(function()
    if not isPlaying then
        local success, err = pcall(playBendOverAnimation)
        if not success then
            warn("Error playing bend over animation:", err)
            restoreOriginalAnimation()
        end
    end
end)

SleepTool.Unequipped:Connect(function()
    if isPlaying then
        local success, err = pcall(restoreOriginalAnimation)
        if not success then
            warn("Error restoring animation:", err)
        end
    end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    savedAnimate = nil
    activeTrack = nil
    isPlaying = false
    SleepTool.Name = "Bend Over\nOff"
end)
