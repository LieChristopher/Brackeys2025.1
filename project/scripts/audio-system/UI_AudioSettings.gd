class_name UI_AudioSettings
extends Control

@export var _master_slider: Slider = null;
@export var _bgm_slider: Slider = null;
@export var _sfx_slider: Slider = null;

func on_master_slider_value_changed(v: float) -> void:
	# TODO: Live audio changed.
	pass;

func on_bgm_slider_value_changed(v: float) -> void:
	# TODO: Live audio changed.
	pass;

func on_sfx_slider_value_changed(v: float) -> void:
	# TODO: Live audio changed.
	pass;

func _on_master_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(_master_slider.value));

func _on_bgm_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(_bgm_slider.value));

func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(_sfx_slider.value));

#func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	#AudioServer.set_bus_volume_db(0,linear_to_db($MarginContainer2/VBoxContainer/VolumeSlider.value))
