extends Node

var gameData: GameData = null
var isCutscene: bool = false

var level_tracker = 0
var level_event_tracker = 0 # 0 = start cutscene, 1 = gameplay, 2 = end cutscene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.Inputs.auto_skip.enabled = false
	gameData = load("res://project/resources/game_data.tres")
	$CanvasLayer.visible = false
	$CanvasLayer2.visible = false
	$CanvasLayer3.visible = false
	$Gameplay.visible = false
	#Dialogic.start(find_cutscene())
	pass # Replace with function body.

var animation_length: float = 10.0

func find_cutscene() -> String:
	#return "res://project/scripts/dialogic/oldMan_Day01_END.dtl"
	var base_path = "res://project/scripts/dialogic/" + gameData.level_list[level_tracker] + "_"
	#print(Dialogic.VAR.get("InteractionCounter").get(gameData.character_level_list[level_tracker]))
	#if Dialogic.VAR.get("InteractionCounter").get(gameData.character_level_list[level_tracker]) > 1:
	if level_tracker >= 3 and level_event_tracker==2:
		if Dialogic.VAR.get("MoodGood").get(gameData.character_level_list[level_tracker]):
			base_path = base_path + "GoodMood_"
		else:
			base_path = base_path + "BadMood_"
	
	if level_event_tracker < 2:
		base_path = base_path + "START.dtl"
	if level_event_tracker == 2:
		base_path = base_path + "END.dtl"
	print(base_path)
	return base_path

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$CanvasLayer3/TextureRect3.texture = $"Gameplay/Drawing Paper Default Pref/Drawing Paper".get
	if Dialogic.VAR.gameOver:
		Dialogic.end_timeline()
		get_tree().change_scene_to_file("res://project/scenes/main_menu.tscn");
		return
	if level_tracker > len(gameData.level_list):
		print("LEVELS COMPLETE")
		Dialogic.start("res://project/scripts/dialogic/timeline_win.dtl")

	isCutscene = Dialogic.current_timeline != null
	$CanvasLayer.visible = isCutscene
	$CanvasLayer2.visible = isCutscene
	$CanvasLayer3.visible = isCutscene
	$Gameplay.visible = !isCutscene
	
	if level_event_tracker == 0:
		if !isCutscene:
			print(level_event_tracker)
			$Gameplay.complete = false
			$Gameplay.potion_path = "res://project/resources/game_objects/RecipePotion/Potion" + gameData.potion_level_list[level_tracker] + ".tres"
			Dialogic.Inputs.auto_skip.enabled = false
			Dialogic.start(find_cutscene())
			level_event_tracker = 1
	if level_event_tracker == 1:
		if ($Gameplay.complete == true):
			print(level_event_tracker)
			print("Level done")
			level_event_tracker = 2
	if level_event_tracker == 2:
		if !isCutscene:
			print(level_event_tracker)
			Dialogic.Inputs.auto_skip.enabled = false
			Dialogic.start(find_cutscene())
			level_tracker = level_tracker + 1
			level_event_tracker = 0
			#print(level_tracker)
			#print(level_event_tracker)
	
	if Dialogic.Inputs.auto_skip.enabled:
		var time_per_event: float = Dialogic.Inputs.auto_skip.time_per_event
		animation_length = min(time_per_event, animation_length)
		pass # Replace with function body.
	else:
		animation_length = 10.0
	pass

func _on_button_pressed() -> void:
	Dialogic.Inputs.auto_skip.enabled = !Dialogic.Inputs.auto_skip.enabled
