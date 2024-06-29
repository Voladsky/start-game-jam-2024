extends Area2D

var speed = 5
var vanish_distance = 0
var chase = false
var target

func _ready():
	target = get_tree().get_nodes_in_group("player")[0]

func _physics_process(_delta):
	if !chase:
		return
	
	position += position.direction_to(target.position) * speed
	speed += 0.1
	if position.distance_to(target.position) < vanish_distance:
		queue_free()

func _on_body_entered(body):
	await get_tree().create_timer(0.3).timeout
	target = body
	chase = true
	vanish_distance = 8

func _on_body_exited(_body):
	chase = false

