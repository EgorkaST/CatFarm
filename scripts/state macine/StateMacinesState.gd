class_name StateMacinesState
extends Node

#reference for statemacine
var stateMacine = null 

func handle_input(_event: InputEvent) -> void: pass

func process_func(_delta:float) -> void: pass

func physics_process_func(_delta:float) -> void: pass

func state_enter(message = {}) -> void: pass

func state_exit() -> void: pass
