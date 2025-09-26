extends StaticBody2D
var Broken = false
var rng = RandomNumberGenerator.new()

func Break():
	Broken = true
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.disabled = true
	$GPUParticles2D.emitting = true
	
	rng.randomize()
	$AudioStreamPlayer2D.pitch_scale = rng.randf_range(.9, 1.1)
	$AudioStreamPlayer2D.play()
	
	await get_tree().create_timer(.7).timeout
	queue_free()
