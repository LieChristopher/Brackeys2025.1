class_name AudioConfigData
extends Resource

@export var _master_v: float = 0.0;
@export var _bgm_v: float = 0.0;
@export var _sfx_v: float = 0.0;

func set_master_volume(v: float) -> void:
	_master_v = v;

func get_master_volume() -> float:
	return _master_v;
