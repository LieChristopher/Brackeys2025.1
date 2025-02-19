class_name DraggableSprite
extends PointableSprite

#https://www.youtube.com/watch?v=3ThOxFZcie0
var dragging = false;
var of = Vector2(0,0);

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of;
	
func _on_pressed(pos: Vector2) -> void:
	super(pos);
	dragging = true;
	of = get_global_mouse_position() - global_position;
	
func _on_released(pos: Vector2) -> void:
	super(pos);
	dragging = false;
	
