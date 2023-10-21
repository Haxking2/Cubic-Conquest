-- really gotta organise this module

local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local translationTable = {
    One = "1",
    Two = "2",
    Three = "3"
}

local PlaceCubeEvent = ReplicatedStorage.Remotes.PlaceCube
local CubePickup = ReplicatedStorage.Remotes.CubePickup

local UpdateUI = ReplicatedStorage.Bindables.UpdateUI

local localPlayer = game.Players.LocalPlayer
local Mouse = localPlayer:GetMouse()

local Player = {
    ["Inventory"] = {
        ["1"] = "",
        ["2"] = "",
        ["3"] = ""
    },

    ["SelectedSlot"] = "1"
}
function SwitchHotbarSlot(actionName, inputState, inputObject)
    if inputState ~= Enum.UserInputState.Begin then return end
    Player.SelectedSlot = translationTable[inputObject.KeyCode.Name]
    UpdateUI:Fire(false, "", true, tonumber(Player.SelectedSlot))
end

function PlaceCube(actionName, inputState, inputObject)
    if inputState ~= Enum.UserInputState.Begin then return end
    local slot = PlaceCubeEvent:InvokeServer(Player.SelectedSlot, Mouse.Hit)
    if slot then
        Player.Inventory[slot] = ""
        UpdateUI:Fire(tonumber(slot), "", false, 0)
    end
end

CubePickup.OnClientEvent:Connect(function(invSlot, cube)
    Player.Inventory[invSlot] = cube
    UpdateUI:Fire(tonumber(invSlot), cube, false, 0)
    -- be more consistent with variable names? slot invslot and whatevs
end)

ContextActionService:BindAction("ChangeHotbarSlot", SwitchHotbarSlot, false, Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three)
ContextActionService:BindAction("PlaceCube", PlaceCube, false, Enum.KeyCode.Q)

return Player