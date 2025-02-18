class_name UI_DrawingPaper
extends TextureRect

const CIRCLE_BRUSH: String = "Circle";
const SQUARE_BRUSH: String = "Square";

# Properties
@export var _save_path: String = "";

@export_group("Drawing Utilities")
@export_enum(CIRCLE_BRUSH, SQUARE_BRUSH)
var _brush_mode: String = SQUARE_BRUSH;
@export var _brush_size: int = 4;
@export var _brush_color: Color = Color.WHITE;

# Runtime variable data.
var _cached_previous_point: Vector2;
var _image_canvas: Image = null;
var _texture_obj: ImageTexture = null;
var _event_mouse_btn: InputEventMouseButton = null;
var _event_mouse_mot: InputEventMouseMotion = null;
var _is_drawing: bool = false;
var _is_first_drawn: bool = false;

func _ready() -> void:
	_image_canvas = Image.create(size.x, size.y, false, Image.Format.FORMAT_RGB8);
	_image_canvas.fill(Color.WHITE);
	_texture_obj = ImageTexture.create_from_image(_image_canvas);
	texture = _texture_obj;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_event_mouse_btn = event as InputEventMouseButton;
		if _event_mouse_btn.button_index != MOUSE_BUTTON_LEFT: return;
		if _event_mouse_btn.is_pressed():
			_on_draw_pressed(event.position);
		if _event_mouse_btn.is_released():
			_on_draw_released(event.position);
	if event is InputEventMouseMotion and _is_drawing:
		_event_mouse_mot = event as InputEventMouseMotion;
		_on_draw_dragged(_event_mouse_mot.position);

func _on_draw_pressed(pos: Vector2) -> void:
	_is_drawing = true;
	draw_circle_at(pos);
	_is_first_drawn = true;

func _on_draw_released(pos: Vector2) -> void:
	_is_drawing = false;

func _on_draw_dragged(pos: Vector2) -> void:
	draw_circle_at(pos);

func draw_circle_at(pos: Vector2) -> void:
	var local_pos: Vector2 = pos - global_position;
	var half_brush_size: int = _brush_size / 2;
	
	# Define start point.
	var x: int = int(local_pos.x) - half_brush_size;
	var y: int = int(local_pos.y) - half_brush_size;
	var px: int; var py: int;
	
	match _brush_mode:
		SQUARE_BRUSH:
			for nx in range(0, _brush_size):
				for ny in range(0, _brush_size):
					px = x + nx;
					py = y + ny;
					if px < 0 or py < 0: return;
					if px >= _image_canvas.get_width(): return;
					if py >= _image_canvas.get_height(): return;
					_image_canvas.set_pixel(px, py, _brush_color);
		CIRCLE_BRUSH:
			for nx in range(0, _brush_size):
				for ny in range(0, _brush_size):
					pass;
	_texture_obj.update(_image_canvas);

func set_brush_color(color: Color) -> void:
	_brush_color = color;

func set_brush_size(sz: int) -> void:
	_brush_size = sz;

func save_image() -> void:
	_image_canvas.save_png(_save_path);
