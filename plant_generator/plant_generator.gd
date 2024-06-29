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
	if GameManager.plant_amount.potato_amount >= cattail_cost:
		GameManager.plant_amount.cattail_amount += 1
		GameManager.plant_amount.potato_amount -= cattail_cost

func buy_spiderplant():
	if GameManager.plant_amount.potato_amount >= spiderplant_cost:
		GameManager.plant_amount.spiderplant_amount += 1
		GameManager.plant_amount.potato_amount -= spiderplant_cost
