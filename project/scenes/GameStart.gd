extends Node2D

@export var complete: bool = false
@export var potion_path = "res://project/resources/game_objects/RecipePotion/PotionChiseled.tres"

# Runtime variabgle data.
var paused: bool = false;

func _on_pause_button_pressed() -> void:
	paused = !paused;
	get_tree().paused = paused;

func _on_submit_button_pressed() -> void:
	#Dialogic.Portraits.find_child()
	var x : ImageTexture = load("res://project/resources/game_objects/new_image_texture.tres")
	x.set_image($"Drawing Paper Default Pref/Drawing Paper".get_drawn_texture())
	ResourceSaver.save(x, "res://project/resources/game_objects/new_image_texture.tres")
	%GameEnd.visible = true;
	await get_tree().create_timer(2.65).timeout;
	%GameEnd.visible = false;
	complete = true
	pass # Replace with function body.
