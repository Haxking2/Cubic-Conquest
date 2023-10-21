-- make this part of a bigger main script soon
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Cube = require(script.Cube)
local binder = require(ReplicatedStorage.Packages.binder)
local Player = require(script.Player)

local CubeBinder = binder.new({TagName = "Cube", Ancestors = {workspace}}, Cube)

CubeBinder:Start()
