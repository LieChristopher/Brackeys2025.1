extends Resource
class_name RecipeIngredientRune

@export var id : String
@export var name : String
@export var rune: RecipeRune
@export var ingredient: RecipeIngredient
@export var sprite : Texture2D

func getVector() -> Array[int]:
	var list = ingredient.aspectValueList
	list.append(rune.gooiness)
	return list
