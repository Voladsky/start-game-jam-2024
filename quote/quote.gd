extends Node2D


func compare_to_quote():
	return GameManager.quote_potato_amount <= GameManager.potato_amount

func collect_potato():
	GameManager.potato_amount += 1
	
func take_quote():
	if !compare_to_quote():
		get_tree().quit()
	GameManager.potato_amount -= GameManager.quote_potato_amount
	GameManager.quote_potato_amount *= 2

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Q:
			collect_potato()
		if event.pressed and event.keycode == KEY_E:
			take_quote()
