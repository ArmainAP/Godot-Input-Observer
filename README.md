# Godot Input Observer

Godot Input Observer is a lightweight framework designed for handling game inputs in a centralized and efficient manner in order to simplify and enhance input management for developers.

## Key Classes and Features

### 1. `InputObserver`
`InputObserver` serves as the central reference for managing inputs. It holds a reference to an `InputMapper` instance, which organizes and processes various input actions. 

In the example provided, `InputObserver` is set up as a global autoload, making it accessible throughout the project.
![image](https://github.com/user-attachments/assets/a90f229f-d758-47d8-a074-c686f1402876)

### 2. `InputMapper`
`InputMapper` is responsible for customizing action management and defining which actions are recognized and how they are handled in the game. Through the `InputMapper`, you can tailor actions according to specific gameplay requirements.

Example code for `InputMapper`:

```gdscript
class_name GameInput extends InputMapper

enum Actions {
	NONE, # Null, uninitialized
	
	Left,
	Right,
	
	Up,
	Down,
	
	# Everything < is a real action
	VIRTUAL, # Control point
	# Everything > is scripted. 
	MoveH,
	MoveV,
}

func get_actions() -> Array:
	return Actions.values()

func create_listener(action) -> InputListener:
	match action:
		var is_not_virtual when action > Actions.NONE and action < Actions.VIRTUAL:
			return InputListener.new(Actions.find_key(action))
		Actions.MoveH: return LeftRightInputListener.new()
		Actions.MoveV: return UpDowntInputListener.new()
		_: return null
```

### 3. `InputListener`
The `InputListener` class is designed to interact directly with action strings, allowing actions to be bound directly to game controls. This class is ideal for handling simple actions like `Left`, `Right`, `Up`, and `Down`.

### 4. `VirtualInputListener`
`VirtualInputListener` enables the creation of custom `InputListener` instances to manage complex actions or combos, where multiple input actions are required under a single check. This is particularly useful for actions that require combinations or sequences of inputs.

## Setup Instructions

1. **Add `InputObserver` and `InputMapper` to the Context:**
   - Place the `InputObserver` with a reference to `InputMapper` in a context where it will be accessible. In the example shown in the image, `InputObserver` is added as a global autoload scene, making it available throughout the project.

2. **Configure Actions in `InputMapper`:**
   - Define the actions in the `Actions` enum within the `InputMapper` class. You can then use `create_listener` to return specific listeners based on the action type, allowing for both simple and virtual input handling.

3. **Use `InputListener` and `VirtualInputListener`:**
   - Use `InputListener` for single actions and `VirtualInputListener` for more complex or custom actions.

## Accessing Inputs

To easily access specific inputs, you can use the `@onready` syntax with the static `grab` method provided by `InputObserver`. This allows you to attach specific actions directly to variables for easy access.

Example:

```gdscript
@onready var moveH_listener := InputObserver.grab(GameInput.Actions.MoveH)
```

## Contributing

We welcome contributions! If you have a feature request, bug report, or want to improve the plugin, please open an issue or send a pull request.

## Credits

Created by Adrian-Marian Popoviciu. A special thanks to the Unreal Engine community for their valuable feedback and contributions.
