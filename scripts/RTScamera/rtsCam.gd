extends Node3D


#input handling 
var ButtonCamMoveRef:Vector2 #origin of moving vector for move camera via button method
#S@export_range(10,100,1) var sencetivityButtonCamMove:int = 30 ## sencetivity of camera in percents for move camera via button method

@onready var cam: Camera3D = $playerCam
func _ready():
	pass # Replace with function body.
func _input(_event):
	if Input.is_action_just_pressed("moveCameraByButton"):
		ButtonCamMoveRef = get_viewport().get_mouse_position()
#function that returns normalized cavera Input
func cameraMoveVector() -> Vector2:
	if Input.is_action_pressed("moveCameraByButton"):
		return (get_viewport().get_mouse_position() - ButtonCamMoveRef)
		print(get_viewport().get_mouse_position() - ButtonCamMoveRef)
	return Vector2(0,0)
	
func move_camera(delta,cameraInput:Vector2 = Vector2(0,0)) -> void:
	const speed = 10
	var moveVector: Vector3
	moveVector.z = cameraInput.y
	moveVector.x = cameraInput.x
	moveVector.y = 0
	moveVector = moveVector.normalized()
	moveVector = moveVector.rotated(Vector3(0,1,0),self.rotation.y)
	
	moveVector = self.position + moveVector
	position = position.move_toward(moveVector, delta * speed)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_camera(_delta,cameraMoveVector())
	pass
