extends Control

# Runtime variable data.
var _is_paused: bool = false;

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed(&"Pause"): return;
	_is_paused = !_is_paused;
	if _is_paused: $"Pause Button".pressed.emit();
	else: $"MenuScreen/Main Content/VBoxContainer/Unpause Btn".pressed.emit();

func _on_pause_button_pressed() -> void:
	get_tree().paused = true;
	process_mode = PROCESS_MODE_ALWAYS;
	_is_paused = true;

func _on_unpause_button_pressed() -> void:
	get_tree().paused = false;
	process_mode = PROCESS_MODE_INHERIT;
	_is_paused = false;
