--reworked someone elses script that stopped working randomly (omaka skid!!!11)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/vqmpjayZ/Arrayfield/refs/heads/main/Arrayfield.lua'))()
local Window = Rayfield:CreateWindow({
    Name = "Tsunami Game｜dsc.gg/vadriftz｜Vadrifts",
   LoadingTitle = "Welcome user " .. game.Players.LocalPlayer.Name,
	LoadingSubtitle = "dsc.gg/vadriftz // Tsunami game",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DefaultConfig"
    }
})
local Home = Window:CreateTab("Home", 11433532654)
local Discord = Home:CreateSection("▶ Discord", true)

local playerName = game.Players.LocalPlayer.Name

Home:CreateButton({
    Name = "Welcome " .. playerName .. ", updates n stuff @ our discord",
Interact = "Copy Discord",
    Callback = function()
setclipboard("https://dsc.gg/vadriftz")
    end,
})

Home:CreateButton({
    Name = "Discord | Click To Copy",
Interact = "Copy",
    Callback = function()
setclipboard("https://dsc.gg/vadriftz")
    end,
})

local UI = Home:CreateSection("▶ IMPORTANT", true)

Home:CreateButton({
    Name = "Close Interface",
Interact = "Close",
    Callback = function()
Rayfield:Destroy()
   end,
})

local Credit = Home:CreateSection("▶ Credits", true)
local Credits1 = Home:CreateLabel("[+] Jay. - Development")
local Credits2 = Home:CreateLabel("[+] Sauce_boss01 - idk, hes here tho")

local MoreScripts = Home:CreateSection("▶ More Vadrifts Scripts", true)

Home:CreateButton({
    Name = "Vadrifts Horrific Housing",
Interact = "Execute",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/HorrificHousing-v1.02"))()
    end,
})

Home:CreateButton({
    Name = "Vadrifts Hide and Seek Extreme",
Interact = "Execute",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/refs/heads/main/Hide%20and%20Seek%20Extreme"))()
    end,
})

Home:CreateButton({
    Name = "Vadrifts Rizzler",
Interact = "Execute",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/refs/heads/main/VadriftsRizz.lua"))()
    end,
})

Home:CreateButton({
    Name = "Vadrifts Chat Bypass",
Interact = "Execute",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/Bypass/main/vadrifts"))()
    end,
})

Home:CreateButton({
    Name = "Vadrifts Auto Clicker",
Interact = "Execute",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/refs/heads/main/Auto-Clicker.lua"))()
    end,
})

local FarmTab = Window:CreateTab("Autofarms", 13014546637)
local PlrTab = Window:CreateTab("Local Player", 13014546637)
local AntisTab = Window:CreateTab("Game", 13014546637)
local ForBiddenTab = Window:CreateTab("Gamepass", 13014546637)

local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local storepos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local origpos = workspace.ScriptImportance.IntoTheVoid1.VoidEnd.Position
local origpos_ = workspace.ScriptImportance.IntoTheVoid2.VoidEnd.Position
local connection

FarmTab:CreateToggle({
    Name = "Afk Farm",
    Default = false,
    Callback = function(v)
        if v then
            local p = Instance.new("Part", game.Workspace)
            p.Size = Vector3.new(10, 0.1, 10)
            p.CFrame = CFrame.new(142.9, 114, -729)
            p.Anchored = true
            p.Material = Enum.Material.Neon
            p.Transparency = 0.8
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p.CFrame + Vector3.new(0, p.Size.Y / 2 + game.Players.LocalPlayer.Character.HumanoidRootPart.Size.Y / 2, 0)
            while v do
                for hue = 0, 1, 0.01 do
                    p.Color = Color3.fromHSV(hue, 1, 1)
                    wait(0.1)
                    if not v then break end
                end
            end
            p:Destroy()
        end
    end
})

FarmTab:CreateToggle({
    Name = "Coin Farm",
    Default = false,
    Callback = function(v)
        if v then
            while v do
                for _, coinfolders in ipairs(workspace:FindFirstChild("CurrentPointCoins"):GetChildren()) do
                    local coin = coinfolders:FindFirstChild("CoinCollision")
                    if coin then
                        coin.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        wait()
                    end
                end
                wait()
            end
        end
    end
})

