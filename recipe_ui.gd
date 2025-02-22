extends Control

var screenHidden = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_show_recipe_button_pressed() -> void:
	if screenHidden:
		$RecipeScreen.show()
		screenHidden = false;
	else:
		$RecipeScreen.hide()
		screenHidden = true;
		
	
	pass # Replace with function body.
