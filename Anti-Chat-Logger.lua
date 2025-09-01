-- This script makes Roblox unable to log your chat messages sent in-game. Meaning if you get reported for saying something bad, you won't get banned! (TextChatService / Modern chat support)
-- Store the loadstring (line 5) in your autoexec folder into a text/lua file to receive automatic updates [remove the "--" part when you paste it into the text file]
-- Credits: AnthonyIsntHere

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anti-Chat-Logger.lua", true))()
-- REMEMBER THAT IF YOU'RE MESSAGE IS REPORTED THROUGH THE 'Message Report' FEATURE ROBLOX IMPLEMENTED, YOU MIGHT GET BANNED AS ITS IMPOSSIBLE TO FULLY BYPASS (currently no reports about getting banned with vadrifts though)

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

local function showNotification(title, description)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = description;
            Icon = "rbxassetid://2541869220";
            Duration = 10;
        })
    end)
end

if _G.VadriftsACLLoaded then
    showNotification("Vadrifts ACL", "Anti Chat & Screenshot Logger Loaded!")
    return
end
_G.VadriftsACLLoaded = true

print("Loading Vadrift's Anti Chat & Screenshot Logger..")

if setfflag then
    pcall(function()
        setfflag("AbuseReportScreenshot", "False")
        setfflag("AbuseReportScreenshotPercentage", "0")
    end)
