--[[
A Roblox Multi-Purpose tool hat protects the Server (FE) you're in from Basic Roblox Chat Bans and constantly spams invisible un-logged messages to automatically Stop False Chat Message Tagging.
Put the loadstring (line 5) in your auto-exec folder to instantly get updated!:

loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anti-Chat-Logger.lua", true))()
    __   __   ______     _____     ______     __     ______   ______   ______    
    /\ \ / /  /\  __ \   /\  __-.  /\  == \   /\ \   /\  ___\ /\__  _\ /\  ___\   
    \ \ \'/   \ \  __ \  \ \ \/\ \ \ \  __<   \ \ \  \ \  __\ \/_/\ \/ \ \___  \  
     \ \__|    \ \_\ \_\  \ \____-  \ \_\ \_\  \ \_\  \ \_\      \ \_\  \/\_____\ 
      \/_/      \/_/\/_/   \/____/   \/_/ /_/   \/_/   \/_/       \/_/   \/_____/ 

]]

local StartTime = tick()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local function ShowNotification(title, description)
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
    ShowNotification("Vadrifts ACL", "LogFlood & ResetFilter Already Loaded!")
    return
end
_G.VadriftsACLLoaded = true

print("Loading Vadrifts Logs Flooder & ResetFilter Bypass...")

--[[

██╗░░░░░░█████╗░░█████╗░██████╗░██╗███╗░░██╗░██████╗
██║░░░░░██╔══██╗██╔══██╗██╔══██╗██║████╗░██║██╔════╝
██║░░░░░██║░░██║███████║██║░░██║██║██╔██╗██║██║░░██╗
██║░░░░░██║░░██║██╔══██║██║░░██║██║██║╚████║██║░░╚██╗
███████╗╚█████╔╝██║░░██║██████╔╝██║██║░╚███║╚██████╔╝██╗██╗
╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝╚═╝
]]

if setfflag then
    pcall(function()
        setfflag("GetFFlagVoiceAbuseReportsEnabled", "False")
    end) -- NOT TESTED (lmk tho)
end

if not CoreGui:FindFirstChild("DevConsoleMaster") then
task.spawn(function()
        pcall(function()
            TextChatService.TextChannels.RBXGeneral:SendAsync("/console")
        end)
    end)
end

wait(.1)

local DevConsole = CoreGui.DevConsoleMaster
local DevConsoleWindow = DevConsole.DevConsoleWindow
local DevConsoleUI = DevConsoleWindow.DevConsoleUI
local CloseButton = DevConsoleUI.TopBar.CloseButton

if DevConsoleUI:FindFirstChild("MainView") and not DevConsoleUI:FindFirstChild("MainView_Copy") then
    local NewMainView = DevConsoleUI.MainView:Clone()
    NewMainView.Visible = false
    NewMainView.Name = "MainView_Copy"
    NewMainView.Parent = DevConsoleUI
end

if not DevConsoleUI:FindFirstChild("MainView") then
    TextChatService.TextChannels.RBXGeneral:SendAsync("/console")
    wait(.1)
    local NewMainView = DevConsoleUI.MainView:Clone()
    NewMainView.Visible = false
    NewMainView.Name = "MainView_Copy"
    NewMainView.Parent = DevConsoleUI
end
HiddingConsole = false
LeavingConsoleOpen = false

task.spawn(function()task.wait(.6) DevConsoleWindow.Visible = false end)
task.spawn(function()
    while true do
        pcall(function()
            if LeavingConsoleOpen then
                DevConsoleWindow.Visible = true
            elseif HiddingConsole then
                DevConsoleWindow.Visible = false
            end
        end)
        task.wait(0.03)
    end
end)

pcall(function()
    CloseButton.MouseButton1Click:Connect(function()
        LeavingConsoleOpen = false
        HiddingConsole = true
        pcall(function()
            DevConsoleWindow.Visible = false
        end)
    end)
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.F9 then
        if HiddingConsole or (not LeavingConsoleOpen and not HiddingConsole) then
            LeavingConsoleOpen = true
            HiddingConsole = false
        else
            LeavingConsoleOpen = false
            HiddingConsole = true
        end
    end
end)

