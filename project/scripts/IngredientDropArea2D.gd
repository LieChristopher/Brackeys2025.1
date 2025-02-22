class_name IngredientDropArea2D
extends Area2D

# Variables.
@export_group("Optionals")
@export var _indicator: Sprite2D = null;

@export_group("Animations")
@export var _anim: AnimationPlayer = null;
@export var _bleeping_anim_key: StringName = &"ANIM_IndicatorBleeping";

# Runtime variable data.
var _temp_content: Dictionary;
var _indicator_active: bool = false;
var array = [];

#func _on_area_entered(area: Area2D) -> void:
	#print("Ingredient entered area and is added to array")
	#array.append(area.name)
	#print(self.name,"area currently has nodes",array)
	#
	##get filepath of dragged ingredient
	##print("filepath for ingredient  entered into array:",area.get_node("Sprite").texture.resource_path)
	#
	##change sprite of current ingredient
	##area.get_node("Sprite").texture= load("res://project/arts/external/Images/Ingredients/Poison Ivy.png")
	#
	 ##queuefree messes with pointercontroller2d
	##area.queue_free()
	##area.get_node("CollisionShape2D").queue_free()
	#pass # Replace with function body.

func add_ingredient(ingredient: PhysicalIngredient2D) -> void:
	array.push_back(ingredient);
	print(array);

func _on_button_pressed() -> void:
	array.clear();
	print(self.name,"ARRAY CLEARED!",array)
	pass # Replace with function body.

func _on_pointer_control_on_pointer_pressed(pos: Vector2, detected_contents: Array[Dictionary]) -> void:
	var sz: int = detected_contents.size();
	for i in range(0, sz):
		_temp_content = detected_contents[i];
		if _temp_content.collider is DraggableSprite:
			_indicator_active = true;
			_indicator.visible = true;
			_anim.play(_bleeping_anim_key);

func _on_pointer_control_on_pointer_released(pos: Vector2, detected_contents: Array[Dictionary]) -> void:
	if _indicator_active:
		_indicator_active = false;
		_indicator.visible = false;
		_anim.stop();
