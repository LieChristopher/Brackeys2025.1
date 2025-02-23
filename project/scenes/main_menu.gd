extends Control

@export var _gameplay_control: String = "res://project/scenes/game_unit.tscn";
@export var _gameplay_scene: String = "res://project/scenes/gameplay.tscn";

func _ready() -> void:
	pass

func _on_play_pressed() -> void:
	#get_tree().change_scene_to_file(_gameplay_scene);
	get_tree().change_scene_to_file(_gameplay_control);

func _on_exit_pressed() -> void:
	get_tree().quit();
