extends Node2D

var cattail_cost = 5
var spiderplant_cost = 5

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_T:
			buy_cattail()
		elif event.pressed && event.keycode == KEY_Y:
			buy_spiderplant()

func buy_cattail():
	if plant_amount.potato_amount >= cattail_cost:
		plant_amount.cattail_amount += 1
		plant_amount.potato_amount -= cattail_cost

func buy_spiderplant():
	if plant_amount.potato_amount >= spiderplant_cost:
		plant_amount.spiderplant_amount += 1
		plant_amount.potato_amount -= spiderplant_cost
