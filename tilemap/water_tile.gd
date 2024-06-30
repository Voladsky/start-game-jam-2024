extends StaticBody2D

@export var max_water_amount = 20
var water_amount = max_water_amount
var player
var field_tile = preload("res://tilemap/field_tile.tscn")

var can_suck = true

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

func _process(_delta):
	if Input.is_action_pressed("left_click") and can_suck:
		if $Frame.visible:
			if GameManager.water_amount + 1 <= GameManager.max_water_amount:
				if not $SuckSound.playing:
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
				can_suck = false
				GameManager.suck_water()
				var timer = get_tree().create_timer(0.2)
				timer.timeout.connect(Callable(self, "_on_timer_timeout"))

func _on_timer_timeout():
	can_suck = true

func _unhandled_input(_event):
	if Input.is_action_just_released("left_click"):
		$SuckSound.stop()
		$SuckParticle.emitting = false

func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Label.visible = true
		$Frame.visible = true

func _on_mouse_exited():
	$Label.visible = false
	$Frame.visible = false
