extends Node2D

var quote_potato_amount = 30

func compare_to_quote():
	return quote_potato_amount <= plant_amount.potato_amount

func collect_potato():
	plant_amount.potato_amount += 1
	
func take_quote():
	if !compare_to_quote():
		get_tree().quit()
	plant_amount.potato_amount -= quote_potato_amount
	quote_potato_amount *= 2

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Q:
			collect_potato()
		if event.pressed and event.keycode == KEY_E:
			take_quote()
