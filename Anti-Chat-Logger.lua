-- This script makes Roblox unable to log your chat messages sent in-game. Meaning if you get reported for saying something bad, you won't get banned! (TextChatService / Modern chat support)
-- Store the loadstring (line 5) in your autoexec folder into a text/lua file to receive automatic updates [remove the "--" part when you paste it into the text file]
-- Credits: AnthonyIsntHere, mask0502, heartasians

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anti-Chat-Logger.lua", true))()

-- (DD/MM/YY)
-- 7.7.2025 - Rewritten completley + new method for modern chat

-- NOTICE THAT IF YOU'RE MESSAGE IS REPORTED THROUGH THE 'Message Report' FEATURE ROBLOX RECENTLY IMPLEMENTED, YOU MIGHT GET BANNED AS ITS IMPOSSIBLE TO BYPASS
-- https://dsc.gg/vadriftz

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if _G.VadriftsACLLoaded then
    warn("Vadrift's ACL is already loaded.")
    return
end
_G.VadriftsACLLoaded = true

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

print("Loading Vadrift's Anti Chat & Screenshot Logger..")

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    local startTime = tick()

    local function showNotification(title, description, imageId)
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = title;
                Text = description;
                Icon = imageId;
                Duration = 15;
            })
        end)
    end

    showNotification("Vadrifts ACL", "Anti Chat & Screenshot Logger Loaded!", "rbxassetid://2541869220")
    print(string.format("ACL successfully loaded in %.2f seconds!", tick() - startTime))

    if setfflag then
        pcall(function()
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
        end)
    end

    local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    local spamText = "/e cheer"
    local isPlayingUserEmote = false

    local function getIdleAnimationId()
        local char = lp.Character
        if not char then return nil end
        local animate = char:FindFirstChild("Animate")
        if not animate then return nil end
        local idle = animate:FindFirstChild("idle")
        if not idle then return nil end
        local idleAnim1 = idle:FindFirstChild("Animation1")
        if idleAnim1 and idleAnim1:IsA("Animation") then
            return idleAnim1.AnimationId
        end
        local idleAnim2 = idle:FindFirstChild("Animation2")
        if idleAnim2 and idleAnim2:IsA("Animation") then
            return idleAnim2.AnimationId
        end
        return nil
    end

    task.spawn(function()
        while true do
            pcall(function()
                if isPlayingUserEmote then return end
                local char = lp.Character or lp.CharacterAdded:Wait()
                local animate = char:FindFirstChild("Animate")
                if not animate then return end
                local cheer = animate:FindFirstChild("cheer")
                if not cheer then return end
                local cheerAnim = cheer:FindFirstChild("CheerAnim")
                if not cheerAnim or not cheerAnim:IsA("Animation") then return end
                local idleAnimId = getIdleAnimationId()
                if idleAnimId and cheerAnim.AnimationId ~= idleAnimId then
                    cheerAnim.AnimationId = idleAnimId
                end
            end)
            task.wait(0.1)
        end
    end)

    local function setupChatHook()
        local chatBar
        local chat = playerGui:FindFirstChild("Chat")
        if chat then
            chatBar = chat:FindFirstChild("ChatBar", true)
        end
        if not chatBar then
            local container = CoreGui:FindFirstChild("TextBoxContainer", true)
            if container then
                chatBar = container:FindFirstChild("TextBox")
            end
        end
        if not chatBar then
            warn("❌ Could not find chat bar.")
            return
        end
        chatBar.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local msg = chatBar.Text:lower()
                if msg:match("^/e%s+[%w_]+") then
                    isPlayingUserEmote = true
                    task.spawn(function()
                        task.wait(3.5)
                        isPlayingUserEmote = false
                    end)
                end
            end
        end)
    end

    setupChatHook()

    RunService.Heartbeat:Connect(function()
        if isPlayingUserEmote then return end
        pcall(function()
            if channel then
                channel:SendAsync(spamText)
            end
        end)
    end)

    RunService.RenderStepped:Connect(function()
        if isPlayingUserEmote then return end
        pcall(function()
            if channel then
                channel:SendAsync(spamText)
            end
        end)
    end)

    task.spawn(function()
        local sayRemote = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
        while true do
            if not isPlayingUserEmote and sayRemote then
                pcall(function()
                    sayRemote:FireServer(spamText, "All")
                end)
            end
            task.wait(0.02)
        end
    end)

    task.wait(0.5)
    warn("Vadrift's modern chat anti chat logger may block the emote wheel and the cheer emote specifically from working. Use '/e' in chat when emoting.")
else
    if not pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anthony's%20ACL"))()
    end) then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anthony's%20ACL"))()
    end
    print("Anti Chat & Screenshot Logger Loaded!")
end

task.spawn(function()
    repeat
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        task.wait()
    until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
end)

wait(5)
print("https://dsc.gg/vadriftz")
