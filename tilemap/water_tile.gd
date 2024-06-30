extends StaticBody2D


@export var max_water_amount = 20
var water_amount = max_water_amount
var player
var field_tile = preload("res://tilemap/field_tile.tscn")

func grow_cattail():
	$Plant.visible = true
	for i in range(2):
		await get_tree().create_timer(2).timeout
		$Plant.frame += 1

func _ready():
	var rng = RandomNumberGenerator.new()
	player = get_tree().get_nodes_in_group("player")[0]
	$Label.text = str(water_amount)
	$Sprite2D.flip_h = rng.randi() % 2
	$Sprite2D.flip_v = rng.randi() % 2


func _unhandled_input(_event):
	if Input.is_action_pressed("left_click"):
		if $Frame.visible:			
			if GameManager.water_amount + 1 <= GameManager.max_water_amount and GameManager.can_suck:
				$SuckSound.play()
				$SuckParticle.emitting = true
				GameManager.change_water_amount(1)
				water_amount -= 1
				$Label.text = str(water_amount)
				if water_amount == 0:
					var instance = field_tile.instantiate()
					get_tree().root.add_child(instance)
					instance.position = position
					
					queue_free()
				GameManager.suck_water()


func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Label.visible = true
		$Frame.visible = true


func _on_mouse_exited():
	$Label.visible = false
	$Frame.visible = false
