class_name PointableSprite
extends Area2D

signal on_pressed(pos: Vector2);
signal on_tapped(pos: Vector2);
signal on_hovered_enter();
signal on_hovered_runtime(pos: Vector2);
signal on_hovered_exit();
signal on_released(pos: Vector2);
signal on_enabled();
signal on_disabled();

# Properties.
@export var _cancel_tap_threshold: float = 0.33;
@export var _is_enabled: bool = true;

# Optionals.
@export var _tinted_sprites: Array[PointerTintColoredSprite] = [];

# Debugging.
@export_category("DEBUG")
@export var _debug_print: bool = false;

# Runtime variable data.
var _cached_press_position: Vector2;
var _tap_seconds: float = 0.0;
var _is_pressed: bool = false;
var _is_hovered: bool = false;

func _ready() -> void:
	if _is_enabled: on_enabled.emit();
	else: on_disabled.emit();

func _process(delta: float) -> void:
	if !_is_pressed: return;
	_tap_seconds += delta;

func _on_pressed(pos: Vector2) -> void:
	if !_is_enabled: return;
	_cached_press_position = pos;
	_tap_seconds = 0.0;
	_is_pressed = true;
	on_pressed.emit(pos);
	var sz: int = _tinted_sprites.size();
	for i in range(0, sz):
		_tinted_sprites[i].set_pressed_tint(self);
	if _debug_print: print("Pressed: {s}".format({"s": name}));

func _on_released(pos: Vector2) -> void:
	if !_is_enabled: return;
	_is_pressed = false;
	if _tap_seconds <= _cancel_tap_threshold:
		on_tapped.emit(pos);
		if _debug_print: print("Tapped: {s}".format({"s": name}));
	on_released.emit(pos);
	var sz: int = _tinted_sprites.size();
	for i in range(0, sz):
		_tinted_sprites[i].set_normal_tint(self);
	if _debug_print: print("Released: {s}".format({"s": name}));

func _on_hover_enter() -> void:
	if !_is_enabled: return;
	_is_hovered = true;
	on_hovered_enter.emit();
	if _debug_print: print("Entered: {s}".format({"s": name}));

func _on_hover_exit() -> void:
	if !_is_enabled: return;
	_is_hovered = false;
	on_hovered_exit.emit();
	if _debug_print: print("Exited: {s}".format({"s": name}));

func _on_hover_update(pos: Vector2) -> void:
	if !_is_enabled: return;
	on_hovered_runtime.emit(pos);
	if _debug_print: print("Hovering: {s}".format({"s": name}));

func set_enable(enable: bool) -> void:
	if _is_enabled == enable: return;
	_is_enabled = enable;
	if _is_enabled:
		on_enabled.emit();
		var sz: int = _tinted_sprites.size();
		for i in range(0, sz):
			_tinted_sprites[i].set_normal_tint(self);
	else:
		if _is_pressed:
			_is_pressed = false;
			on_released.emit(_cached_press_position);
		if _is_hovered:
			_is_hovered = false;
			on_hovered_exit.emit();
		on_disabled.emit();
		var sz: int = _tinted_sprites.size();
		for i in range(0, sz):
			_tinted_sprites[i].set_disabled_tint(self);
