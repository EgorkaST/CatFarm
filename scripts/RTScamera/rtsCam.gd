extends Node3D


# Input handling 
var desiredLocation: Vector3
var ButtonCamMoveRef:Vector2 #origin of moving vector for move camera via button method
@export var cameraCurrentHeight: float = 4.5
@export var topCamAngle: float = -70
@export var botCamAngle: float = -20
var cameraMaxHeight: float = 8
var cameraMinHeight: float = 2
var cameraBoundingBox: Vector2 = Vector2(40,40)
@onready var cam: Camera3D = $Camera3d

func _process(delta):
	desiredLocation = calculateDesiredLocation()
	zoomCamera()
	pass
func _physics_process(delta):
	moveCameraToDesiredLocation(delta, desiredLocation)
	rotateCamZoom()
	pass
func _ready():
	pass # Replace with function body.
	
func _input(_event):
	if Input.is_action_just_pressed("moveCameraByButton"):
		ButtonCamMoveRef = get_viewport().get_mouse_position()

#function that returns camera Input
func cameraMoveInputs() -> Vector2:
	var camInput:Vector2
	var screenBumpVector: Vector2
	var camKeyboardVector: Vector2
	#
	screenBumpVector = moveCamByScreenBump()
	camKeyboardVector = Input.get_vector ( "moveCameraLeft", "moveCameraRight", "moveCameraFoward", "moveCameraBackwards")
	#
	if Input.is_action_pressed("moveCameraByButton"):
		camInput = get_viewport().get_mouse_position() - ButtonCamMoveRef
	elif not camKeyboardVector == Vector2(0,0):
		camInput = camKeyboardVector
	elif not screenBumpVector == Vector2(0,0): 
		camInput = screenBumpVector
	return camInput.normalized()

func moveCamByScreenBump() -> Vector2: 
	const SENCETIVITY = 0.1
	var screenBumpVector: Vector2 = Vector2(0,0)
	#var middleOfScreen: Vector2
	var mousePos: Vector2
	#
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


func cameraMoveVector()->Vector3:
	var camMoveVector: Vector3 = Vector3(0,0,0)
	var camInputs = cameraMoveInputs()
	camMoveVector.x = camInputs.x
	camMoveVector.z = camInputs.y
	return camMoveVector

func calculateDesiredLocation()->Vector3:
	var desiredLocation: Vector3
	var cameraRotation: float = self.rotation.y
	desiredLocation = position + cameraMoveVector().rotated(Vector3(0,1,0),cameraRotation)
	desiredLocation.y = calculateCameraHeight()
	return desiredLocation

# TODO make here raycast to determine cam height
func calculateCameraHeight()->float: 
	var camHeight: float
	var space_state = get_world_3d().direct_space_state
	var origin: Vector3 = self.transform.origin
	origin.y = 100
	var raycastEnd = origin
	raycastEnd.y -= 100
	var raycastQuery = PhysicsRayQueryParameters3D.create(origin, raycastEnd)
	raycastQuery.exclude = [self]
	var result = space_state.intersect_ray(raycastQuery)
	if result:
		camHeight = cameraCurrentHeight + result.position.y
	else: 
		camHeight = cameraCurrentHeight
	return clampf(camHeight,cameraCurrentHeight,INF)

func zoomCamera()->void:
	const ZOOM_SPEED = 0.5
	if Input.is_action_just_pressed("zoomCameraUp"):
		cameraCurrentHeight -= ZOOM_SPEED
		pass
	if Input.is_action_just_pressed("zoomCameraDown"):
		cameraCurrentHeight += ZOOM_SPEED
		pass
	cameraCurrentHeight = clamp(cameraCurrentHeight,cameraMinHeight,cameraMaxHeight)
	pass
func rotateCamZoom()->void:
	var heightMultiplier: float = (cameraCurrentHeight-cameraMinHeight)/(cameraMaxHeight-cameraMinHeight)
	var cameraCalculatedAngle: float = botCamAngle + (topCamAngle-botCamAngle)*heightMultiplier
	print(cameraCalculatedAngle)
	cam.rotation.x = deg_to_rad(cameraCalculatedAngle) 
	pass
func moveCameraToDesiredLocation(delta, desiredLocation:Vector3) -> void: 
	var targetPosition = desiredLocation
	targetPosition.x = clampf(targetPosition.x,-cameraBoundingBox.x,cameraBoundingBox.x)
	targetPosition.z = clampf(targetPosition.z,-cameraBoundingBox.y,cameraBoundingBox.y)
	position = position.move_toward(targetPosition,delta*20)
	position.y = targetPosition.y
	pass
