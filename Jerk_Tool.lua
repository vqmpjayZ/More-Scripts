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

local speaker = game.Players.LocalPlayer
local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
local backpack = speaker:FindFirstChildWhichIsA("Backpack")
if not humanoid or not backpack then return end

local function r15(speaker)
    return speaker.Character.Humanoid.RigType == Enum.HumanoidRigType.R15
end

local tool = Instance.new("Tool")
tool.Name = "Jerk Off"
tool.ToolTip = "in the stripped club. straight up \"jorking it\" . and by \"it\" , haha, well. let's just say. My peanits."
tool.RequiresHandle = false
tool.Parent = backpack

local jorkin = false
local track = nil

local function stopTomfoolery()
    jorkin = false
    if track then
        track:Stop()
        track = nil
    end
end

tool.Equipped:Connect(function() jorkin = true end)
tool.Unequipped:Connect(stopTomfoolery)
humanoid.Died:Connect(stopTomfoolery)

while task.wait() do
    if not jorkin then continue end

    local isR15 = r15(speaker)
    if not track then
        local anim = Instance.new("Animation")
        anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
        track = humanoid:LoadAnimation(anim)
    end

    track:Play()
    track:AdjustSpeed(isR15 and 0.7 or 0.65)
    track.TimePosition = 0.6
    task.wait(0.1)
    while track and track.TimePosition < (not isR15 and 0.65 or 0.7) do task.wait(0.1) end
    if track then
        track:Stop()
        track = nil
    end
end
