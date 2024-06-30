extends Area2D

@export var cattail_cost = 5
@export var spiderplant_cost = 10

@onready var cattail_cost_label = $UI/UI/Cattail/Cost
@onready var spiderplant_cost_label = $UI/UI/SpiderPlant/Cost

func _ready():
	cattail_cost_label.text = "%s к" % cattail_cost
	spiderplant_cost_label.text = "%s к" % spiderplant_cost

func _process(_delta):
	if has_overlapping_bodies():
		if Input.is_action_just_pressed("interact"):
			if $UI.visible:
				$UI.visible = false
				$E.visible = true
			else:
				$UI.visible = true
				$E.visible = false


func _on_body_entered(_body):
	$E.visible = true


func _on_body_exited(_body):
	$E.visible = false
	$UI.visible = false


func _on_cattail_pressed():
	if GameManager.change_potato_amount(-cattail_cost):
		$Buy.play()
		GameManager.change_cattail_amount(1)


func _on_spider_plant_pressed():
	if GameManager.change_potato_amount(-spiderplant_cost):
		$Buy.play()
		GameManager.change_spiderplant_amount(1)
