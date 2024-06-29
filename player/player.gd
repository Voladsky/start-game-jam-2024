extends CharacterBody2D

@export var speed: int = 100
@onready var animation = $AnimationPlayer

var direction: Vector2 = Vector2.ZERO

func _process(_delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	animation.play("Player_Idle")

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()
	
