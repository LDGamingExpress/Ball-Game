extends CharacterBody2D
@export var Sprite = 0
var KnockedOut = false

func KnockOut():
	KnockedOut = true
	if $Chest/NeckJoint/Head/BirdAnimation.self_modulate.a < 1:
		$Chest/NeckJoint/Head/BirdAnimation.self_modulate.a = lerp($Chest/NeckJoint/Head/BirdAnimation.self_modulate.a,1.0,0.1)
		await get_tree().create_timer(0.16).timeout
		KnockOut()


func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and KnockedOut == false:
		#$Chest/ArmLJoint/ArmL.apply_torque(500)
		$Chest/ArmLJoint/ArmL.angular_velocity = 50
		#$Chest/ArmRJoint/ArmR.apply_torque(-500)
		$Chest/ArmRJoint/ArmR.angular_velocity = -50
