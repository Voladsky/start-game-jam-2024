extends Area2D

var player
var field

func _ready():
	$Plant.play()
	player = get_tree().get_nodes_in_group("player")[0]
	field = preload("res://tilemap/field_tile.tscn")
	if $Sprite2D.frame != 2:
		for i in range(2):
			await get_tree().create_timer(2).timeout
			$Sprite2D.frame += 1
			$GrowingParticle.emitting = true

func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Frame.visible = true

func _on_mouse_exited():
	$Frame.visible = false
	
func _unhandled_input(_event):
	if Input.is_action_pressed("right_click"):
		if $Frame.visible:
			if $Sprite2D.frame == 2:
				var instance = field.instantiate()
				get_tree().get_root().get_node("World").add_child(instance)
				instance.position = position
				queue_free()
				