FarmTab:CreateToggle({
    Name = "Chrome Banana Farm",
    Default = false,
    Callback = function(v)
        if v then
            connection = game:GetService("RunService").Heartbeat:Connect(function()
                workspace.ScriptImportance.IntoTheVoid1.VoidEnd.Position = hrp.Position
                workspace.ScriptImportance.IntoTheVoid2.VoidEnd.Position = hrp.Position
                wait(0.1)
                workspace.ScriptImportance.IntoTheVoid1.VoidEnd.Position = origpos
                workspace.ScriptImportance.IntoTheVoid2.VoidEnd.Position = origpos_
                wait(0.1)
            end)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
            workspace.ScriptImportance.IntoTheVoid1.VoidEnd.Position = origpos
            workspace.ScriptImportance.IntoTheVoid2.VoidEnd.Position = origpos_
        end
    end
})

FarmTab:CreateToggle({
    Name = "Sell Farm",
    Default = false,
    Callback = function(v)
        if v then
            while v do
                wait()
                game:GetService("ReplicatedStorage").RemoteEvents.Gameplay.AttemptPurchase:InvokeServer("SurvivalShop_Banana")
                wait(0.001)
                game:GetService("ReplicatedStorage").RemoteEvents.Gui.BlackMarketEvent:FireServer("SellBanana", true)
            end
        end
    end
})

FarmTab:CreateToggle({
    Name = "Auto Win",
    Default = false,
    Callback = function(v)
        if v then
            while v do
                local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"),
                    TweenInfo.new(7),
                    {CFrame = CFrame.new(-9.4971323, 39.9823875, -1051.51807, 0.985789657, -0.00746125402, -0.16781877, -0.00396866864, 0.997699857, -0.0676704049, 0.167937666, 0.0673748031, 0.983492553)}
                )
                tween:Play()
                tween.Completed:Wait()
                wait(1)
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(0.88348788, 230.699554, 982.310242, -0.999389589, -0.000123913429, 0.0349354483, -0.000140547054, 0.999999881, -0.000473669439, -0.034935385, -0.000478290371, -0.99938947)
            end
        end
    end
})

FarmTab:CreateToggle({
    Name = "Auto Play Minigame",
    Default = false,
    Callback = function(v)
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1205.31, 240.24, -1054.60)
            while v and task.wait(0) do
                fireproximityprompt(workspace:WaitForChild("ScriptImportance"):WaitForChild("StreamingPersistent"):WaitForChild("BananaClicker"):WaitForChild("ProximityPrompt"))
            end
        else
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = storepos
        end
    end
})

local infiniteJumpEnabled = false
local infiniteJumpConnection

local noclipEnabled = false
local Noclip = nil
local Clip = nil
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function noclip()
    Clip = false
    local function Nocl()
        if Clip == false and character ~= nil then
            for _,v in pairs(character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
        wait(0.21)
    end
    Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

local function clip()
    if Noclip then Noclip:Disconnect() end
    Clip = true
end

local function toggleNoclip(state)
    noclipEnabled = state
    if noclipEnabled then
        noclip()
    else
        clip()
    end
end

PlrTab:CreateToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(state)
        toggleNoclip(state)
    end    
})

PlrTab:CreateToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        infiniteJumpEnabled = Value

        if infiniteJumpEnabled then
            local PlrTab = game:GetService('Players').LocalPlayer
            local m = PlrTab:GetMouse()

            infiniteJumpConnection = m.KeyDown:Connect(function(k)
                if k:byte() == 32 then
                    local humanoid = PlrTab.Character:FindFirstChildOfClass('Humanoid')
                    if humanoid then
                        humanoid:ChangeState('Jumping')
                        wait()
                        humanoid:ChangeState('Seated')
                    end
                end
            end)
        else
            if infiniteJumpConnection then
                infiniteJumpConnection:Disconnect()
                infiniteJumpConnection = nil
            end
        end
    end
})

local defaultWalkSpeed = game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed
local defaultJumpPower = game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower

PlrTab:CreateSlider({
    Name = "WalkSpeed",
    Info = "Set the character's walking speed.",
    Range = {1, 350},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = defaultWalkSpeed,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end    
})

