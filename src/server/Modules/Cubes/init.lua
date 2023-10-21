local ServerScriptService = game:GetService("ServerScriptService")
local Combinations = require(ServerScriptService.Modules.Combinations)
-- possibly move this module and combinations to replicated storage for usage on client

local Cubes = {}

for _, cube in pairs(script:GetDescendants()) do
    if cube:IsA("ModuleScript") then
        Cubes[cube.Name] = require(cube)
    end
end

Combinations.LoadCombinations(Cubes)

return Cubes