extends StateMacinesState

var defaultCursor = load("res://assets/cursors/default-cursor.png")

func state_enter(_message := {})->void:
	Input.set_custom_mouse_cursor(defaultCursor)
	pass
	
func process_func(_delta:float) -> void: pass

func physics_process_func(_delta:float) -> void: pass
