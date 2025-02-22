extends Node2D

var customer:ShopCustomer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	customer = ShopCustomer.new()
	customer.code = "oldMan"
	customer.dialogue(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
