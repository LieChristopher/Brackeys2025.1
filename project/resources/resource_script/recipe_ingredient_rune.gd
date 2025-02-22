extends Resource
class_name RecipeIngredientRune

@export var rune: RecipeRune
@export var ingredient: RecipeIngredient

func getName() -> String:
	return rune.adjective + " " + ingredient.name

func getVector() -> Array[int]:
	var list = ingredient.aspectValueList
	list.append(rune.gooiness)
	return list
