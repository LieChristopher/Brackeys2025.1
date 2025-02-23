extends Control

var gameData: GameData = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameData = load("res://project/resources/game_data.tres")
	print(gameData.level_list)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ($Gameplay.complete == true):
		print("Level done")
		$Gameplay.visible = false
	pass
