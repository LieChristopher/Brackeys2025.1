class_name AudioManager
extends Node

# Constants.
const UNKNOWN_AUDIO: int = 0;
const BGM_AUDIO: int = 1;
const SFX_AUDIO: int = 2;

@export var _path_to_config: String = "res://project/resources/main_audio_config.tres";

# Runtime variable data.
var _config: AudioConfigData = null;
var _settings: Dictionary = {};
var _syncers: Dictionary = {};
var _temp_setting: UI_AudioSettings;
var _temp_syncer: AudioSyncer2D;

func _enter_tree() -> void:
	_config = ResourceLoader.load(_path_to_config);
	if not _config:
		print("Cannot load audio from path \"%s\"" % _path_to_config);
	_config.load_config();

func _exit_tree() -> void:
	_config.save_config();
	_settings.clear();

func get_config() -> AudioConfigData:
	if _config == null: _enter_tree();
	return _config;

func sync_settings() -> void:
	if _settings.size() == 0: return;
	for i in _settings.keys():
		_temp_setting = _settings[i] as UI_AudioSettings;
		_temp_setting.sync_with_config();

func sync(audio_type: int) -> void:
	if _syncers.size() == 0: return;
	for i in _syncers.keys():
		_temp_syncer = _syncers[i] as AudioSyncer2D;
		if audio_type == BGM_AUDIO:
			_temp_syncer.set_audio_volume(_config.get_master_volume() * _config.get_bgm_volume() / 10000.0);
		elif audio_type == SFX_AUDIO:
			_temp_syncer.set_audio_volume(_config.get_master_volume() * _config.get_sfx_volume() / 10000.0);
		else:
			_temp_syncer.set_audio_volume(_config.get_master_volume() / 100.0);

func register_audio_syncer(syncer: AudioSyncer2D) -> void:
	_syncers[syncer.get_instance_id()] = syncer;

func unregister_audio_syncer(syncer: AudioSyncer2D) -> void:
	if not _syncers.has(syncer.get_instance_id()): return;
	_syncers.erase(syncer.get_instance_id());

func register_audio_setting(setting: UI_AudioSettings) -> void:
	_settings[setting.get_instance_id()] = setting;

func unregister_audio_setting(setting: UI_AudioSettings) -> void:
	if not _settings.has(setting.get_instance_id()): return;
	_settings.erase(setting.get_instance_id());
