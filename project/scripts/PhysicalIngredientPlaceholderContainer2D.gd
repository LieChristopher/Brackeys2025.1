class_name PhysicalIngredientPlaceholderContainer2D
extends Node2D

# Requirements.
@export var _prefab_placeholder: PackedScene = null;

# Runtime variable data.
var _placeholders: Array[PhysicalIngredientPlaceholder2D] = [];
var _temp_placeholder: PhysicalIngredientPlaceholder2D = null;
var _current_filled_index: int = -1;

func add_ingredient_placeholder(t: Texture2D, pos: Vector2) -> void:
	var sz: int = _placeholders.size();
	_current_filled_index += 1;
	if _current_filled_index >= sz:
		_temp_placeholder = _prefab_placeholder.instantiate() as PhysicalIngredientPlaceholder2D;
		add_child(_temp_placeholder);
		_placeholders.push_back(_temp_placeholder);
	else:
		_temp_placeholder = _placeholders[_current_filled_index];
	_temp_placeholder.set_placeholder_image(t);
	_temp_placeholder.global_position = pos;

func clear_placeholders() -> void:
	var sz: int = _placeholders.size();
	for i in range(0, sz):
		_placeholders[i].set_placeholder_image(null);
	_current_filled_index = -1;
