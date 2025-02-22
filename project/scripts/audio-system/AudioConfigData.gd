class_name AudioConfigData
extends Resource

const MASTER_KEY = "master";
const BGM_KEY = "bgm";
const SFX_KEY = "sfx";

@export var _save_path: String = "user://audio-settings.json";

@export var _master_v: float = 50;
@export var _bgm_v: float = 50;
@export var _sfx_v: float = 50;

# Runtime variable data.
var _audio_manager: AudioManager = null;
var _formatted: Dictionary = {};
var _temp_str: String;

func set_master_volume(v: float) -> void:
	_master_v = v;

func get_master_volume() -> float:
	return _master_v;

func set_bgm_volume(v: float) -> void:
	_bgm_v = v;

func get_bgm_volume() -> float:
	return _bgm_v;

func set_sfx_volume(v: float) -> void:
	_sfx_v = v;

func get_sfx_volume() -> float:
	return _sfx_v;

func save_config() -> void:
	if _audio_manager == null:
		_audio_manager = audio_manager as AudioManager;
	_sync_to_format();
	_temp_str = JSON.stringify(_formatted);
	var f: FileAccess = FileAccess.open(_save_path, FileAccess.WRITE);
	f.store_string(_temp_str);
	_audio_manager.sync_settings();
	f.close();

func load_config() -> void:
	if _audio_manager == null:
		_audio_manager = audio_manager as AudioManager;
	var f: FileAccess = FileAccess.open(_save_path, FileAccess.READ_WRITE);
	if f:
		_temp_str = f.get_as_text();
		_formatted = JSON.parse_string(_temp_str);
		_sync_from_format();
		_audio_manager.sync_settings();
		f.close();
	else:
		print("Failed to load data from \"%s\"" % _save_path);
		save_config();

func _sync_to_format() -> void:
	_formatted[MASTER_KEY] = _master_v;
	_formatted[BGM_KEY] = _bgm_v;
	_formatted[SFX_KEY] = _sfx_v;

func _sync_from_format() -> void:
	_master_v = _formatted[MASTER_KEY];
	_bgm_v = _formatted[BGM_KEY];
	_sfx_v = _formatted[SFX_KEY];
