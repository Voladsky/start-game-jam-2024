extends Label

var total_water_amount = 20
var current_water_amount = 0

func collect_water():
	if current_water_amount < total_water_amount:
		current_water_amount += total_water_amount


func spend_water():
	if current_water_amount > 0:
		current_water_amount = 0
