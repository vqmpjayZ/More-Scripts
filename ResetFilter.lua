--original by heartasians

--Update logs (DD/MM/YY):
--5.5.2024 - Made it work (at this time heartasians script wasnt working)
--11.8.2024 - Added support to Solara and similar executors
--15.11.2024 - Fixed all issues

repeat task.wait() until game:IsLoaded()

local TCS = game:GetService("TextChatService")
local CoreGui = game:GetService("CoreGui")
local RStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

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
    end
end

local chars = {}
for i=97,122 do chars[#chars+1]=string.char(i) end
for i=65,90 do chars[#chars+1]=string.char(i) end

local RNG = function(length)
    local str = ""
    for i = 1, length do
        str = str .. chars[math.random(#chars)]
    end
    return str
end

local ResetFilter = function()
    for i = 1, 10 do
        local GUID = RNG(i)
        local Filler = "i love asians so much"
        local Reset = ("%s %s"):format(GUID, Filler)
        task.spawn(function()
            Fake(Reset)
        end)
    end
end

local Connection = Instance.new("BindableFunction")

local oldConnection = ChatBar.FocusLost
ChatBar.FocusLost = Instance.new("BindableEvent").Event

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
