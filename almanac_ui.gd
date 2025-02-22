extends Control

var screenHidden = true;
var i = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AlmanacScreen.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_show_almanac_button_pressed() -> void:
	if screenHidden:
		$AlmanacScreen.show()
		screenHidden = false;
	else:
		$AlmanacScreen.hide()
		screenHidden = true;
	
	pass # Replace with function body.


func _on_next_pressed() -> void:
	print("next button cicked")
	if i < 4:
		i+=1
	$AlmanacScreen/TextureRect2.texture = load("res://project/arts/internal/sprites/almanac/Alamanac-"+str(i)+".png")
	pass # Replace with function body.



func _on_prev_pressed() -> void:
	print("prev button cicked")
	if i > 1:
		i-=1
	$AlmanacScreen/TextureRect2.texture = load("res://project/arts/internal/sprites/almanac/Alamanac-"+str(i)+".png")
	pass # Replace with function body.)
