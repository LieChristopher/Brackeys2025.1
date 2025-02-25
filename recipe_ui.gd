extends Control

@export var _animation: AnimationPlayer = null;
@export var _open_anim_name: StringName = &"ANIM_OpenRecipe";
@export var _close_anim_name: StringName = &"ANIM_CloseRecipe";

# Runtime variable data.
var _target_potion: RecipePotion = null;
var _screen_hidden: bool = true;

func _ready() -> void:
	_target_potion = load(get_parent().get_parent().potion_path);
	$RecipeScreen/Paper.texture = _target_potion.recipe;

func _on_show_recipe_button_pressed() -> void:
	if _screen_hidden: _animation.play(_open_anim_name);
	else: _animation.play(_close_anim_name);
	_screen_hidden = !_screen_hidden;
