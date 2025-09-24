extends CharacterBody2D
@export var Sprite = 0
var KnockedOut = false
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	if Sprite == 0:
		Sprite = rng.randi_range(1,3)
	$Chest/ChestSprite.frame = Sprite
	$Chest/NeckJoint/Head/HeadSprite.frame = Sprite
	$Chest/ArmLJoint/ArmL/ArmSprite.frame = Sprite
	$Chest/ArmRJoint/ArmR/ArmSprite.frame = Sprite
	$Chest/LegLJoint/LegL/LegLSprite.frame = Sprite
	$Chest/LegRJoint/LegR/LegRSprite.frame = Sprite

func KnockOut():
	KnockedOut = true
	if $Chest/NeckJoint/Head/BirdAnimation.self_modulate.a < 1:
		$Chest/NeckJoint/Head/BirdAnimation.self_modulate.a = lerp($Chest/NeckJoint/Head/BirdAnimation.self_modulate.a,1.0,0.1)
		await get_tree().create_timer(0.16).timeout
		KnockOut()

func KnockOver():
	#$Chest/NeckJoint/Head.apply_central_force(Vector2(0,50))
	$Chest/NeckJoint.angular_limit_enabled = false
	$Chest/NeckJoint/Head.angular_velocity = 50

func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and KnockedOut == false:
		#$Chest/ArmLJoint/ArmL.apply_torque(500)
		$Chest/ArmLJoint/ArmL.angular_velocity = 50
		#$Chest/ArmRJoint/ArmR.apply_torque(-500)
		$Chest/ArmRJoint/ArmR.angular_velocity = -50
