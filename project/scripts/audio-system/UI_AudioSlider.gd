class_name UI_AudioSlider
extends Slider

func get_percentage() -> float:
	return (value - min_value) / (max_value - min_value);

func set_percentage(percent: float) -> void:
	value = min_value + (percent * (max_value - min_value));
