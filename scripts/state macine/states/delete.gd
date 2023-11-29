extends StateMacinesState

var defaultCursor = load("res://assets/cursors/default-cursor.png")
var deleteCursor = load("res://assets/cursors/showel-cursor.png")

func state_enter(_message := {})->void:
	Input.set_custom_mouse_cursor(deleteCursor)
	pass

func state_exit() -> void: 
	Input.set_custom_mouse_cursor(defaultCursor)
