class_name UI_BrushSizer
extends Control

# Requirements
@export var _brush_target: UI_DrawingPaper = null;
@export var _slider: Slider = null;

@export_group("Optionals")
@export var _value_hint: RichTextLabel = null;

func _ready() -> void:
	_value_hint.text = "%d" % _slider.value;

func _on_slider_changed(value: float) -> void:
	_brush_target.set_brush_size(value);
	if _value_hint == null: return;
	_value_hint.text = "%d" % value;
