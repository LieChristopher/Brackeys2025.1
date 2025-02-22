extends Resource
class_name RecipeIngredient

@export var name : String
@export var sprite : Texture2D

@export var LethalVital = 0
@export var StinkyFragrant = 0
@export var BodyMind = 0

@export var description : String

@export var aspectValueList : Array[int] = [0, 0, 0]

#func _init() -> void:
	#pass

#func _init(varName: String, varSpritePath: String, varLethalVital: int, varStinkyFragrant: int, varBodyMind: int, varDescription: String) -> void:
	#name = varName
	#sprite = Texture2D.new()
	#sprite.resource_path = varSpritePath
	#LethalVital = varLethalVital
	#StinkyFragrant = varStinkyFragrant
	#BodyMind = varBodyMind
	#description = varDescription
	#aspectValueList = [LethalVital,StinkyFragrant,BodyMind]
