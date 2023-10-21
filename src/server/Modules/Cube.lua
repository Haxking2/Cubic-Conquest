local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")

--local Cubes = require(ServerScriptService.Modules.Cubes)
local Combinations = require(ServerScriptService.Modules.Combinations)
local CubeUtils = require(ServerScriptService.Modules.CubeUtils)

local Trove = require(ReplicatedStorage.Packages.Trove)

local Cube = {}

Cube.__index = Cube

function Cube.new(obj)
    if obj.Locked then return end
    
    local self = setmetatable({}, Cube)
    self._trove = Trove.new()

    self._obj = self._trove:Add(obj, "Destroy")
    self.Type = self._obj.Name

    self.ClickDetector = self._trove:Add(Instance.new("ClickDetector"))
    self.ClickDetector.Name = "ClickDetector"
    self.ClickDetector.Parent = self._obj
    self.ClickDetector.CursorIcon = "rbxassetid://"

    self.TouchedConnection = self._trove:Connect(self._obj.Touched, function(hit)
        if CollectionService:HasTag(hit, "Cube") then
            if not Combinations[self.Type] then
                return
            end
            if not Combinations[self.Type][hit.Name] then
                print("No combinations found!") 
                return
            end
            -- add extra combination checks here
            local combinationProduct = Combinations[self.Type][hit.Name]
            local pos = self._obj.Position
            print(self._obj.Name .. " attempting to combine with " .. hit.Name .. " to make " .. combinationProduct)
           
            self:Destroy()
            CubeUtils.CreateCube(pos, combinationProduct)
        end
    end)
    print(self._obj.Name .. " cube created!")

    self.ClickedConnection = self._trove:Connect(self.ClickDetector.MouseClick, function(player)
        local picked = CubeUtils.PickupCube(player, self.Type)
        if picked then
            self:Destroy()
        end
    end)

    return self
end

function Cube:Destroy()
    print("Cube destroying!")
    self._trove:Clean()
end

return Cube