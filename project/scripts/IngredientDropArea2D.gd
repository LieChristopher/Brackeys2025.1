class_name IngredientDropArea2D
extends Area2D

# Variables.
@export_group("Target Potion (changes needed)")
@export var _target_potion: RecipePotion = null;

@export_group("Runes for Rune Table")
@export var _neutral_rune: RecipeRune = null;
@export var _goo_rune: RecipeRune = null;
@export var _powder_rune: RecipeRune = null;

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
	#print(ingredient)
	#print(ingredient._ingredient_id)
	print(self.name," has added ",ingredient._ingredient_id.name)
	array.push_back(ingredient._ingredient_id);
	print(self.name," now has ",array);

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
	var cauldronArray = %"Drop Indicator Cauldron".array
	var expectedIngredientRunes = _target_potion.listOfIngredientRunes
	var i=0
	
	while i<len(expectedIngredientRunes):
		var j=0
		var ingredientExists = false;
		while j<len(cauldronArray):
			if expectedIngredientRunes[i].ingredient.name == cauldronArray[j].ingredient.name  && expectedIngredientRunes[i].rune.name  == cauldronArray[j].rune.name :
				ingredientExists = true;
				print(cauldronArray[j].ingredient.name)
				cauldronArray.remove_at(j);
				i+=1
				j=0
			j+=1
		if ingredientExists == false:
			print("Wrong potion")
			return false #potion fail
		
	print("Correct potion")
	return true

func _on_clear_cauldron_button_pressed() -> void:
	array.clear();
	print(self.name,"ARRAY CLEARED!",array)
	pass

func _on_make_neutral_button_pressed() -> void:
	print(self.name, "neutral !!")
	create_potion_with_same_rune(0)
	pass
	
func _on_make_powder_button_pressed() -> void:
	print(self.name, "powder rune added!!")
	create_potion_with_same_rune(1)
	pass
	
func _on_make_goo_button_pressed() -> void:
	print(self.name, "goo rune added!!")
	create_potion_with_same_rune(2)
	pass
	
func create_potion_with_same_rune(runeType:int) -> void:
	var chosenRune = 0;
	var ingredientRuneArray = []
	
	if runeType == 0:
		chosenRune = _neutral_rune
	elif runeType == 1:
		chosenRune = _powder_rune
	elif runeType == 2 :
		chosenRune = _goo_rune
		
	for ingredient in %"Drop Area Rune".array:
		var newIngredientRune=RecipeIngredientRune.new()
		newIngredientRune.rune=chosenRune
		newIngredientRune.ingredient=ingredient
		#ingredientRuneArray.append(newIngredientRune)
		
		#testing to add to cauldron
		%"Drop Indicator Cauldron".array.append(newIngredientRune)
	
	for each in %"Drop Indicator Cauldron".array:
		print('%"Drop Indicator Cauldron".array has ',each.ingredient.name, each.rune.name)
	ingredientRuneArray.clear()
	%"Drop Area Rune".array.clear()
	
	
