extends Control

# Runtime variable data.
var screenHidden: bool = false;

func _on_show_recipe_button_pressed() -> void:
	if screenHidden: $RecipeScreen.show()
	else: $RecipeScreen.hide()
	screenHidden = !screenHidden;
