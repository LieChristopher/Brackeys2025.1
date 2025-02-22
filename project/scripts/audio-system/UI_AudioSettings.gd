class_name UI_AudioSettings
extends Control

@export var _master_slider: UI_AudioSlider = null;
@export var _bgm_slider: UI_AudioSlider = null;
@export var _sfx_slider: UI_AudioSlider = null;

# Runtime variable data.
var _audio_manager: AudioManager = null;
var _config: AudioConfigData = null;

func _enter_tree() -> void:
	_audio_manager = audio_manager as AudioManager;
	_audio_manager.register_audio_setting(self);
	_config = _audio_manager.get_config();

func _exit_tree() -> void:
	_audio_manager.unregister_audio_setting(self);

func on_master_slider_value_changed(_v: float) -> void:
	if _config == null: _config = _audio_manager.get_config();
	_config.set_master_volume(_master_slider.get_percentage() * 100.0);
	_audio_manager.sync(AudioManager.UNKNOWN_AUDIO);

func on_bgm_slider_value_changed(_v: float) -> void:
	if _config == null: _config = _audio_manager.get_config();
	_config.set_bgm_volume(_bgm_slider.get_percentage() * 100.0);
	_audio_manager.sync(AudioManager.BGM_AUDIO);

func on_sfx_slider_value_changed(_v: float) -> void:
	if _config == null: _config = _audio_manager.get_config();
	_config.set_sfx_volume(_sfx_slider.get_percentage() * 100.0);
	_audio_manager.sync(AudioManager.SFX_AUDIO);

func _on_master_slider_drag_ended(value_changed: bool) -> void:
	if not value_changed: return;
	if _config == null: _config = _audio_manager.get_config();
	_config.set_master_volume(_master_slider.get_percentage() * 100.0);
	_audio_manager.sync(AudioManager.UNKNOWN_AUDIO);
	_config.save_config();

func _on_bgm_slider_drag_ended(value_changed: bool) -> void:
	if not value_changed: return;
	if _config == null: _config = _audio_manager.get_config();
	_config.set_bgm_volume(_bgm_slider.get_percentage() * 100.0);
	_audio_manager.sync(AudioManager.BGM_AUDIO);
	_config.save_config();

func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	if not value_changed: return;
	if _config == null: _config = _audio_manager.get_config();
	_config.set_sfx_volume(_sfx_slider.get_percentage() * 100.0);
	_audio_manager.sync(AudioManager.SFX_AUDIO);
	_config.save_config();

func sync_with_config() -> void:
	_master_slider.set_percentage(_config.get_master_volume() / 100.0);
	_bgm_slider.set_percentage(_config.get_bgm_volume() / 100.0);
	_sfx_slider.set_percentage(_config.get_sfx_volume() / 100.0);

#func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	#AudioServer.set_bus_volume_db(0,linear_to_db($MarginContainer2/VBoxContainer/VolumeSlider.value))
