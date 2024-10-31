class_name InputListener extends Node


signal action_pressed
signal action_released
signal action_process(value, delta)
signal action_physics_process(value, delta)


var _action : String = "NONE" : get = get_action


func _init(action : String):
	_action = action


func _process(delta : float) -> void:
	action_process.emit(get_value(), delta)


func _physics_process(delta: float) -> void:
	action_physics_process.emit(get_value(), delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		_process_input_key(event)


func _process_input_key(event : InputEventKey) -> void:
	if !event.is_action(_action):
		return
	if event.is_action_pressed(_action):
		action_pressed.emit()
	if event.is_action_released(_action):
		action_released.emit()


func get_action() -> String:
	return _action


func get_value() -> float:
	return Input.get_action_strength(_action)


func is_pressed() -> bool:
	return Input.is_action_pressed(_action)
