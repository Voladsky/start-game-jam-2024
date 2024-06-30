extends CharacterBody2D

@export var speed: int = 400
@onready var animation = $AnimationPlayer
@onready var GFX = $GFX

var direction: Vector2 = Vector2.ZERO

func _process(_delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if(direction.length() > 0):
		animation.play("Player_Walk")
		animation.speed_scale = 4
		if(direction.x < 0):
			GFX.scale.x = 1
		elif(direction.x > 0):
			GFX.scale.x = -1
	else:
		animation.play("Player_Idle")
		animation.speed_scale = 1

func _physics_process(_delta):
	velocity = direction * speed
	
	move_and_slide()
