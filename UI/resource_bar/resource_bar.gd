extends Label

@onready var quote = $"../../Quote"

func _process(_delta):
	text = "Potatoes: %s ; Cattails: %s ; Spiderplants: %s ;\n
	Quote: %s" % \
		[GameManager.potato_amount, 
		 GameManager.cattail_amount,
		 GameManager.spiderplant_amount,
		 GameManager.quote_potato_amount
		]
