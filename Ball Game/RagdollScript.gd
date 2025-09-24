extends CharacterBody2D
@export var Sprite = 0
var KnockedOut = false
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	if Sprite == 0:#Randomizes sprite shown to a random football player if one has not been chosen
		Sprite = rng.randi_range(1,3)
	#Sets all sprites to associated frame
	$Chest/ChestSprite.frame = Sprite
	$Chest/NeckJoint/Head/HeadSprite.frame = Sprite
	$Chest/ArmLJoint/ArmL/ArmSprite.frame = Sprite
	$Chest/ArmRJoint/ArmR/ArmSprite.frame = Sprite
	$Chest/LegLJoint/LegL/LegLSprite.frame = Sprite
	$Chest/LegRJoint/LegR/LegRSprite.frame = Sprite

# Function to handle getting knocked out
func KnockOut():
	KnockedOut = true
	# Slowly fades in the "knock out bird" animation and calls function until they are done fading in
	if $Chest/NeckJoint/Head/BirdAnimation.self_modulate.a < 1:
		$Chest/NeckJoint/Head/BirdAnimation.self_modulate.a = lerp($Chest/NeckJoint/Head/BirdAnimation.self_modulate.a,1.0,0.1)
		await get_tree().create_timer(0.16).timeout
		KnockOut()

# Function to handle getting knocked over
func KnockOver():
	$Chest/NeckJoint.angular_limit_enabled = false#Stops the head remaining upright
	$Chest/NeckJoint/Head.angular_velocity = 50#Adds angular velocity to the head to knock it over

# Function to react to the player (ball) coming close
func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and KnockedOut == false:#Checks that the object is the player and that the enemy is not already knocked out
		# Adds angular velocity to the arms to fling them up
		$Chest/ArmLJoint/ArmL.angular_velocity = 50
		$Chest/ArmRJoint/ArmR.angular_velocity = -50