PlrTab:CreateSlider({
    Name = "JumpPower",
    Info = "Set the character's jump power.",
    Range = {1, 350},
    Increment = 1,
    Suffix = "JumpPower",
    CurrentValue = defaultJumpPower,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end    
})

AntisTab:CreateToggle({
    Name = "Anti Tsunami",
    Default = false,
    Callback = function(v)
        if v then
            connection = game:GetService("RunService").Heartbeat:Connect(function()
                local activeTsunamis = workspace:FindFirstChild("ActiveTsunamis")
                if activeTsunamis then
                    for _, model in pairs(activeTsunamis:GetChildren()) do
                        if model:IsA("Model") then
                            model:Destroy()
                        end
                    end
                end
            end)
        else
            if connection then
                connection:Disconnect()
            end
        end
    end
})

ForBiddenTab:CreateToggle({
    Name = "Gain Access To The Group Chest",
    Default = false,
    Callback = function(v)
        game.Players.LocalPlayer:SetAttribute("GroupBenefitGiven", v or false)
    end
})

ForBiddenTab:CreateToggle({
    Name = "Obtain Gamepass: 2X Risk",
    Default = false,
    Callback = function(v)
        game:GetService("Players").LocalPlayer.PlrStats.Risk2XEnabled.Value = v
        game:GetService("Players").LocalPlayer.Gamepasses.Has2XRisk.Value = v
    end
})

ForBiddenTab:CreateToggle({
    Name = "Obtain Gamepass: Coin Chipper",
    Default = false,
    Callback = function(v)
        game:GetService("Players").LocalPlayer.Gamepasses.HasCoinChipper.Value = v
    end
})

local Misc = Window:CreateTab("Misc", 12966842909)
local ACL = Misc:CreateSection("Anti-Chat Logger", true)
Misc:CreateButton({
    Name = "Vadrifts Anti-Chat Logger (TextChatService Support)",
Interact = "Execute",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/vqmpjayZ/More-Scripts/main/Anti-Chat-Logger", true))()
    end,
})

local Chat = Misc:CreateSection("Chat", true)

Misc:CreateButton({
    Name = "Chat a huge annoying blank text chat bubble",
Interact = "Send",
	Callback = function()
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("                               󠀖")
else
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("                                                                                                                                                                                                       󠀖", "All")
end
    end,
})

Misc:CreateButton({
    Name = "Chat a long annoying blank text chat bubble",
Interact = "Send",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/WPHVj8Lj"))()
    end,
})

Misc:CreateButton({
    Name = "Chat our dsc link",
Interact = "Send",
	Callback = function()
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("ht￰tp￰s:/￰/d￰￰￰￰ѕ￰￰с.￰￰￰g￰g￰/￰￰￰￰vаdrіftz")
else
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ht￰tp￰s:/￰/d￰￰￰￰ѕ￰￰с.￰￰￰g￰g￰/￰￰￰￰vаdrіftz", "All")
end
    end,
})

local CS = Misc:CreateSection("Chat Spammer", true)

local ChatSpamText = ""
local SpamCoroutine
local IsChatSpamming = false
local SpamInterval = 1
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = game:GetService("Chat")

Misc:CreateInput({
    Name = "Message",
    Info = "The Message you will start spamming in chat!",
    PlaceholderText = "Your Message to spam Here",
    RemoveTextAfterFocusLost = false,
    Callback = function(Value)
        ChatSpamText = Value
    end
})

Misc:CreateSlider({
    Name = "Spam Interval (seconds)",
    Range = {0.1, 5},
    Increment = 0.1,
    Suffix = "Messages Per Second",
    CurrentValue = 1,
    Flag = "Slider1",
    Callback = function(Value)
        SpamInterval = Value
    end
})

Misc:CreateButton({
        Interact = "Start",
    Name = "Start Chat Spam",
    Callback = function()
        IsChatSpamming = true
        SpamCoroutine = coroutine.create(function()
            while IsChatSpamming do
                if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                    local chatChannel = TextChatService.TextChannels.RBXGeneral
                    if chatChannel then
                        chatChannel:SendAsync(ChatSpamText)
                    end
                else
                    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(ChatSpamText, "All")
                end
                wait(SpamInterval)
            end
        end)
        coroutine.resume(SpamCoroutine)
    end
})

