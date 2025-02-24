extends Control

var gameData: GameData = null
var isCutscene: bool = false

var level_tracker = 0
var level_event_tracker = 0 # 0 = start cutscene, 1 = gameplay, 2 = end cutscene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.Inputs.auto_skip.enabled = false
	gameData = load("res://project/resources/game_data.tres")
	pass # Replace with function body.

var animation_length: float = 10.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if level_tracker > len(gameData.level_list):
		print("LEVELS COMPLETE")
	var path_prefix = "res://project/scripts/dialogic/" + gameData.level_list[level_tracker] + "_"
	isCutscene = Dialogic.current_timeline != null
	$CanvasLayer.find_child("SkipButton").visible = isCutscene
	$CutsceneBG.visible = isCutscene
	
	if level_event_tracker == 0:
		if !isCutscene:
			$Gameplay.complete = false
			Dialogic.Inputs.auto_skip.enabled = false
			Dialogic.start(path_prefix+"START.dtl")
			level_event_tracker = 1
	if level_event_tracker == 1:
		if ($Gameplay.complete == true):
			print("Level done")
			level_event_tracker = 2
	if level_event_tracker == 2:
		if !isCutscene:
			Dialogic.Inputs.auto_skip.enabled = false
			Dialogic.start(path_prefix+"END.dtl")
			level_tracker = level_tracker + 1
			level_event_tracker = 0
			print(level_tracker)
			print(level_event_tracker)
	
	if Dialogic.Inputs.auto_skip.enabled:
		var time_per_event: float = Dialogic.Inputs.auto_skip.time_per_event
		animation_length = min(time_per_event, animation_length)
		pass # Replace with function body.
	else:
		animation_length = 10.0
	pass

func _on_button_pressed() -> void:
	Dialogic.Inputs.auto_skip.enabled = !Dialogic.Inputs.auto_skip.enabled
