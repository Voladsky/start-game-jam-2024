extends Area2D

var player
var field_tile = preload("res://tilemap/field_tile.tscn")

func immediate_replace():
	var spiderplant = preload("res://tilemap/spiderplant.tscn")
	var instance = spiderplant.instantiate()
	get_tree().get_root().get_node("World").add_child(instance)
	instance.position = position

func replace_with_field():
	var rng = RandomNumberGenerator.new()
	await get_tree().create_timer(rng.randi() % 3).timeout
	var instance = field_tile.instantiate()
	get_tree().get_root().get_node("World").add_child(instance)
	instance.position = position
	queue_free()
	
func _ready():
	GameManager.cleaning_field.connect(_on_cleaning)
	var rng = RandomNumberGenerator.new()
	player = get_tree().get_nodes_in_group("player")[0]
	var possible_textures = [
		preload("res://assets/sprites/Tilesets/Ground.png"),
		preload("res://assets/sprites/Tilesets/Ground1.png"),
		preload("res://assets/sprites/Tilesets/Ground2.png")
	]
	$Field.texture = possible_textures[rng.randi() % 3]
	$Field.flip_h = rng.randi() % 2
	$Field.flip_v = rng.randi() % 2

func _unhandled_input(_event):
	if Input.is_action_pressed("left_click"):
		if $Frame.visible:
				if GameManager.change_spiderplant_amount(-1):
					# $PlantSound.play()
					immediate_replace()
					GameManager.cleaning_field.disconnect(_on_cleaning)
					GameManager.cleaning_field.emit(position)
					queue_free()

func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Frame.visible = true


func _on_mouse_exited():
	$Frame.visible = false


func _on_cleaning(start):
	#print((position - start).length())
	if (position - start).length() < 128:
		replace_with_field()
