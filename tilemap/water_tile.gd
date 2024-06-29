extends StaticBody2D


@export var max_water_amount = 20
var water_amount = max_water_amount

var can_suck = true
var player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	$Label.text = str(water_amount)

func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("left_click"):
		if (player.position - position).length() < 128:
			if GameManager.water_amount + 1 <= GameManager.max_water_amount and can_suck:
				GameManager.change_water_amount(1)
				water_amount -= 1
				$Label.text = str(water_amount)
				can_suck = false
				if water_amount == 0:
					queue_free()
				get_tree().create_timer(0.2).timeout.connect(func(): can_suck = true)


func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Label.visible = true
		$Frame.visible = true


func _on_mouse_exited():
	$Label.visible = false
	$Frame.visible = false
