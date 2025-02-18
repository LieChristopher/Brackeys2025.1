class_name PointerControl2D
extends Node

signal on_pointer_pressed(pos: Vector2, detected_contents: Array[Dictionary]);
signal on_pointer_released(pos: Vector2, detected_contents: Array[Dictionary]);
signal on_pointer_hovered(pos: Vector2, detected_contents: Array[Dictionary], pressed: bool);

# Variables.
@export var _pointer_pressed_method_name: String = "_on_pressed";
@export var _pointer_released_method_name: String = "_on_released";
@export var _pointer_hover_enter_method_name: String = "_on_hover_enter";
@export var _pointer_hover_exit_method_name: String = "_on_hover_exit";
@export var _pointer_hover_runtime_method_name: String = "_on_hover_update";

# Runtime variable data.
var _root: Window = null;
var _cached_pointer: Array[Dictionary];
var _cached_pointer_runtime: Array[Dictionary];
var _cached_element: Dictionary;
var _cached_pointer_hovered: Dictionary = {};
var _cached_pointer_hovered_temp: Dictionary = {};
var _point_query_2d: PhysicsPointQueryParameters2D = null;
var _space_state_2d: PhysicsDirectSpaceState2D = null;
var _mouse_event: InputEventMouse = null;
var _pressed: bool = false;

func _enter_tree() -> void:
	_root = get_tree().root;

func _input(event: InputEvent) -> void:
	if event is not InputEventMouse: return;
	_mouse_event = event as InputEventMouse;
	if _mouse_event is InputEventMouseButton:
		_on_mouse_button(_mouse_event as InputEventMouseButton);
	elif _mouse_event is InputEventMouseMotion:
		_on_mouse_motion(_mouse_event as InputEventMouseMotion);

func _on_mouse_button(e: InputEventMouseButton) -> void:
	if e.button_index != MOUSE_BUTTON_LEFT: return;
	if e.is_pressed(): _on_pointer_pressed(e.global_position);
	elif e.is_released(): _on_pointer_released(e.global_position);

func _on_mouse_motion(e: InputEventMouseMotion) -> void:
	_cached_pointer_runtime = _get_pointer_intersect(e.global_position);
	_cached_pointer_hovered_temp.clear();
	var sz: int = _cached_pointer_runtime.size();
	for i in range(0, sz):
		_cached_element = _cached_pointer_runtime[i];
		_cached_pointer_hovered_temp[_cached_element.collider_id] = _cached_element.collider;
		if _cached_pointer_hovered.has(_cached_element.collider_id): continue;
		_cached_pointer_hovered[_cached_element.collider_id] = _cached_element.collider;
		if _cached_element.collider.has_method(_pointer_hover_enter_method_name):
			_cached_element.collider.call(_pointer_hover_enter_method_name);
	for j in _cached_pointer_hovered.keys():
		if _cached_pointer_hovered_temp.has(j):
			if _cached_pointer_hovered[j].has_method(_pointer_hover_runtime_method_name):
				_cached_pointer_hovered[j].call(_pointer_hover_runtime_method_name, e.global_position);
			continue;
		if _cached_pointer_hovered[j].has_method(_pointer_hover_exit_method_name):
			_cached_pointer_hovered[j].call(_pointer_hover_exit_method_name);
		_cached_pointer_hovered.erase(j);

func _on_pointer_pressed(pos: Vector2) -> void:
	_cached_pointer = _get_pointer_intersect(pos);
	var sz: int = _cached_pointer.size();
	for i in range(0, sz):
		_cached_element = _cached_pointer[i];
		if _cached_element.collider.has_method(_pointer_pressed_method_name):
			_cached_element.collider.call(_pointer_pressed_method_name, pos);
	_pressed = true;
	on_pointer_pressed.emit(pos, _cached_pointer);

func _on_pointer_released(pos: Vector2) -> void:
	var sz: int = _cached_pointer.size();
	for i in range(0, sz):
		_cached_element = _cached_pointer[i];
		if _cached_element.collider.has_method(_pointer_released_method_name):
			_cached_element.collider.call(_pointer_released_method_name, pos);
	_pressed = false;
	on_pointer_released.emit(pos, _cached_pointer);

func _get_pointer_intersect(pos: Vector2) -> Array[Dictionary]:
	_space_state_2d = _root.world_2d.direct_space_state;
	_point_query_2d = PhysicsPointQueryParameters2D.new();
	_point_query_2d.position = pos;
	_point_query_2d.collide_with_areas = true;
	_point_query_2d.collide_with_bodies = true;
	return _space_state_2d.intersect_point(_point_query_2d);
