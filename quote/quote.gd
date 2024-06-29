extends Node2D

var quote_potato_amount = 30
var current_potato_amount = 0

@onready var label = $Label

func compare_to_quote():
	return quote_potato_amount <= current_potato_amount

func collect_potato():
	current_potato_amount += 1
	
func take_quote():
	if !compare_to_quote():
		get_tree().quit()
	current_potato_amount -= quote_potato_amount
	quote_potato_amount *= 2

func _process(delta):
	$Label.text = "%s/%s" % [current_potato_amount, quote_potato_amount]


func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Q:
			collect_potato()
		if event.pressed and event.keycode == KEY_E:
			take_quote()
