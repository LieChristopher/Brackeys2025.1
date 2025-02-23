@tool
extends Resource
class_name GameData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
@export var level_list = ["oldMan_Day01","richGirl_Day01","poorGuy_Day01","oldMan_Day02","richGirl_Day02","poorGuy_Day02",]
@export var completed_list = [false,false,false,false,false,false,]

func load_level_data():
	for i in range(len(level_list)):
		if completed_list[i] == false:
			return level_list[i]

func level_complete(level_name: String) -> void:
	for i in range(len(level_list)):
		if level_name == level_list[i]:
			completed_list[i] = true

func reset_level_data() -> void:
	completed_list = [false,false,false,false,false,false,]
