extends CharacterBody2D

@export var speed: int = 400
@onready var animation = $AnimationPlayer
@onready var GFX = $GFX
@onready var walking_sound = $WalkingSound

var rng = RandomNumberGenerator.new()
var direction: Vector2 = Vector2.ZERO
var is_moving = false
var volume_step_down = -0.5

func _process(_delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if(direction.length() > 0):
		animation.play("Player_Walk")
		
		if !walking_sound.playing:
			walking_sound.pitch_scale = rng.randf_range(1.5, 2)
			walking_sound.play()
			walking_sound.volume_db = 0
		animation.speed_scale = 4
		if(direction.x < 0):
			GFX.scale.x = 1
		elif(direction.x > 0):
			GFX.scale.x = -1
	else:
		walking_sound.volume_db = lerp(float(walking_sound.volume_db), -80.0, volume_step_down * _delta)
		if walking_sound.volume_db <= -79:
			walking_sound.stop()
		animation.play("Player_Idle")
		animation.speed_scale = 1
	
	$GFX/BackPack.modulate = Color(1,1,1,1) - Color(1,0,0,0) * GameManager.water_amount/GameManager.max_water_amount

func _physics_process(_delta):
	velocity = direction * speed
	
	move_and_slide()
