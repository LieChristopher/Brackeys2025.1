@tool

#extends Node2D
extends EditorScript

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var path_image_ingredient = "res://project/arts/internal/sprites/ingredients/"
var path_import_folder = "res://project/resources/import/"

func _run() -> void:
	print("==========RUN==============")
	#save_resource(RecipeIngredient.new('Beast Fang', path_image_ingredient+"Beast Fang.png", 0, 0, 99))
	#load_ingredients()
	#load_recipes()
	load_runes()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_runes() -> void:
	var path: NodePath = path_import_folder + "runes.csv"
	print(FileAccess.file_exists(path))
	var import_file: FileAccess = FileAccess.open(path, FileAccess.READ)
	#["Name", "Gooeyness", "Sprite File Name", "Description"]
	import_file.get_csv_line("	")
	while not import_file.eof_reached():
		var x = import_file.get_csv_line("	")
		print(x)
		#print(x.slice(3))
	return

func load_recipes() -> void:
	var path: NodePath = path_import_folder + "recipes.csv"
	print(FileAccess.file_exists(path))
	var import_file: FileAccess = FileAccess.open(path, FileAccess.READ)
	while not import_file.eof_reached():
		var x = import_file.get_csv_line("	")
		print(x)
		#print(x.slice(3))
	return

func load_ingredients() -> void:
	var path: NodePath = path_import_folder + "ingredients.csv"
	print(FileAccess.file_exists(path))
	var import_file: FileAccess = FileAccess.open(path, FileAccess.READ)
	import_file.get_csv_line("	")
	#["Name", "Sprite File Name", "Lethality/Vitality", "Stinky/Fragrant", "Body/Mind", "Lore"]
	while not import_file.eof_reached():
		var x = import_file.get_csv_line("	")
		print(x)
		var name = x[0]
		var spritePath = x[1]
		var lethalVital = int(x[2])
		var stinkyFragrant = int(x[3])
		var bodyMind = int(x[4])
		var description = x[5]
		var recipeIngredient = RecipeIngredient.new(name, spritePath, lethalVital, stinkyFragrant, bodyMind, description)
		save_resource(recipeIngredient)
	return


func save_resource(resource: Resource):
	var resource_directory: String = ""
	if RecipeIngredient.new("", "", 0, 0, 0, "").get_script() == resource.get_script():
		resource_directory = "res://project/resources/game_objects/RecipeIngredients/"
	if RecipeRune.new().get_script() == resource.get_script():
		resource_directory = "res://project/resources/game_objects/RecipeRunes/"
	if RecipePotion.new().get_script() == resource.get_script():
		resource_directory = "res://project/resources/game_objects/RecipePotion/"
	var resource_path = resource_directory + resource.name + ".tres"
	var err = ResourceSaver.save(resource, resource_path)
	if err == OK:
		print("Saved resource: ", resource_path)
	else:
		print("Failed to save resource: ", resource_path)
