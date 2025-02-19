extends Resource
class_name RecipeIngredient

@export var name : String
@export var sprite : Texture2D

@export var LethalVital = 0
@export var StinkyFragrant = 0
@export var BodyMind = 0

@export var aspectValueList : Array[int] = [0, 0, 0]

func _ready() -> void:
	var aspectValueList = [LethalVital,StinkyFragrant,BodyMind]
