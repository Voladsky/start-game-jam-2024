extends CanvasLayer


@onready var potato_label = $Resources/HBoxContainer2/HBoxContainer/Potato/Label
@onready var cattail_label = $Resources/HBoxContainer2/HBoxContainer/Cattail/Label
@onready var spider_plant_label = $Resources/HBoxContainer2/HBoxContainer/SpiderPlant/Label
@onready var water_label = $Resources/HBoxContainer2/Water/Water
@onready var time_label = $Resources/HBoxContainer2/Time/Label
@onready var qouta_bar = $Resources/VBoxContainer/MarginContainer/Qouta
@onready var qouta_label = $Resources/VBoxContainer/Label
@onready var timer = $Timer

@export var coef = 0.25

func _ready():
	GameManager.amount_changed.connect(change_text)
	change_text()
	qouta_bar.max_value = GameManager.max_quota_amount
	qouta_label.text = "Квота картошки: %s" % GameManager.max_quota_amount
	timer.start(GameManager.max_qouta_time)


func _process(_delta):
	time_label.text = str(int(timer.time_left))


func change_text():
	potato_label.text = str(GameManager.potato_amount)
	cattail_label.text = str(GameManager.cattail_amount)
	spider_plant_label.text = str(GameManager.spiderplant_amount)
	
	
	water_label.text = "%s/%s" % \
		[
		GameManager.water_amount,
		GameManager.max_water_amount
		]

	qouta_bar.value = GameManager.potato_amount


func _on_timer_timeout():
	if GameManager.quota_amount < GameManager.max_quota_amount:
		print("bruh")
		return
	
	GameManager.potato_amount -= GameManager.max_quota_amount
	
	GameManager.max_qouta_time += GameManager.max_qouta_time*0.1
	GameManager.max_qouta_amount *= 1.5

	timer.start()
