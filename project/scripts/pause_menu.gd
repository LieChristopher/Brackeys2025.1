extends Control

var hidden_menu = true
var paused =false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuScreen.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pause_button_pressed() -> void:
	if hidden_menu == true:
		$MenuScreen.show();
		hidden_menu = false;
		$"Pause Button".hide();
		
	print("Game Paused")
	paused = true;
	get_tree().paused=true;
	#$"Pause Button/GamePausedText".visible = true
	#$"Pause Button/GamePausedMenu".visible = true
	pass # Replace with function body.

func _on_unpause_button_pressed() -> void:
	print("Game Continued")
	paused = false;
	get_tree().paused=false;
	#$"Pause Button/GamePausedText".visible = false
	#$"Pause Button/GamePausedMenu".visible = false
	
	$MenuScreen.hide();
	$"Pause Button".show();
	hidden_menu = true;
	pass # Replace with function body.
