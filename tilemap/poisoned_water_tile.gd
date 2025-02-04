extends StaticBody2D

var player
var water_tile = preload("res://tilemap/water_tile.tscn")

func immediate_replace():
	var instance = water_tile.instantiate()
	var cattail = preload("res://tilemap/cattail.tscn")
	instance.add_child(cattail.instantiate())
	get_tree().get_root().get_node("World").add_child(instance)
	instance.position = position

func replace_with_water():
	var rng = RandomNumberGenerator.new()
	await get_tree().create_timer(rng.randi() % 3).timeout
	var instance = water_tile.instantiate()
	get_tree().get_root().get_node("World").add_child(instance)
	instance.position = position
	queue_free()
	
func _ready():
	GameManager.cleaning_water.connect(_on_cleaning)
	var rng = RandomNumberGenerator.new()
	player = get_tree().get_nodes_in_group("player")[0]
	var possible_textures = [
		preload("res://assets/sprites/Tilesets/DirtyWater1.png"),
		preload("res://assets/sprites/Tilesets/DirtyWater2.png")
	]
	$Sprite2D.texture = possible_textures[rng.randi() % 2]
	$Sprite2D.flip_h = rng.randi() % 2
	$Sprite2D.flip_v = rng.randi() % 2
		
func _unhandled_input(_event):
	if Input.is_action_pressed("left_click"):
		if $Frame.visible:
				if GameManager.change_cattail_amount(-1):
					$PlantSound.play()
					immediate_replace()
					GameManager.cleaning_water.disconnect(_on_cleaning)
					GameManager.cleaning_water.emit(position)
					queue_free()
					
func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Frame.visible = true


func _on_mouse_exited():
	$Frame.visible = false


func _on_cleaning(start):
	#print((position - start).length())
	if (position - start).length() < 128:
		replace_with_water()
