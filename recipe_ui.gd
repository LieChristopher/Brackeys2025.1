extends Control

# Runtime variable data.
var screenHidden: bool = false;

func _on_show_recipe_button_pressed() -> void:
	if screenHidden: $RecipeScreen.show()
	else: $RecipeScreen.hide()
	screenHidden = !screenHidden;

func _process(delta: float) -> void:
	var _target_potion: RecipePotion = load(get_parent().get_parent().potion_path)
	#print(_target_potion.name)
	$RecipeScreen/Paper.texture = _target_potion.recipe
