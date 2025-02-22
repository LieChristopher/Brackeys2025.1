extends Area2D

var array = []

func _on_area_entered(area: Area2D) -> void:
	print("Ingredient entered area and is added to array")
	array.append(area.name)
	print(self.name,"area currently has nodes",array)
	
	#get filepath of dragged ingredient
	#print("filepath for ingredient  entered into array:",area.get_node("Sprite").texture.resource_path)
	
	#change sprite of current ingredient
	#area.get_node("Sprite").texture= load("res://project/arts/external/Images/Ingredients/Poison Ivy.png")
	
	 #queuefree messes with pointercontroller2d
	#area.queue_free()
	#area.get_node("CollisionShape2D").queue_free()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	array.clear();
	print(self.name,"ARRAY CLEARED!",array)
	pass # Replace with function body.
