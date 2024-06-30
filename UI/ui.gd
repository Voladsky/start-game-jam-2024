extends CanvasLayer


@onready var potato_label = $Resources/HBoxContainer/Potato/Label
@onready var cattail_label = $Resources/HBoxContainer/Cattail/Label
@onready var spider_plant_label = $Resources/HBoxContainer/SpiderPlant/Label

func _ready():
	GameManager.amount_changed.connect(change_text)
	change_text()


func change_text():
	potato_label.text = str(GameManager.potato_amount)
	cattail_label.text = str(GameManager.cattail_amount)
	spider_plant_label.text = str(GameManager.spiderplant_amount)
	
	
	$Resources/VBoxContainer/Water.text = "%s/%s" % \
		[
		GameManager.water_amount,
		GameManager.max_water_amount
		]
