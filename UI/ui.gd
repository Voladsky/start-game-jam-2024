extends CanvasLayer


@onready var potato_label = $Resources/HBoxContainer2/HBoxContainer/Potato/Label
@onready var cattail_label = $Resources/HBoxContainer2/HBoxContainer/Cattail/Label
@onready var spider_plant_label = $Resources/HBoxContainer2/HBoxContainer/SpiderPlant/Label
@onready var water_label = $Resources/HBoxContainer2/Water/Water
@onready var time_label = $Resources/HBoxContainer2/Time/Label
@onready var qouta_bar = $Resources/VBoxContainer/MarginContainer/Qouta
@onready var qouta_label = $Resources/VBoxContainer/Label
@onready var timer = $Timer

var sacrifice = preload("res://item_drop/sacrifice.tscn")
var player 

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	GameManager.amount_changed.connect(change_text)
	change_text()
	qouta_bar.max_value = GameManager.max_quota_amount
	qouta_label.text = "Норма картошки: %s" % GameManager.max_quota_amount
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
		get_tree().get_nodes_in_group("player")[0].gameover = true
		get_tree().get_nodes_in_group("player")[0].get_node("CollisionShape2D").disabled = true
		GameManager.reset()
		return
	
	GameManager.potato_amount -= GameManager.max_quota_amount
	
	GameManager.max_qouta_time += GameManager.max_qouta_time*0.1
	GameManager.max_quota_amount *= 1.5
	
	qouta_label.text = "Норма картошки: %s" % GameManager.max_quota_amount
	qouta_bar.max_value = GameManager.max_quota_amount
	change_text()
	
	timer.start(GameManager.max_qouta_time)
	
	
	for i in range(GameManager.max_quota_amount):
		var sacrifice_instance = sacrifice.instantiate()
		sacrifice_instance.position = player.position + Vector2(randf_range(-16, 16), randf_range(-16, 16))
		get_tree().get_root().add_child(sacrifice_instance)
		await get_tree().create_timer(0.1).timeout


func _on_button_pressed():
	get_tree().reload_current_scene()
