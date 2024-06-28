extends CharacterBody2D

@export var speed: int = 100

var direction: Vector2 = Vector2.ZERO

func _process(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")


func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()
	
