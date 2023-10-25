extends Camera3D
const RAY_LENGTH = 200
@export var debug_node: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var space_state = get_world_3d().direct_space_state
	var cam = self
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	if result:
		debug_node.visible = true
		debug_node.set_position(result.position)
	else:
		debug_node.visible = false
	_rotate_camera(delta)

func _rotate_camera(delta):
	var viewportWidth = get_viewport().get_visible_rect().size.x
	var mousePos = get_viewport().get_mouse_position().x
	var rotation_amount = 40
	if(mousePos < 40):
		print('rotateCamLeft')
		self.rotation_degrees.y = self.rotation_degrees.y + rotation_amount * delta
		return
	if(mousePos > viewportWidth-40):
		print('rotateCamRight')
		self.rotation_degrees.y = self.rotation_degrees.y - rotation_amount * delta
		return
	
