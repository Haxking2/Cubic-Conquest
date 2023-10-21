local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local binder = require(ReplicatedStorage.Packages.binder)

local CubeBinder = binder.new({TagName = "Cube", Ancestors ={workspace}}, require(ServerScriptService.Modules.Cube))

CubeBinder:Start()