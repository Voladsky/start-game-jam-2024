extends Area2D


var item_drop = preload("res://item_drop/item_drop.tscn")

@export var need_water = true
var player


func _ready():
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


func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("left_click"):
		if $Frame.visible:
			if $Plant.visible:
				if need_water and GameManager.change_water_amount(-1):
					need_water = false
					$WaterSound.play()
					$Water.visible = false
					$WateringParticle.emitting = true
					for i in range(2):
						await get_tree().create_timer(3).timeout
						$GrowingParticle.emitting = true
						$Plant.frame += 1
			else:
				if GameManager.change_potato_amount(-1):
					$PlantSound.play()
					$Plant.visible = true
					$Water.visible = true
					need_water = true
	
	if Input.is_action_pressed("right_click"):
		if $Frame.visible:
			if $Plant.frame == 2:
				$CollectSound.play()
				$CollectParticle.emitting = true
				$Plant.visible = false
				$Plant.frame = 0
			
				for i in range(randi_range(1, 3)):
					var item_instance = item_drop.instantiate()
					get_tree().get_root().get_node("World").add_child(item_instance)
					item_instance.position = position + Vector2(randf_range(-32, 32), randf_range(-32, 32))


func _on_mouse_entered():
	if get_node_or_null("Rmb") and $Plant.visible:
		$Rmb.visible = true
	if (player.position - position).length() < 128:
		$Frame.visible = true


func _on_mouse_exited():
	if get_node_or_null("Rmb"):
		$Rmb.visible = false
	$Frame.visible = false
