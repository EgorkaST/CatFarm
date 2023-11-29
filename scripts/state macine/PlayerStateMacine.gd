extends StateMacine

func changePlayerStatesViaShortcuts() -> void:
	if Input.is_action_just_pressed("changeStateToInteraction"):
		change_state("interaction")
		return
	if Input.is_action_just_pressed("changeStateToPlant"):
		change_state("plant")
		return
	if Input.is_action_just_pressed("changeStateToDelete"):
		change_state("delete")
		return

func _process(delta):
	state.process_func(delta)
	changePlayerStatesViaShortcuts()
