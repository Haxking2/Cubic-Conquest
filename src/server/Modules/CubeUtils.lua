local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
--local ServerStorage = game:GetService("ServerStorage")

local PlaceCube = ReplicatedStorage.Remotes.PlaceCube
local CubePickup = ReplicatedStorage.Remotes.CubePickup

local Players = require(ServerScriptService.Modules.Players)
local Cubes = require(ServerScriptService.Modules.Cubes)

local CubeUtils = {}

function CubeUtils.CreateCube(pos, type)
    local cube = Cubes[type].Cube:Clone()
    cube.Name = type

    CollectionService:AddTag(cube, "Cube")
    -- pass changing properties like cooldowns, durabilitiy modifiers etc.
    cube.Position = pos
    cube.Parent = game.Workspace

    return cube
end

function CubeUtils.PickupCube(player, cube)
    for i=1,10 do
        local invSlot = Players[player].Inventory[tostring(i)] 
        if invSlot and invSlot == "" then
            Players[player].Inventory[tostring(i)] = cube
            print(player.Name .. " has picked up " .. cube)
            CubePickup:FireClient(player, tostring(i), cube)
            return true
        end
    end

    print("Inventory full!")
    return false
end

PlaceCube.OnServerInvoke = function(player, slot, pos)
    if Players[player].Inventory[slot] == "" then return end

    pos = CFrame.new(pos.Position.X, player.Character.HumanoidRootPart.Position.Y, pos.Position.Z)
    local distance = (pos.Position - player.Character.HumanoidRootPart.Position).magnitude
    if distance >= 17.5 then return end
    -- could add a stat to change cube range?
    CubeUtils.CreateCube(pos.Position, Players[player].Inventory[slot])
    Players[player].Inventory[slot] = ""
    return slot
end

return CubeUtils