extends CanvasLayer

func _ready():
	GameManager.amount_changed.connect(change_text)


func change_text():
	$Resources/ResourceBar.text = "Potatoes: %s ; Cattails: %s ; Spiderplants: %s ;\n
	Quote: %s" % \
		[
		GameManager.potato_amount,
		GameManager.cattail_amount,
		GameManager.spiderplant_amount,
		GameManager.quote_potato_amount,
		]
	
	$Resources/VBoxContainer/Water.text = "%s/%s" % \
		[
		GameManager.water_amount,
		GameManager.max_water_amount
		]
