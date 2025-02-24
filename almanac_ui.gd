extends Control

@export var _content: Control = null;
@export var _recipe_book: TextureRect = null;
@export var _page_hint_txt: RichTextLabel = null;
@export var _formatted_text: String = "";

# Runtime variable data.
var screenHidden: bool = true;
var i: int = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_content.hide()

func _on_show_almanac_button_pressed() -> void:
	if screenHidden: _content.show()
	else: _content.hide()
	screenHidden = !screenHidden;
	_page_hint_txt.text = _formatted_text.format({
		"c": i, "p": 4});

func _on_next_pressed() -> void:
	print("next button cicked");
	if i < 4: i += 1;
	_recipe_book.texture = load("res://project/arts/internal/sprites/almanac/Alamanac-"+str(i)+".png")
	_page_hint_txt.text = _formatted_text.format({
		"c": i, "p": 4});

func _on_prev_pressed() -> void:
	print("prev button cicked");
	if i > 1: i -= 1;
	_recipe_book.texture = load("res://project/arts/internal/sprites/almanac/Alamanac-"+str(i)+".png")
	_page_hint_txt.text = _formatted_text.format({
		"c": i, "p": 4});
