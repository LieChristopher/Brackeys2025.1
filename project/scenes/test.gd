extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_data() -> void:
	print(FileAccess.file_exists("res://project/resources/recipes.csv"))
	var import_file: FileAccess = FileAccess.open("res://project/resources/recipes.csv", FileAccess.READ)
	while not import_file.eof_reached():
		var x = import_file.get_csv_line("	")
		print(x.slice(3))
