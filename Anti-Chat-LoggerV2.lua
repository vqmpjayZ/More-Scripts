-- Vadrift's 'Anti Chat Logger v2' is designed to work on all executors (Including the bad ones!)! The script is detected and can get you banned in banwaves, it is NOT reccommended to put this into your auto-exec file.

-- This script makes Roblox unable to log your chat messages sent in-game. Meaning if you get reported for saying something bad, you won't get banned! (TextChatService / Modern chat support)
-- Store the loadstring (line 5) in your autoexec folder into a text/lua file to receive automatic updates [remove the "--" part when you paste it into the text file]
-- Credits: AnthonyIsntHere

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/refs/heads/main/Anti-Chat-LoggerV2.lua", true))()
-- Original: loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anti-Chat-Logger.lua", true))()

--https://dsc.gg/vadriftz



-- PROBABLY DISCONTINUED
if not game:IsLoaded() then
    game.Loaded:Wait()
end

print("Loading Vadrift's Anti Chat & Screenshot Logger..")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

local features = {
    setflag = type(setfflag) == "function",
    request = type(request) == "function" or type(http) == "table" and type(http.request) == "function" or type(syn) == "table" and type(syn.request) == "function",
    hookfunction = type(hookfunction) == "function" or type(replaceclosure) == "function",
    newcclosure = type(newcclosure) == "function" or type(protect_function) == "function"
}

local function safehook(func, newfunc)
    if type(hookfunction) == "function" then
        return hookfunction(func, newfunc)
    elseif type(replaceclosure) == "function" then
        return replaceclosure(func, newfunc)
    end
    return func
end

local function safeprotect(func)
    if type(newcclosure) == "function" then
        return newcclosure(func)
    elseif type(protect_function) == "function" then
        return protect_function(func)
    end
    return func
end

local function saferequest(url)
    local content = nil
    
    if type(request) == "function" then
        local response = request({Url = url, Method = "GET"})
        if response and response.Body then content = response.Body end
    elseif type(http) == "table" and type(http.request) == "function" then
        local response = http.request({Url = url, Method = "GET"})
        if response and response.Body then content = response.Body end
    elseif type(syn) == "table" and type(syn.request) == "function" then
        local response = syn.request({Url = url, Method = "GET"})
        if response and response.Body then content = response.Body end
    elseif type(game.HttpGet) == "function" then
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        if success then content = result end
    end
    
    return content
end

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    local hasExecuted = LocalPlayer:FindFirstChild("HasExecuted")
    if not hasExecuted then
        hasExecuted = Instance.new("BoolValue")
        hasExecuted.Name = "HasExecuted"
        hasExecuted.Value = false
        hasExecuted.Parent = LocalPlayer
    end

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

    local function executeScript()
        if hasExecuted.Value then
            showNotification("Vadrifts ACL", "Anti Chat & Screenshot Logger already loaded!", "rbxassetid://2541869220")
            print("Anti Chat Logger already loaded!")
            return
        end
        
        hasExecuted.Value = true
        local ACLloadTime = tick() - startTime

        if features.setflag then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
            end)
        end
        
        if features.hookfunction then
            pcall(function()
                local oldReportAbuse = safehook(Players.ReportAbuse, safeprotect(function(self, player, reason, description)
                    return oldReportAbuse(self, player, reason, "")
                end))
            end)
        end

        local function AntiChatLog(message)
            if message:sub(1, 2) == "/e" or message:sub(1, 2) == "/w" then
                return message
            else
                return " ְ" .. message
            end
        end

        pcall(function()
            TextChatService.OnIncomingMessage = function(message)
                local modifiedMessage = AntiChatLog(message.Text)
                message.Text = modifiedMessage
            end
        end)
        
        if features.hookfunction then
            pcall(function()
                local mainChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if mainChannel then
                    local oldSendAsync = safehook(mainChannel.SendAsync, safeprotect(function(self, message, ...)
                        return oldSendAsync(self, AntiChatLog(message), ...)
                    end))
                end
            end)
        end

        showNotification("Vadrifts ACL", "Anti Chat & Screenshot Logger Loaded!", "rbxassetid://2541869220")
        print(string.format("Anti Chat Logger successfully loaded in %.2f seconds!", ACLloadTime))
        wait(5)
        print("https://dsc.gg/vadriftz")
    end

    wait(0.21)
    executeScript()
else
    local function loadAnthonyACL()
        local success = false
        
        local aclScript = saferequest("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anthony's%20ACL")
        
        if aclScript then
            success = pcall(function()
                loadstring(aclScript)()
                print("https://dsc.gg/vadriftz")
            end)
        end
        
        if not success then
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local ChatRemote = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
            
            if ChatRemote and features.hookfunction then
                pcall(function()
                    local oldChatRemote = safehook(ChatRemote.FireServer, safeprotect(function(self, message, ...)
                        message = message .. " "
                        return oldChatRemote(self, message, ...)
                    end))
                end)
            end
        end
    end
    
    loadAnthonyACL()
print("Anti Chat & Screenshot Logger Loaded!")
end

task.spawn(function()
    repeat
        pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end)
        task.wait()
    until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
end)
