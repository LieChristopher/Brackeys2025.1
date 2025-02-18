class_name PointerTintColoredSprite
extends Resource

@export var _target: NodePath;
@export var _normal_tint: Color = Color.WHITE;
@export var _pressed_tint: Color = Color.GRAY;
@export var _disabled_tint: Color = Color.DIM_GRAY;

# Runtime variable data.
var _temp_node: Node = null;
var _temp_canvas: CanvasItem = null;

func set_normal_tint(root: Node) -> void:
	_temp_canvas = _get_canvas_item(root, _target);
	if _temp_canvas == null: return;
	_temp_canvas.self_modulate = _normal_tint;

func set_pressed_tint(root: Node) -> void:
	_temp_canvas = _get_canvas_item(root, _target);
	if _temp_canvas == null: return;
	_temp_canvas.self_modulate = _pressed_tint;

func set_disabled_tint(root: Node) -> void:
	_temp_canvas = _get_canvas_item(root, _target);
	if _temp_canvas == null: return;
	_temp_canvas.self_modulate = _disabled_tint;

func _get_canvas_item(root: Node, path: NodePath) -> CanvasItem:
	_temp_node = root.get_node(path);
	if _temp_node == null: return null;
	if _temp_node is not CanvasItem: return null;
	return _temp_node as CanvasItem;
