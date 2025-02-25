class_name PhysicalIngredient2D
extends Node2D

@export var _ingredient_id: RecipeIngredient = null;
@export var _draggable: DraggableSprite = null;

# Runtime variable data.
var _intersected_area: Area2D = null;
var _drop_area: IngredientDropArea2D = null;

func _on_draggable_area_entered(area: Area2D) -> void:
	if area is not IngredientDropArea2D: return;
	_intersected_area = area;
	if _intersected_area == null: return;
	if _intersected_area.has_method("on_ingredient_hovered_ev"):
		_intersected_area.call("on_ingredient_hovered_ev");

func _on_draggable_area_exited(area: Area2D) -> void:
	if area is not IngredientDropArea2D: return;
	if _intersected_area == null: return;
	if _intersected_area.has_method("on_ingredient_unhovered_ev"):
		_intersected_area.call("on_ingredient_unhovered_ev");
	_intersected_area = null;

func _on_draggable_released(pos: Vector2) -> void:
	if _intersected_area == null: return;
	if _intersected_area is IngredientDropArea2D:
		_drop_area = _intersected_area as IngredientDropArea2D;
		_drop_area.add_ingredient(self);
		%RuneTableIngredient.texture = load(self._ingredient_id.sprite.resource_path)
		%TableNotification.visible = true

func get_draggable_global_pos() -> Vector2:
	return _draggable.global_position;

func get_ingredient_sprite() -> Texture2D:
	return _ingredient_id.sprite;
