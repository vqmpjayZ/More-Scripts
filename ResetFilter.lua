--Credits: heartasians
--I made support to ass executors

local function runScript()
    local TCS = game:GetService("TextChatService")
    local RStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer.PlayerGui
    local isLegacy = TCS.ChatVersion == Enum.ChatVersion.LegacyChatService
    local ChatBar = CoreGui:FindFirstChild("TextBoxContainer", true) or PlayerGui:FindFirstChild("Chat"):FindFirstChild("ChatBar", true)
    ChatBar = ChatBar:FindFirstChild("TextBox") or ChatBar

    local Chat = function(Message)
        if isLegacy then
            local ChatRemote = RStorage:FindFirstChild("SayMessageRequest", true)
            ChatRemote:FireServer(Message, "All")
        else
            local Channel = TCS.TextChannels.RBXGeneral
            Channel:SendAsync(Message)
        end
    end

    local Fake = function(Message)
        if isLegacy then
            Players:Chat(Message)
        else
            local Channel = TCS.TextChannels.RBXGeneral
            return
        end
    end

    local chars = {}
    for i = 97, 122 do chars[#chars + 1] = string.char(i) end
    for i = 65, 90 do chars[#chars + 1] = string.char(i) end

    local RNG = function(length)
        local str = ""
        for i = 1, length do
            str = str .. chars[math.random(#chars)]
        end
        return str
    end

    local ResetFilter = function()
        for i = 1, 10 do
            local GUID = RNG(30)
            local Filler = "bipas momen"
            local Reset = ("%s %s"):format(GUID, Filler)
            task.spawn(function()
                task.wait(0.01 * i)
                Fake(Reset)
            end)
        end
    end    

    local Connection = Instance.new("BindableFunction")

    for _, c in getconnections(ChatBar.FocusLost) do
        c:Disconnect()
    end

    ChatBar.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            Connection:Invoke(ChatBar.Text)
            ChatBar.Text = ""
        end
    end)

    Connection.OnInvoke = function(Message)
        Chat(Message)
        ResetFilter()
    end
end

local success, err = pcall(runScript)
if not success then
--    warn("Error occurred: " .. tostring(err) .. ". Trying without disconnecting handlers.") -- you can remove the "--" at this part if you want to get the print notification that it didint work on your executor.
    
    local function runScriptWithoutDisconnect()
        local TCS = game:GetService("TextChatService")
        local RStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local CoreGui = game:GetService("CoreGui")
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer.PlayerGui
        local isLegacy = TCS.ChatVersion == Enum.ChatVersion.LegacyChatService
        local ChatBar = CoreGui:FindFirstChild("TextBoxContainer", true) or PlayerGui:FindFirstChild("Chat"):FindFirstChild("ChatBar", true)
        ChatBar = ChatBar:FindFirstChild("TextBox") or ChatBar

        local Chat = function(Message)
            if isLegacy then
                local ChatRemote = RStorage:FindFirstChild("SayMessageRequest", true)
                ChatRemote:FireServer(Message, "All")
            else
                local Channel = TCS.TextChannels.RBXGeneral
                Channel:SendAsync(Message)
            end
        end

        local Fake = function(Message)
            if isLegacy then
                Players:Chat(Message)
            else
                local Channel = TCS.TextChannels.RBXGeneral
                return
            end
        end

        local chars = {}
        for i = 97, 122 do chars[#chars + 1] = string.char(i) end
        for i = 65, 90 do chars[#chars + 1] = string.char(i) end

        local RNG = function(length)
            local str = ""
            for i = 1, length do
                str = str .. chars[math.random(#chars)]
            end
            return str
        end

    local ResetFilter = function()
        for i = 1, 10 do
            local GUID = RNG(30)
            local Filler = "bipas momen"
            local Reset = ("%s %s"):format(GUID, Filler)
            task.spawn(function()
                task.wait(0.01 * i)
                Fake(Reset)
            end)
        end
    end    

        local Connection = Instance.new("BindableFunction")

        ChatBar.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                Connection:Invoke(ChatBar.Text)
                ChatBar.Text = ""
            end
        end)

        Connection.OnInvoke = function(Message)
            Chat(Message)
            ResetFilter()
        end
    end

    pcall(runScriptWithoutDisconnect)
end
