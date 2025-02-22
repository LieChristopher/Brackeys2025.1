extends Control

func _on_pause_button_pressed() -> void:
	get_tree().paused = true;
	process_mode = PROCESS_MODE_ALWAYS;

func _on_unpause_button_pressed() -> void:
	get_tree().paused = false;
	process_mode = PROCESS_MODE_INHERIT;
