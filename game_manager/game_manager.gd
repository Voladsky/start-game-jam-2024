extends Node

signal amount_changed

var potato_amount = 10
var cattail_amount = 0
var spiderplant_amount = 0

var max_water_amount = 20
var water_amount = 0

var quote_potato_amount = 30
var can_suck = true

func suck_water():
	can_suck = false
	get_tree().create_timer(0.2).timeout.connect(func(): can_suck = true)

func change_quote_potato_amount(amount):
	if quote_potato_amount + amount >= 0:
		quote_potato_amount += amount
		amount_changed.emit()
		return true
	else:
		return false


func change_spiderplant_amount(amount):
	if spiderplant_amount + amount >= 0:
		spiderplant_amount += amount
		amount_changed.emit()
		return true
	else:
		return false


func change_cattail_amount(amount):
	if cattail_amount + amount >= 0:
		cattail_amount += amount
		amount_changed.emit()
		return true
	else:
		return false


func change_potato_amount(amount):
	if potato_amount + amount >= 0:
		potato_amount += amount
		amount_changed.emit()
		return true
	else:
		return false


func change_water_amount(amount):
	if water_amount + amount >= 0 and water_amount + amount <= max_water_amount:
		water_amount += amount
		amount_changed.emit()
		return true
	else:
		return false
