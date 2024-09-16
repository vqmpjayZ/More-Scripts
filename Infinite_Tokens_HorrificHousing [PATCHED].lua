--[[
Unlocks all the ornaments and gives you alot of Tokens in Horrific Housing.
If it starts lagging your Roblox just rejoin, its because of the notifications.

If it doesnt work remove all the stuff behind the --'s or --[[/--]]
--]]

local startTime = tick()
repeat 
                local A_1 = 1e-59
                local A_2 = "Ornament"
                local event = game:GetService("ReplicatedStorage").ShopPurchase
                event:FireServer(A_1, A_2)
until tick() - startTime >= 10

 -- change the startTime to whatever your pc can handle
