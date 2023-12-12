extends StateMacinesState

@export var plantGhostScene: PackedScene
@export var plantScene: PackedScene
@export var playerCam: Camera3D
#@export_file("*.tscn") var plantGhostNode
var defaultCursor = load("res://assets/cursors/default-cursor.png")
var plantCursor = load("res://assets/cursors/plant-cursor.png")
var plantGhost
var raycast_Info

func state_enter(_message = {}) -> void: 
	Input.set_custom_mouse_cursor(plantCursor)
	raycast_Info = paycast_from_cam()
	plantGhost = plantGhostScene.instantiate()
	plantGhost.transform.origin = raycast_Info.position
	add_child(plantGhost)

func state_exit() -> void: 
	plantGhost.queue_free()
	Input.set_custom_mouse_cursor(defaultCursor)

func handle_input(event) -> void: 
	if event.is_action_pressed("placeBuilding"):
		plant_crop(raycast_Info.position)
	pass

func physics_process_func(_delta:float) -> void: 
	raycast_Info = paycast_from_cam()
	pass


func process_func(_delta) -> void: 
	plantGhost.transform.origin = Vector3(round(raycast_Info.position.x),raycast_Info.position.y,round(raycast_Info.position.z)) #round(raycast_Info.position) #crashes if raycast dosent intersect with anything need to fix
	pass

func paycast_from_cam():
	const RAY_LENGTH = 100.0
	var mouse_pos = get_viewport().get_mouse_position()
	var from = playerCam.project_ray_origin(mouse_pos)
	var to = from + playerCam.project_ray_normal(mouse_pos) * RAY_LENGTH
	var ray_query = PhysicsRayQueryParameters3D.new()
	var space = get_world_3d().direct_space_state
	ray_query.collision_mask = 1
	ray_query.from = from
	ray_query.to = to
	var result = space.intersect_ray(ray_query)
	if result:
		return result
	print(result) 
	return {"position":to}#need to do proper fix!!!

func plant_crop(place_to_plant:Vector3)->void:
	
	#raycast
	
	
	if not can_plant_crop(place_to_plant): return
	var plant = plantScene.instantiate()
	add_child(plant)
	plant.transform.origin = Vector3(round(place_to_plant.x),place_to_plant.y,round(place_to_plant.z))
	var rng = RandomNumberGenerator.new()
	plant.rotate_y(rng.randf_range(0, 6))
	pass

func can_plant_crop(_place_to_plant)->bool:
	
	return true
