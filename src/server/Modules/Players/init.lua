local PlayerService = game:GetService("Players")

local Functions = require(script.Functions)

local Players = {}

PlayerService.PlayerAdded:Connect(function(player)
    Players[player] = Functions.NewPlayerData()
end)

PlayerService.PlayerRemoving:Connect(function(player)
    Players[player] = nil
end)

return Players