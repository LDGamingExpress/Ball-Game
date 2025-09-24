extends CharacterBody2D
@export var Sprite = 0

func KnockOut():
	if $Chest/NeckJoint/Head/BirdAnimation.self_modulate.a < 1:
		$Chest/NeckJoint/Head/BirdAnimation.self_modulate.a = lerp($Chest/NeckJoint/Head/BirdAnimation.self_modulate.a,1.0,0.1)
		await get_tree().create_timer(0.16).timeout
		KnockOut()
