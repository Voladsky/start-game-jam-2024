extends Area2D


var item_drop = preload("res://item_drop/item_drop.tscn")

var need_water = true
var player


func _ready():
	player = get_tree().get_nodes_in_group("player")[0]


func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("left_click"):
		if (player.position - position).length() < 128:
			if $Plant.visible:
				if need_water and GameManager.change_water_amount(-1):
					need_water = false
					$Water.visible = false
					for i in range(3):
						await get_tree().create_timer(2).timeout
						$Plant.frame += 1
			else:
				if GameManager.change_potato_amount(-1):
					$Plant.visible = true
					$Water.visible = true
					need_water = true
	
	if Input.is_action_pressed("right_click"):
		if $Plant.frame == 4:
			$Plant.visible = false
			$Plant.frame = 1
			
			for i in range(randi_range(1, 3)):
				var item_instance = item_drop.instantiate()
				get_tree().root.add_child(item_instance)
				item_instance.position = position + Vector2(randf_range(-4, 4), randf_range(-4, 4))


func _on_mouse_entered():
	if (player.position - position).length() < 128:
		$Frame.visible = true


func _on_mouse_exited():
	$Frame.visible = false
