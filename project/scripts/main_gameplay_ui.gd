extends Control

@export var _rune_picker: Control = null;

func _on_drop_area_rune_on_filled_amount(amount: int) -> void:
	_rune_picker.visible = amount > 0;
