-- This script makes Roblox unable to log your chat messages sent in-game. Meaning if you get reported for saying something bad, you won't get banned! (TextChatService / Modern chat support)
-- Store the loadstring (line 5) in your autoexec folder into a text/lua file to receive automatic updates [remove the "--" part when you paste it into the text file]
-- Credits: AnthonyIsntHere, mask0502, heartasians

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anti-Chat-Logger.lua", true))()

-- (DD/MM/YY)
-- 7.7.2025 - Rewritten completley + new method for modern chat
-- 14.7.2025 - Fixed 99% emotes not working + emote wheel emotes + any commands that weren't /e or /w + added support to games where the user is not a humanoid + put the dsc print into a task.spawn(function()

-- NOTICE THAT IF YOU'RE MESSAGE IS REPORTED THROUGH THE 'Message Report' FEATURE ROBLOX RECENTLY IMPLEMENTED, YOU MIGHT GET BANNED AS ITS IMPOSSIBLE TO FULLY BYPASS
-- https://dsc.gg/vadriftz

if not game:IsLoaded() then
    game.Loaded:Wait()
end
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
    task.wait(0.21)
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

    if _G.VadriftsACLLoaded then
        showNotification("Vadrifts ACL", "Anti Chat & Screenshot Logger already loaded!", "rbxassetid://2541869220")
        print("Anti Chat Logger already loaded!")
        return
    end
    _G.VadriftsACLLoaded = true

    showNotification("Vadrifts ACL", string.format("Anti Chat & Screenshot Logger Loaded in %.2fs!", tick() - startTime), "rbxassetid://2541869220")
    print(string.format("Semi Anti Chat Logger successfully loaded in %.2f seconds!", tick() - startTime))

    if setfflag then
        pcall(function()
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
        end) --anti screenshot logger
    end

    --anti chat logger code
    local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    local spamText = "/e cheer"
    local isPlayingEmote = false
    local useTextMethod = false
    local hasCharacterWithHumanoid = false

    if not _G.VadriftsACLConnections then
        _G.VadriftsACLConnections = {}
    end

    local function checkCharacterType()
        local char = lp.Character
        if char and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChild("Animate") then
            hasCharacterWithHumanoid = true
        else
            hasCharacterWithHumanoid = false
        end
    end

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

    local function isEmoteAnimation(animationTrack)
        local char = lp.Character
        if not char then return false end
        local animate = char:FindFirstChild("Animate")
        if not animate then return false end
        
        local animId = animationTrack.Animation.AnimationId
        
        local defaultAnimations = {
            "idle", "walk", "run", "jump", "fall", "climb", "sit", "swimidle", "swim"
        }
        
        for _, animType in pairs(defaultAnimations) do
            local animFolder = animate:FindFirstChild(animType)
            if animFolder then
                for _, child in pairs(animFolder:GetChildren()) do
                    if child:IsA("Animation") and child.AnimationId == animId then
                        return false
                    end
                end
            end
        end
        
        local toolFolder = animate:FindFirstChild("toolnone")
        if toolFolder then
            for _, child in pairs(toolFolder:GetChildren()) do
                if child:IsA("Animation") and child.AnimationId == animId then
                    return false
                end
            end
        end
        
        return true
    end

    local function setupEmoteDetection(character)
        local humanoid = character:WaitForChild("Humanoid")
        if humanoid then
            humanoid.AnimationPlayed:Connect(function(animationTrack)
                if isEmoteAnimation(animationTrack) then
                    isPlayingEmote = true
                    useTextMethod = true
                    
                    animationTrack.Stopped:Connect(function()
                        isPlayingEmote = false
                        useTextMethod = false
                    end)
                end
            end)
        end
    end

    lp.CharacterAdded:Connect(function(character)
        checkCharacterType()
        isPlayingEmote = false
        useTextMethod = false
        setupEmoteDetection(character)
    end)
    
    if lp.Character then
        checkCharacterType()
        setupEmoteDetection(lp.Character)
    end

    task.spawn(function()
        while _G.VadriftsACLLoaded do
            if hasCharacterWithHumanoid and not useTextMethod then
                pcall(function()
                    local char = lp.Character
                    if not char then return end
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
            end
            task.wait(0.1)
        end
    end)

    local function AntiChatLog(message)
        if message:sub(1, 1) == "/" then
            return message
        else
            return "ּ" .. message
        end
    end

    local function setupChatHook()
        if hasCharacterWithHumanoid then
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
                warn("Could not find chat bar.")
                return
            end
            local connection = chatBar.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    local message = chatBar.Text
                    
                    if useTextMethod then
                        chatBar.Text = ""
                        if message and message ~= "" then
                            local modifiedMessage = AntiChatLog(message)
                            if channel then
                                channel:SendAsync(modifiedMessage)
                            end
                        end
                    end
                end
            end)
            table.insert(_G.VadriftsACLConnections, connection)
        else
            local ChatBar
            local function findChatBar()
                local textBoxContainer = CoreGui:FindFirstChild("TextBoxContainer", true)
                if textBoxContainer then
                    return textBoxContainer:FindFirstChild("TextBox") or textBoxContainer
                end
                return nil
            end
            
            ChatBar = findChatBar()
            
            if ChatBar then
                local success, err = pcall(function()
                    for _, c in pairs(getconnections(ChatBar.FocusLost)) do
                        c:Disconnect()
                    end
                end)
                
                local connection = ChatBar.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        local message = ChatBar.Text
                        ChatBar.Text = ""
                        
                        if message and message ~= "" then
                            local modifiedMessage = AntiChatLog(message)
                            local Channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                            if Channel then
                                Channel:SendAsync(modifiedMessage)
                            end
                        end
                    end
                end)
                table.insert(_G.VadriftsACLConnections, connection)
            else
                warn("Could not find ChatBar")
            end
        end
    end

    setupChatHook()

    local heartbeatConnection = RunService.Heartbeat:Connect(function()
        if not hasCharacterWithHumanoid or useTextMethod then return end
        pcall(function()
            if channel then
                channel:SendAsync(spamText)
            end
        end)
    end)
    table.insert(_G.VadriftsACLConnections, heartbeatConnection)

    local renderSteppedConnection = RunService.RenderStepped:Connect(function()
        if not hasCharacterWithHumanoid or useTextMethod then return end
        pcall(function()
            if channel then
                channel:SendAsync(spamText)
            end
        end)
    end)
    table.insert(_G.VadriftsACLConnections, renderSteppedConnection)

    task.spawn(function()
        local sayRemote = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
        while _G.VadriftsACLLoaded do
            if hasCharacterWithHumanoid and sayRemote and not useTextMethod then
                pcall(function()
                    sayRemote:FireServer(spamText, "All")
                end)
            end
            task.wait(0.04)
        end
    end)

    task.spawn(function()
        local emoteErr = '<font color="#f74b52">You can\'t use Emotes here.</font>'
        local function onDescendantAdded(obj)
            if not _G.VadriftsACLLoaded then return end
            if obj:IsA("TextLabel") and obj.Text == emoteErr then
                if hasCharacterWithHumanoid and not useTextMethod then
                    local msg = obj:FindFirstAncestor("TextMessage")
                    if msg then
                        msg:Destroy()
                    end
                end
            end
        end

        for _, obj in ipairs(CoreGui:GetDescendants()) do
            onDescendantAdded(obj)
        end
        CoreGui.DescendantAdded:Connect(onDescendantAdded)
    end)
else
    if not pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anthony's%20ACL"))() --by AnthonyIsntHere
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

task.spawn(function()
    task.wait(5)
    print("https://dsc.gg/vadriftz")
end)
