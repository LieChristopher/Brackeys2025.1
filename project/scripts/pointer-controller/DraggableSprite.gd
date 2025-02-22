class_name DraggableSprite
extends PointableSprite

signal on_drag_begin(pos: Vector2);
signal on_drag_end(pos: Vector2);

#https://www.youtube.com/watch?v=3ThOxFZcie0
var _is_dragging = false;
var of = Vector2(0,0);
var initial =Vector2(0,0);

func _ready() -> void:
	initial = self.position;

func _process(delta: float) -> void:
	if _is_dragging:
		position = get_global_mouse_position() - of;

func _on_pressed(pos: Vector2) -> void:
	super(pos);
	_is_dragging = true;
	of = pos - position;
	on_drag_begin.emit(pos);

func _on_released(pos: Vector2) -> void:
	super(pos);
	_is_dragging = false;
	self.position = initial;
	on_drag_end.emit(pos);

func is_dragging() -> bool:
	return _is_dragging;
