class_name InputObserver extends Node

@export var mapper : InputMapper


static var listeners : Dictionary


func _ready() -> void:
	_populate_input_listeners()


func _populate_input_listeners() -> void:
	for action in mapper.get_actions():
		var new_listener = mapper.create_listener(action)
		if new_listener:
			listeners[action] = new_listener
			self.add_child(new_listener)


static func grab(action) -> InputListener:
	return listeners[action]
