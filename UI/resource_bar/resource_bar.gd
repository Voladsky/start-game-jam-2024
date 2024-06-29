extends Label

@onready var quote = $"../../Quote"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Potatoes: %s ; Cattails: %s ; Spiderplants: %s ;\n
	Quote: %s" % \
		[plant_amount.potato_amount, 
		 plant_amount.cattail_amount,
		 plant_amount.spiderplant_amount,
		 quote.quote_potato_amount
		]
	pass
