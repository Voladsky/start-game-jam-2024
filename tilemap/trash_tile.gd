extends StaticBody2D

@export var trash_health = 10
var player
var can_dig = true
var field_tile = preload("res://tilemap/field_tile.tscn")

func grow_cattail():
	$Plant.visible = true
	for i in range(2):
		await get_tree().create_timer(2).timeout
		$Plant.frame += 1

func _ready():
	var rng = RandomNumberGenerator.new()
	player = get_tree().get_nodes_in_group("player")[0]
	$Label.text = str(trash_health)
	$Sprite2D.flip_h = rng.randi() % 2
	$Sprite2D.flip_v = rng.randi() % 2

func _process(_event):
	if Input.is_action_pressed("left_click"):
		if $Frame.visible and can_dig:
			trash_health -= 1
			$Label.text = str(trash_health)
			if trash_health == 0:
				can_dig = false
				var instance = field_tile.instantiate()
				get_tree().get_root().get_node("World").add_child(instance)
				instance.position = position
				queue_free()
			else:
				can_dig = false
				var timer = get_tree().create_timer(0.2)
				timer.timeout.connect(Callable(self, "_on_timer_timeout"))

func _on_timer_timeout():
	can_dig = true

func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Label.visible = true
		$Frame.visible = true

func _on_mouse_exited():
	$Label.visible = false
	$Frame.visible = false
