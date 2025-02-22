class_name PhysicalIngredient2D
extends Node2D

@export var _ingredient_id: RecipeIngredient = null;

# Runtime variable data.
var _intersected_area: Area2D = null;
var _drop_area: IngredientDropArea2D = null;

func _ready() -> void:
	#self.get_node("Sprite").texture = _ingredient_id.sprite.resource_path
	#self.texture = str(_ingredient_id.sprite.resource_path)
	pass

func _on_draggable_area_entered(area: Area2D) -> void:
	_intersected_area = area;

func _on_draggable_area_exited(area: Area2D) -> void:
	_intersected_area = null;

func _on_draggable_released(pos: Vector2) -> void:
	if _intersected_area == null: return;
	if _intersected_area is IngredientDropArea2D:
		_drop_area = _intersected_area as IngredientDropArea2D;
		_drop_area.add_ingredient(self);
