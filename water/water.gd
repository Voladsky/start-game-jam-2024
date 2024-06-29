extends Node2D

var total_water_amount = 20
var current_water_amount = 0

@onready var label = $Label

func collect_water():
	if current_water_amount < total_water_amount:
		current_water_amount += total_water_amount


func spend_water():
	if current_water_amount > 0:
		current_water_amount = 0


func _process(delta):
	$Label.text = "Water: %s/%s" % [current_water_amount, total_water_amount]


func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F:
			collect_water()
		if event.pressed and event.keycode == KEY_G:
			spend_water()
