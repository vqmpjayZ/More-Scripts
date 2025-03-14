
local StarterGui = game:GetService("StarterGui")
local isSendingResponse = false
local function sendResponseNotification()

    if isSendingResponse then
        return
    end
    
    isSendingResponse = true
    
    task.wait(0.3)

    StarterGui:SetCore("SendNotification", {
        Title = "Vadrifts ACL Loaded!",
        Text = "Vadrifts Anti-Chat and Screenshot Logger Loaded Succesfully!",
        Duration = 10,
        Icon = "rbxassetid://2541869220"
    })
    
    task.wait(0.5)
    isSendingResponse = false
end

local function setupMetatableDetection()
    local mt = getrawmetatable(game)
    if not mt then return false end
    
    local oldNameCall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "SetCore" and self:IsA("StarterGui") and args[1] == "SendNotification" then
            if not isSendingResponse then
                task.spawn(sendResponseNotification)
            end
        end

        return oldNameCall(self, ...)
    end)
    
    setreadonly(mt, true)
    return true
end

local function setupUIDetection()
    local CoreGui = game:GetService("CoreGui")
    if not CoreGui then return false end
    
    local notificationFrame
    
    if CoreGui:FindFirstChild("RobloxGui") then
        local RobloxGui = CoreGui.RobloxGui
        if RobloxGui:FindFirstChild("NotificationFrame") then
            notificationFrame = RobloxGui.NotificationFrame
        end
    end
    
    if not notificationFrame then
        for _, v in pairs(CoreGui:GetDescendants()) do
            if v.Name == "NotificationFrame" or v.Name:find("Notification") then
                notificationFrame = v
                break
            end
        end
    end
    
    if notificationFrame then
        notificationFrame.ChildAdded:Connect(function(child)
            if not isSendingResponse then
                task.spawn(sendResponseNotification)
            end
        end)
        return true
    end
    
    return false
end

local success = false

pcall(function()
    success = setupMetatableDetection()
end)

if not success then
    pcall(function()
        success = setupUIDetection()
    end)
end

--print("Notification responder initialized - Will send a response to any notification")

local function testResponder()
    StarterGui:SetCore("SendNotification", {
        Title = "Test Notification",
        Text = "This should trigger a response",
        Duration = 5
    })
end

return testResponder
