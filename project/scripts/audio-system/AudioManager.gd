extends Node

@export var _path_to_config: String = "res://project/resources/main_audio_config.tres";

# Runtime variable data.
var _config: AudioConfigData = null;

func _enter_tree() -> void:
	_config = ResourceLoader.load(_path_to_config);
	if not _config:
		print("Cannot load audio from path \"%s\"" % _path_to_config);