TextChatService.OnIncomingMessage = function(message)
    if message.TextSource and message.TextSource.UserId == lp.UserId then
        local text = message.Text:lower()
        if text == "/console" or text:sub(1,9) == "/console " then
            if HiddingConsole or (not LeavingConsoleOpen and not HiddingConsole) then
                LeavingConsoleOpen = true
                HiddingConsole = false
            else
                LeavingConsoleOpen = false
                HiddingConsole = true
            end
        end
    end
end

--[[

███╗░░░███╗███████╗████████╗██╗░░██╗░█████╗░██████╗░  ░░███╗░░
████╗░████║██╔════╝╚══██╔══╝██║░░██║██╔══██╗██╔══██╗  ░████║░░
██╔████╔██║█████╗░░░░░██║░░░███████║██║░░██║██║░░██║  ██╔██║░░ -- ACL: Logs flooding (FE)
██║╚██╔╝██║██╔══╝░░░░░██║░░░██╔══██║██║░░██║██║░░██║  ╚═╝██║░░ -- Floods logs by constantly spamming "/console" in chat
██║░╚═╝░██║███████╗░░░██║░░░██║░░██║╚█████╔╝██████╔╝  ███████╗
╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░╚═════╝░  ╚══════╝
]]

local function GenerateCleanString(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local lesstagschanceig = {"fu", "shi", "tf", "ki", "bl"}
    local result = ""
    
    for i = 1, length do
        local RandomIndex = math.random(1, #chars)
        result = result .. string.sub(chars, RandomIndex, RandomIndex)
    end
    
    for _, word in pairs(lesstagschanceig) do
        result = string.gsub(result:lower(), word, "x")
    end
    
    return result
end

local string = GenerateCleanString(8)
local uwunyaa = "/console ".. string

local function CreateSpamChannels()
    for i = 1, 3 do
        pcall(function()
            TextChatService:AddChannel("SpamChannel"..i)
         end)
    end
end
CreateSpamChannels()

local function TextChatSpammer()
    while true do
        pcall(function()
            TextChatService.TextChannels["SpamChannel"..math.random(1,3)]:SendAsync(uwunyaa)
        end)
        task.wait(0.03)
    end
end

task.spawn(TextChatSpammer)

-----------------------------------------------------------------------------------------------------------------------------
---
--[[
 
███╗░░░███╗███████╗████████╗██╗░░██╗░█████╗░██████╗░  ██████╗░
████╗░████║██╔════╝╚══██╔══╝██║░░██║██╔══██╗██╔══██╗  ╚════██╗
██╔████╔██║█████╗░░░░░██║░░░███████║██║░░██║██║░░██║  ░░███╔═╝ -- ACL: Chat Modification (CLIENT ONLY)
██║╚██╔╝██║██╔══╝░░░░░██║░░░██╔══██║██║░░██║██║░░██║  ██╔══╝░░ -- Modifies your Message so that it doesn't get saved to logs.
██║░╚═╝░██║███████╗░░░██║░░░██║░░██║╚█████╔╝██████╔╝  ███████╗
╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░╚═════╝░  ╚══════╝
]]

local function AntiChatLog(message)
    if message:sub(1, 2) == "/e" then
        return message
    else
        return "ּ" .. message
    end
end

TextChatService.OnIncomingMessage = function(message)
local modifiedMessage = AntiChatLog(message.Text)
    message.Text = modifiedMessage
end

-----------------------------------------------------------------------------------------------------------------------------
local LoadTime = string.format("%.2f", tick() - StartTime)
ShowNotification("Vadrifts ACL", "Log Flood & ResetFilter Loaded in ".. LoadTime .."s")
print("Vadrifts LogsFlooder & ResetFilter Loaded in ".. LoadTime .."s!")

task.spawn(function()
    repeat
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        task.wait()
    until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
end) -- spawn chat
