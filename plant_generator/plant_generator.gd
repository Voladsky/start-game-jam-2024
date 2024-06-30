extends Area2D

@export var cattail_cost = 5
@export var spiderplant_cost = 10

@onready var cattail_cost_label = $UI/UI/Cattail/Cost
@onready var spiderplant_cost_label = $UI/UI/SpiderPlant/Cost

func _ready():
	cattail_cost_label.text = "%s к" % cattail_cost
	spiderplant_cost_label.text = "%s к" % spiderplant_cost


func _on_body_entered(_body):
	$UI.visible = true


func _on_body_exited(_body):
	$UI.visible = false


func _on_cattail_pressed():
	if GameManager.change_potato_amount(-cattail_cost):
		$Buy.play()
		GameManager.change_cattail_amount(1)


func _on_spider_plant_pressed():
	if GameManager.change_potato_amount(-spiderplant_cost):
		$Buy.play()
		GameManager.change_spiderplant_amount(1)
