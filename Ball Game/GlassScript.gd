extends StaticBody2D
var Broken = false

func Break():
	Broken = true
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.disabled = true
	$GPUParticles2D.emitting = true