Misc:CreateButton({
    Name = "Stop Chat Spam",
        Interact = "Stop",
    Callback = function()
        IsChatSpamming = false
    end
})

local TP = Misc:CreateSection("Teleporter", true)

local TPinput = Misc:CreateInput({
    Name = "Player User/Display:",
    PlaceholderText = "Username or Display name",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        playerName = Text
    end,
})

local function teleportToPlayer(targetPlayer)
    local localPlayer = game.Players.LocalPlayer
    if localPlayer and targetPlayer then
        local character = localPlayer.Character
        local targetCharacter = targetPlayer.Character
        if character and targetCharacter then
            character:MoveTo(targetCharacter.PrimaryPart.Position)
        end
    end
end

local function findPlayer(name)
    local lowerName = string.lower(name)
    for _, player in ipairs(game.Players:GetPlayers()) do
        if string.find(string.lower(player.Name), lowerName) or string.find(string.lower(player.DisplayName), lowerName) then
            return player
        end
    end
    return nil
end

Misc:CreateButton({
    Name = "Teleport",
    Interact = "Teleport",
    Callback = function()
        local targetPlayer = findPlayer(playerName)
        if targetPlayer then
            teleportToPlayer(targetPlayer)
        else
            OrionLib:MakeNotification({
                Name = "Error",
                Content = "Player not found!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end,
})

local PC = Misc:CreateSection("ESP", true)

getgenv().esp = false
getgenv().teamcheck = false
getgenv().Color = Color3.fromRGB(255, 0, 0)

Misc:CreateToggle({
    Name = "ESP",
    Default = false,
    Callback = function(Value)
        getgenv().esp = Value
        spawn(function()
            while wait() do
                if not getgenv().esp then
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v.Character and v.Character:FindFirstChild("Highlight") then
                            local Highlight = v.Character:FindFirstChild("Highlight")
                            Highlight.Enabled = false
                        end
                    end
                else
                    for i, v in pairs(game.Players:GetChildren()) do
                        if getgenv().teamcheck == true then
                            if v.Character and v ~= game.Players.LocalPlayer and v.TeamColor ~= game.Players.LocalPlayer.TeamColor then
                                if v.Character:FindFirstChild("Highlight") then
                                    local Highlight = v.Character:FindFirstChild("Highlight")
                                    Highlight.Enabled = true
                                    Highlight.FillColor = getgenv().Color
                                    Highlight.Adornee = v.Character
                                else
                                    local Highlight = Instance.new("Highlight", v.Character)
                                    Highlight.Enabled = true
                                    Highlight.FillColor = getgenv().Color
                                    Highlight.Adornee = v.Character
                                end       
                            end  
                            if v.TeamColor == game.Players.LocalPlayer.TeamColor then
                                if v.Character and v.Character:FindFirstChild("Highlight") then
                                    local Highlight = v.Character:FindFirstChild("Highlight")
                                    Highlight.Enabled = false
                                end    
                            end 
                        else
                            if v.Character and v ~= game.Players.LocalPlayer then
                                if v.Character:FindFirstChild("Highlight") then
                                    local Highlight = v.Character:FindFirstChild("Highlight")
                                    Highlight.Enabled = true
                                    Highlight.FillColor = getgenv().Color
                                    Highlight.Adornee = v.Character
                                else
                                    local Highlight = Instance.new("Highlight", v.Character)
                                    Highlight.Enabled = true
                                    Highlight.FillColor = getgenv().Color
                                    Highlight.Adornee = v.Character
                                end       
                            end    
                        end       
                    end       
                end    
            end  
        end)
    end,    
})

Misc:CreateColorPicker({
	Name = "ESP Color",
	Info = 'The color of the ESP.',
	Color = Color3.fromRGB(255, 0, 0),
	Flag = "ColorPicker1",
	Callback = function(Value)
		getgenv().Color = Value
    end	  
})

Misc:CreateToggle({
    Name = "Teamcheck",
    Default = false,
    Callback = function(Value)
        getgenv().teamcheck = Value
    end,    
})

local Admin = Misc:CreateSection("Admin", true)

Misc:CreateButton({
    Name = "Infinite yield",
Interact = "Execute",
	Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end,
})

Misc:CreateButton({
    Name = "Nameless Admin",
Interact = "Execute",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))();
    end,
})
