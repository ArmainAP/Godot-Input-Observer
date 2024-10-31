class_name InputListener extends Node


signal action_pressed
signal action_released
signal action_process(value)


var _action : String = "NONE" : get = get_action


func _init(action : String):
	_action = action


func _process(delta):
	action_process.emit(get_value())


func _input(event):
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
