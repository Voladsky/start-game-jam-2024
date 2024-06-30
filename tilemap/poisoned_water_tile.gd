extends StaticBody2D

var player
var water_tile = preload("res://tilemap/water_tile.tscn")

func _ready():
	var rng = RandomNumberGenerator.new()
	player = get_tree().get_nodes_in_group("player")[0]
	var possible_textures = [
		preload("res://assets/sprites/Tilesets/DirtyWater1.png"),
		preload("res://assets/sprites/Tilesets/DirtyWater2.png")
	]
	$Sprite2D.texture = possible_textures[rng.randi() % 2]
		
func _unhandled_input(_event):
	if Input.is_action_pressed("left_click"):
		if $Frame.visible:			
				if GameManager.change_cattail_amount(-1):
					$PlantSound.play()
					
					var instance = water_tile.instantiate()
					get_tree().root.add_child(instance)
					instance.position = position
					
					queue_free()
					
func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Frame.visible = true


func _on_mouse_exited():
	$Frame.visible = false
