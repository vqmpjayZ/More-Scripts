--[[
re-scripted darks script cz his dumbahh got his website removed
i also fixed the syn.request shi
returning to this in 2026 i made it work for textchatservice since legacy chat is gone

Tutorial:
make a discord webhook
copy the webhook url
put the webhooks url in the 'Your Discord Webhook Link Here!'

this basically makes your bot start sending the chat messages from the server ur in
--]]

local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local MarketplaceService = game:GetService("MarketplaceService")

local success, info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, game.PlaceId)
if not success then
    return
end

local wh = "Enter your Discord webhook link here!"

local startEmbed = {
    ["title"] = "Beginning of Message logs on " .. info.Name .. " at " .. tostring(os.date("%m/%d/%y at time %X"))
}

request({
    Url = wh,
    Headers = {["Content-Type"] = "application/json"},
    Body = HttpService:JSONEncode({
        ["embeds"] = {startEmbed},
        ["content"] = ""
    }),
    Method = "POST"
})

local function logMsg(webhook, playerName, message)
    local embed = {
        ["description"] = playerName .. ": " .. message .. "  " .. tostring(os.date("| time %X"))
    }

    request({
        Url = webhook,
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            ["embeds"] = {embed},
            ["content"] = ""
        }),
        Method = "POST"
    })
end

TextChatService.MessageReceived:Connect(function(textChatMessage)
    local props = textChatMessage.TextSource
    if not props then
        return
    end

    local player = props.UserId and game.Players:GetPlayerByUserId(props.UserId)
    local playerName = player and player.Name or props.Name or "Unknown"

    logMsg(wh, playerName, textChatMessage.Text)
end)
