extends Control

@export var _gameplay_scene: String = "res://project/scenes/gameplay.tscn";

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(_gameplay_scene);

func _on_exit_pressed() -> void:
	get_tree().quit();
