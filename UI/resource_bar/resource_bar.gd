extends Label

func change_text():
	text = "Potatoes: %s ; Cattails: %s ; Spiderplants: %s ;\n
	Quote: %s" % \
		[GameManager.potato_amount,
		GameManager.cattail_amount,
		GameManager.spiderplant_amount,
		GameManager.quote_potato_amount,
		GameManager.current_water_amount,
		GameManager.total_water_amount
		]
