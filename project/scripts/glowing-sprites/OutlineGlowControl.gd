class_name OutlineGlowControl
extends Sprite2D

# Properties.
@export var _opacity_key: String = "outline_opacity";

# Runtime variable data.
var _duped_mat: Material = null;
var _duped_shader_mat: ShaderMaterial = null;

func _ready() -> void:
	_duped_mat = material.duplicate();
	material = _duped_mat;
	_duped_shader_mat = _duped_mat as ShaderMaterial;

func set_outline_opacity(v: float) -> void:
	_duped_shader_mat.set_shader_parameter(_opacity_key, v);
