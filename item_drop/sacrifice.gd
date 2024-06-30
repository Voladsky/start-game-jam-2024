extends Area2D

var speed = 35
var vanish_distance = 25
var target

func _ready():
	target = get_tree().get_nodes_in_group("generator")[0]

func _physics_process(_delta):
	position += position.direction_to(target.position) * speed
	if position.distance_to(target.position) < vanish_distance:
		queue_free()
