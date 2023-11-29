extends Node3D
class_name StateMacine

@export var initial_state := NodePath()
@onready var state: StateMacinesState = get_node(initial_state)
# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	for childstate in get_children():
		childstate.stateMacine = self
	state.state_enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta):
	state.process_func(delta)
	
func _physics_process(delta):
	state.physics_process_func(delta)

func change_state(TargetStateName:String,message: Dictionary = {}) -> void:
	if not has_node(TargetStateName):
		push_error("cannot find state: ",TargetStateName)
		return
	state.state_exit()
	state = get_node(TargetStateName)
	state.state_enter(message)
	
