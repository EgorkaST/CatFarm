extends Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
#	_rotate_camera(delta)

#func _rotate_camera(delta):
#	var sensetivity = 0.1
#	var viewportWidth = get_viewport().get_visible_rect().size.x
#	var mousePos = get_viewport().get_mouse_position().x
#	var rotation_amount = 40
#	if(mousePos < viewportWidth*sensetivity):
#		self.rotation_degrees.y = self.rotation_degrees.y + rotation_amount * delta
#		return
#	if(mousePos > viewportWidth-viewportWidth*sensetivity):
#		self.rotation_degrees.y = self.rotation_degrees.y - rotation_amount * delta
#		return
	
