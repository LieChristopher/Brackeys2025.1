extends Node2D

@export var complete: bool = false
@export var potion_path = "res://project/resources/game_objects/RecipePotion/PotionChiseled.tres"

# Runtime variabgle data.
var paused: bool = false;

func _on_pause_button_pressed() -> void:
	paused = !paused;
	get_tree().paused = paused;
