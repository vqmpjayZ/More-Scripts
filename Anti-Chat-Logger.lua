-- This script makes Roblox unable to log your chat messages sent in-game. Meaning if you get reported for saying something bad, you won't get banned! (TextChatService / Modern chat support)
-- Store the loadstring (line 5) in your autoexec folder into a text/lua file to receive automatic updates [remove the "--" part when you paste it into the text file]
-- Credits: AnthonyIsntHere

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anti-Chat-Logger.lua", true))()

--(DD/MM/YY)
--15.8.2024 - Rewritten (i was high when i was doing it before)
--3.9.2024 - Fixed Legacy and all bugs with it
--14.3.2025 - Fixed for roblox's new update

--https://dsc.gg/vadriftz

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

print("Loading Vadrift's Anti Chat & Screenshot Logger..")

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
        if StarterGui then
            StarterGui:SetCore("SendNotification", {
                Title = title;
                Text = description;
                Icon = imageId;
                Duration = 15;
            })
        end
    end
    
    local function executeScript()
        if hasExecuted.Value then
            showNotification("Vadrifts ACL", "Anti Chat & Screenshot Logger already loaded!", "rbxassetid://2541869220")
            print("Anti Chat Logger already loaded!")
            return
        end
        
        hasExecuted.Value = true
        local ACLloadTime = tick() - startTime
        showNotification("Vadrifts ACL", "Anti Chat & Screenshot Logger Loaded!", "rbxassetid://2541869220")
        print(string.format("Anti Chat Logger successfully loaded in %.2f seconds!", ACLloadTime))
        
        if setfflag then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
            end) -- anti-screenshot logger
        end

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

            ChatBar.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    local message = ChatBar.Text
                    ChatBar.Text = ""

                    if message and message ~= "" then
                        if message:sub(1, 1) == "/" then
                            local Channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                            if Channel then
                                Channel:SendAsync(message)
                            end
                        else
                            local Channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                            if Channel then
                                Channel:SendAsync(message)
                            end
                        end
                    end
                end
            end)
        else
            warn("Could not find ChatBar")
        end
    end
    
    wait(0.21)
    executeScript()
    
    task.spawn(function()
        if StarterGui then
            repeat
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
                task.wait()
            until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
        end
    end)
else
    -- Credits: AnthonyIsntHere
    if not pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anthony's%20ACL"))() end) then
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
