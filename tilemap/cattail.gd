extends Sprite2D


func _ready():
	for i in range(2):
		await get_tree().create_timer(2).timeout
		frame += 1
		$GrowingParticle.emitting = true
