extends Node2D

var paused= false;
@export var complete = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var array = []
	
	
	#for each in array:
		##var ingredient := RecipeIngredient._ready("Some name", 75)
		#add_child(ingredient)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_pause_button_pressed() -> void:
	if paused == true:
		print("Game Continued")
		paused = false;
		get_tree().paused=false;
		#$"Pause Button/GamePausedText".visible = false
		#$"Pause Button/GamePausedMenu".visible = false
	else:
		print("Game Paused")
		paused = true;
		get_tree().paused=true;
		#$"Pause Button/GamePausedText".visible = true
		#$"Pause Button/GamePausedMenu".visible = true
	pass # Replace with function body.
