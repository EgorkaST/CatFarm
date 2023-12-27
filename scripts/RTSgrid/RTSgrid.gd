class_name RTSGrid
extends Node3D

@export var step: float = 0.2
static var grid_step: float = 0.2

func _ready():
	grid_step = step

static func snap_to_grid(value:Vector3)->Vector3:
	var _snapped_to_grid = Vector3(0,0,0)
	_snapped_to_grid.x = round(value.x / grid_step) * grid_step
	_snapped_to_grid.z = round(value.z / grid_step) * grid_step
	_snapped_to_grid.y = value.y
	return _snapped_to_grid
