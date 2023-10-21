-- move this to replicated storage soon


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Trove = require(ReplicatedStorage.Packages.Trove)

local Cube = {}

Cube.__index = Cube

function Cube.new(obj)
    local self = setmetatable({}, Cube)
    self._trove = Trove.new()

    self._obj = obj
    self.Type = self._obj.Name

    self:InitialiseClickDetector()

    self.Highlighted = false

    --print(self._obj.Name .. " cube created!")

    return self
end

function Cube:InitialiseClickDetector()
    self.ClickDetector = self._obj:WaitForChild("ClickDetector", 10)

    self.ClickDetectorConnections = {}

    self.ClickDetectorConnections.MouseHoverEnter = self._trove:Connect(self.ClickDetector.MouseHoverEnter, function()
        self:ToggleHighlight()
    end)

    self.ClickDetectorConnections.MouseHoverLeave = self._trove:Connect(self.ClickDetector.MouseHoverLeave, function()
        self:ToggleHighlight()
    end)
end

function Cube:ToggleHighlight()
    if not self.Highlighted then
        self.Highlighted = true
        local hightlight = Instance.new("Highlight")
        hightlight.Parent = self._obj
        hightlight.Name = "Cube Hightlight"

        hightlight.FillTransparency = 1
        hightlight.OutlineColor = Color3.new(0.298039, 1, 0.356862)

        hightlight.DepthMode = Enum.HighlightDepthMode.Occluded
    else
        self.Highlighted = false
        self._obj:FindFirstChild("Cube Hightlight"):Destroy()
    end
end

function Cube:Destroy()
    print("Cube destroying! client")
    self._trove:Clean()
end

return Cube