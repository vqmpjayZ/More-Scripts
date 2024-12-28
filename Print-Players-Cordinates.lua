--used for easily finding spots to teleport

local function PrintandSetCPlayerPosition()
    local player = game.Players.LocalPlayer
    
    while not player.Character do
        wait()
    end
    
    local character = player.Character
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    local position = humanoidRootPart.Position
    
    print("Current Position: X= " .. position.X .. ",  Y= " .. position.Y .. ", Z= " .. position.Z)
    setclipboard(position.X .. " " .. position.Y .. " " .. position.Z)
end

PrintandSetCPlayerPosition()
