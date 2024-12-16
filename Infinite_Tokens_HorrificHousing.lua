local startTime = tick()
repeat 
                local A_1 = 1e-59
                local A_2 = "Ornament"
                local event = game:GetService("ReplicatedStorage").ShopPurchase
                event:FireServer(A_1, A_2)
until tick() - startTime >= 10
