local Combinations = {}

-- make seperate modules for functions later

function Combinations.LoadCombinations(cubesTable)
    for _, cube in pairs(cubesTable) do
        if cube.Combination then
            for j, _ in ipairs(cube.Combination) do
                for i=1, 2 do
                    local compliment = 1
                    if i == 1 then
                        compliment = 2
                    end

                    if not Combinations[cube.Combination[j][i]] then
                        Combinations[cube.Combination[j][i]] = {}
                    end

                    Combinations[cube.Combination[j][i]][cube.Combination[j][compliment]] = cube.Type
                    -- yo what the hell this code is messy as fuck redo this ass soon ass i remember
                end
            end
        end
    end

    Combinations.LoadCombinations = nil

    print(Combinations)
end

return Combinations