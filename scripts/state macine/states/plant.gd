extends StateMacinesState

@export var plantGhostScene: PackedScene
@export var plantScene: PackedScene
#@export_file("*.tscn") var plantGhostNode
var defaultCursor = load("res://assets/cursors/default-cursor.png")
var plantCursor = load("res://assets/cursors/plant-cursor.png")
var plantGhost
var space

func state_enter(_message = {}) -> void: 
	Input.set_custom_mouse_cursor(plantCursor)
	plantGhost = plantGhostScene.instantiate()
	move_obj_to_mouse_pos(plantGhost)
	add_child(plantGhost)

func state_exit() -> void: 
	plantGhost.queue_free()
	Input.set_custom_mouse_cursor(defaultCursor)

func handle_input(event) -> void: 
	if event.is_action_pressed("ui_accept"):
		plant_crop()
	pass

func process_func(_delta) -> void: 
	move_obj_to_mouse_pos(plantGhost)
	pass

func move_obj_to_mouse_pos(object)->void:
	var objectPlace = paycast_from_cam()
	object.transform.origin = objectPlace
	pass

func paycast_from_cam() -> Vector3:
	const RAY_LENGTH = 100.0
	var cam = self.get_parent().get_parent().get_node("Camera3D")
	var mouse_pos = get_viewport().get_mouse_position()
	var from = cam.project_ray_origin(mouse_pos)
	var to = from + cam.project_ray_normal(mouse_pos) * RAY_LENGTH
	var ray_query = PhysicsRayQueryParameters3D.new()
	var space = get_world_3d().direct_space_state
	ray_query.from = from
	ray_query.to = to
	var result = space.intersect_ray(ray_query)
	if result:
		return result.position
	return to

func plant_crop()->void:
	print('executed')
	var plant = plantScene.instantiate()
	add_child(plant)
	move_obj_to_mouse_pos(plant)
	print(plant.transform.origin)
	pass
