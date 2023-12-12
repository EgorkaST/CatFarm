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

#function that returns camera Input
func cameraMoveVector() -> Vector2:
	var camInput:Vector2
	var screenBumpVector: Vector2
	var camKeyboardVector: Vector2
	#
	screenBumpVector = moveCamByScreenBump()
	camKeyboardVector = Input.get_vector ( "moveCameraLeft", "moveCameraRight", "moveCameraUp", "moveCameraDown")
	#
	if Input.is_action_pressed("moveCameraByButton"):
		#TODO
		#add deadzone!!!
		#probably in other func!
		camInput = get_viewport().get_mouse_position() - ButtonCamMoveRef
	elif not camKeyboardVector == Vector2(0,0):
		camInput = camKeyboardVector
	elif not screenBumpVector == Vector2(0,0): 
		camInput = screenBumpVector
	#
	return camInput
	
func moveCamByScreenBump() -> Vector2: 
	const SENCETIVITY = 0.1
	var screenBumpVector: Vector2 = Vector2(0,0)
	#var middleOfScreen: Vector2
	var mousePos: Vector2
	
	mousePos = get_viewport().get_mouse_position()
	#middleOfScreen = get_viewport().get_visible_rect().size/2
	if mousePos.x <= 0:
		screenBumpVector.x = -1	
	if mousePos.x >= get_viewport().get_visible_rect().size.x:
		screenBumpVector.x = 1	
	if mousePos.y <= 0:
		screenBumpVector.y = -1	
	if mousePos.y >= get_viewport().get_visible_rect().size.y:
		screenBumpVector.y = 1	
	return screenBumpVector

func move_camera(delta,cameraInput:Vector2 = Vector2(0,0)) -> void:
	const speed = 10
	var moveVector: Vector3
	moveVector.z = cameraInput.y
	moveVector.x = cameraInput.x
	moveVector.y = 0
	moveVector = moveVector
	moveVector = moveVector.rotated(Vector3(0,1,0),self.rotation.y)
	
	moveVector = self.position + moveVector
	position = position.move_toward(moveVector, delta * speed)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_camera(_delta,cameraMoveVector())
	pass