end

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    local spamText = "/e cheer"
    local isEmoting = false
    local connections = {}
    
    local function isCharacterR15()
        local character = lp.Character
        if not character then return false end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        return humanoid and humanoid.RigType == Enum.HumanoidRigType.R15
    end
    
    local function getIdleAnimationId()
        local character = lp.Character
        if not character then return nil end
        
        local animate = character:FindFirstChild("Animate")
        if not animate then return nil end
        
        local idle = animate:FindFirstChild("idle")
        if not idle then return nil end
        
        for _, child in pairs(idle:GetChildren()) do
            if child:IsA("Animation") then
                return child.AnimationId
            end
        end
        return nil
    end
    
    local function replaceCheerAnimation()
        if not isCharacterR15() then return end
        
        local character = lp.Character
        if not character then return end
        
        local animate = character:FindFirstChild("Animate")
        if not animate then return end
        
        local cheer = animate:FindFirstChild("cheer")
        if not cheer then return end
        
        local cheerAnim = cheer:FindFirstChild("CheerAnim")
        if not cheerAnim or not cheerAnim:IsA("Animation") then return end
        
        local idleAnimId = getIdleAnimationId()
        if idleAnimId and cheerAnim.AnimationId ~= idleAnimId then
            cheerAnim.AnimationId = idleAnimId
        end
    end
    
    local function setupEmoteDetection(character)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if not humanoid then return end
        
        local connection = humanoid.AnimationPlayed:Connect(function(animationTrack)
            local animId = animationTrack.Animation.AnimationId
            local animate = character:FindFirstChild("Animate")
            if not animate then return end
            
            local isDefaultAnim = false
            local defaultFolders = {"idle", "walk", "run", "jump", "fall", "climb", "sit", "swimidle", "swim", "toolnone"}
            
            for _, folderName in pairs(defaultFolders) do
                local folder = animate:FindFirstChild(folderName)
                if folder then
                    for _, child in pairs(folder:GetChildren()) do
                        if child:IsA("Animation") and child.AnimationId == animId then
                            isDefaultAnim = true
                            break
                        end
                    end
                end
                if isDefaultAnim then break end
            end
            
            if not isDefaultAnim then
                isEmoting = true
                animationTrack.Stopped:Connect(function()
                    isEmoting = false
                end)
            end
        end)
        
        table.insert(connections, connection)
    end
    
    local function antiChatLog(message)
        if message:sub(1, 1) == "/" then
            return message
        else
            return "ּ" .. message
        end
    end
    
    local function findChatBar()
        local chat = playerGui:FindFirstChild("Chat")
        if chat then
            local chatBar = chat:FindFirstChild("ChatBar", true)
            if chatBar then return chatBar end
        end
        
        local container = CoreGui:FindFirstChild("TextBoxContainer", true)
        if container then
            return container:FindFirstChild("TextBox")
        end
        
        return nil
    end
    
    local function setupChatHook()
        local chatBar = findChatBar()
        if not chatBar then
            warn("Could not find chat bar")
            return
        end
        
        for _, connection in pairs(getconnections and getconnections(chatBar.FocusLost) or {}) do
            if connection.Disable then
                connection:Disable()
            elseif connection.Disconnect then
                connection:Disconnect()
            end
        end
        
        local connection = chatBar.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local message = chatBar.Text
                chatBar.Text = ""
                
                if message and message ~= "" and channel then
                    local modifiedMessage = antiChatLog(message)
                    channel:SendAsync(modifiedMessage)
                end
            end
        end)
        
        table.insert(connections, connection)
    end
    
    local function startSpamming()
        if isEmoting then return end
        
        pcall(function()
            if channel then
                channel:SendAsync(spamText)
            end
        end)
        
        local sayRemote = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
        if sayRemote then
            pcall(function()
                sayRemote:FireServer(spamText, "All")
            end)
        end
        
        local defaultChatRemote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if defaultChatRemote then
            local sayMessageRequest = defaultChatRemote:FindFirstChild("SayMessageRequest")
            if sayMessageRequest then
                pcall(function()
                    sayMessageRequest:FireServer(spamText, "All")
                end)
            end
        end
    end
    
    local function onCharacterAdded(character)
        isEmoting = false
        setupEmoteDetection(character)
        
        task.wait(0.5)
        replaceCheerAnimation()
    end
    
    lp.CharacterAdded:Connect(onCharacterAdded)
    if lp.Character then
        onCharacterAdded(lp.Character)
    end
    
    setupChatHook()
    
    local heartbeatConnection = RunService.Heartbeat:Connect(startSpamming)
    table.insert(connections, heartbeatConnection)
    
    local renderSteppedConnection = RunService.RenderStepped:Connect(startSpamming)
    table.insert(connections, renderSteppedConnection)
    
    task.spawn(function()
        while _G.VadriftsACLLoaded do
            if not isEmoting then
                startSpamming()
            end
            task.wait()
        end
    end)
    
    task.spawn(function()
        while _G.VadriftsACLLoaded do
            if not isEmoting then
                startSpamming()
            end
            task.wait()
        end
    end)
    
    task.spawn(function()
        while _G.VadriftsACLLoaded do
            if not isEmoting then
                pcall(function()
                    if channel then
                        for i = 1, 5 do
                            channel:SendAsync(spamText)
                        end
                    end
                end)
            end
            task.wait(0.01)
        end
    end)
    
    task.spawn(function()
        while _G.VadriftsACLLoaded do
            if not isEmoting then
                pcall(function()
                    if channel then
                        for i = 1, 3 do
                            channel:SendAsync(spamText)
                        end
                    end
                    local sayRemote = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
                    if sayRemote then
                        for i = 1, 3 do
                            sayRemote:FireServer(spamText, "All")
                        end
                    end
                end)
            end
            task.wait(0.005)
        end
    end)
    
    task.spawn(function()
        while _G.VadriftsACLLoaded do
            if isCharacterR15() and not isEmoting then
                replaceCheerAnimation()
            end
            task.wait(0.1)
        end
    end)
    
    task.spawn(function()
        local emoteError = '<font color="#f74b52">You can\'t use Emotes here.</font>'
        
        local function removeEmoteError(obj)
            if obj:IsA("TextLabel") and obj.Text == emoteError then
                if isCharacterR15() and not isEmoting then
                    local msg = obj:FindFirstAncestor("TextMessage")
                    if msg then
                        msg:Destroy()
                    end
                end
            end
        end
        
        CoreGui.DescendantAdded:Connect(removeEmoteError)
        for _, obj in pairs(CoreGui:GetDescendants()) do
            removeEmoteError(obj)
        end
    end)
    
    showNotification("Vadrifts ACL", "Anti Chat & Screenshot Logger Loaded!")
    print("Vadrift's Anti Chat & Screenshot Logger successfully Loaded!")
    
else
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anthony's%20ACL"))() --thanks anthony
    end)
end

task.spawn(function()
    repeat
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        task.wait()
    until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
end)
