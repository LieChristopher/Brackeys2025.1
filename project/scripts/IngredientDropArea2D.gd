class_name IngredientDropArea2D
extends Area2D

signal on_filled_amount(amount: int);

# Variables.
@export_group("Target Potion (changes needed)")
@export var _target_potion: RecipePotion = null;

@export_group("Runes for Rune Table")
@export var _neutral_rune: RecipeRune = null;
@export var _goo_rune: RecipeRune = null;
@export var _powder_rune: RecipeRune = null;

@export_group("Optionals")
@export var _indicator: Sprite2D = null;
@export var _on_ingredient_hovered: Color = Color.CYAN;
@export var _on_ingredient_unhovered: Color = Color.WHITE;
@export var _drawing_canvas: CanvasLayer = null;
@export var _placeholder_container: PhysicalIngredientPlaceholderContainer2D = null;

@export_group("Animations")
@export var _anim: AnimationPlayer = null;
@export var _bleeping_anim_key: StringName = &"ANIM_IndicatorBleeping";

# Runtime variable data.
var _temp_content: Dictionary;
var _indicator_active: bool = false;
var _temp_expected_ingredient: RecipeIngredient;
var _temp_real_ingredient: RecipeIngredient;
var _temp_expected_rune: RecipeRune;
var _temp_real_rune: RecipeRune;
var array: Array[Variant] = [];

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

func _ready() -> void:
	_target_potion = load(get_parent().get_parent().potion_path)
	# Call initial event.
	on_filled_amount.emit(array.size());

func on_ingredient_hovered_ev() -> void:
	_indicator.modulate = _on_ingredient_hovered;

func on_ingredient_unhovered_ev() -> void:
	_indicator.modulate = _on_ingredient_unhovered;

func add_ingredient(ingredient: PhysicalIngredient2D) -> void:
	print(self.name," has added ",ingredient._ingredient_id.name)
	array.push_back(ingredient._ingredient_id);
	print(self.name," now has ",array);
	_indicator.modulate = _on_ingredient_unhovered;
	on_filled_amount.emit(array.size());
	if _placeholder_container == null: return;
	_placeholder_container.add_ingredient_placeholder(
		ingredient.get_ingredient_sprite(),
		ingredient.get_draggable_global_pos());

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

func _on_make_cauldron_potion_button_pressed() -> bool:
	var cauldronArray = %"Drop Indicator Cauldron".array;
	var expectedIngredientRunes: Array[RecipeIngredientRune] = _target_potion.listOfIngredientRunes;
	var i: int = 0; var is_failed: bool = false;
	var szca: int = cauldronArray.size();
	var sze: int = expectedIngredientRunes.size();
	if szca != sze:
		is_failed = true;
	else:
		var max_sz: int = maxi(szca, sze);
		while i < max_sz:
			_temp_expected_ingredient = expectedIngredientRunes[i].ingredient;
			_temp_real_ingredient = cauldronArray[i].ingredient;
			_temp_expected_rune = expectedIngredientRunes[i].rune;
			_temp_real_rune = cauldronArray[i].rune;
			# TODO: Calculate sum precentage of success and reputation.
			if _temp_expected_ingredient.name != _temp_real_ingredient.name:
				is_failed = true;
				break;
			if _temp_expected_rune.name != _temp_real_rune.name:
				is_failed = true;
				break;
			i += 1;
	if is_failed:
		print("Wrong potion");
		potion_complete();
		Dialogic.VAR.set_variable("success", false);
		return false; #potion fail
	print("Correct potion");
	potion_complete();
	Dialogic.VAR.set_variable("success", true);
	return true;

func potion_complete() -> void:
	%GameEnd.visible = true;
	await get_tree().create_timer(2.65).timeout;
	%GameEnd.visible = false;
	get_parent().get_parent().complete = true;
	if _drawing_canvas == null: return;
	_drawing_canvas.visible = true;
	_drawing_canvas.process_mode = Node.PROCESS_MODE_INHERIT;

func _on_clear_cauldron_button_pressed() -> void:
	array.clear();
	print(self.name,"ARRAY CLEARED!",array)

func _on_make_neutral_button_pressed() -> void:
	print(self.name, "neutral !!")
	create_potion_with_same_rune(0)
	
func _on_make_powder_button_pressed() -> void:
	print(self.name, "powder rune added!!")
	create_potion_with_same_rune(1)

func _on_make_goo_button_pressed() -> void:
	print(self.name, "goo rune added!!")
	create_potion_with_same_rune(2)

func create_potion_with_same_rune(runeType:int) -> void:
	var chosenRune = 0;
	var ingredientRuneArray = []
	
	if runeType == 0: chosenRune = _neutral_rune
	elif runeType == 1: chosenRune = _powder_rune
	elif runeType == 2 : chosenRune = _goo_rune
		
	for ingredient in %"Drop Area Rune".array:
		var newIngredientRune=RecipeIngredientRune.new()
		newIngredientRune.rune=chosenRune
		newIngredientRune.ingredient=ingredient
		#ingredientRuneArray.append(newIngredientRune)
		
		#testing to add to cauldron
		%"Drop Indicator Cauldron".array.append(newIngredientRune)
	
	for each in %"Drop Indicator Cauldron".array:
		print('%"Drop Indicator Cauldron".array has ',each.ingredient.name, each.rune.name)
	ingredientRuneArray.clear();
	%"Drop Area Rune".array.clear();
	%RuneTableIngredient.texture = null;
	%TableNotification.visible = false;
