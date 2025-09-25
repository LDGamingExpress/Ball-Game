extends CharacterBody2D

var tennisBall = preload("res://TennisBall.tscn")
var isInArea = false
var isBroken = false

#Detects when the ball has entered to detection area so the machine can fire
func onDeterctionAreaEntered(area: Area2D) -> void:
	#makes sure the object in the area is the ball and the machine isnt broken
	if area.get_parent().name == "Ball" and !isBroken:
		isInArea = true
		#fires the balls at a set interval
		while(isInArea):
			var newObj = tennisBall.instantiate()
			get_parent().call_deferred("add_child", newObj)
			
			newObj.global_position = global_position
			newObj.linear_velocity = Vector2(-350 * scale.x , 0)
			
			await get_tree().create_timer(1.0).timeout

#checks when the ball leaves the area so the machine can stop firing
func onDetectionAreaExited(area: Area2D) -> void:
	if area.get_parent().name == "Ball":
		isInArea = false

#When the ball hits the top of the machine it breaks stopping it from firing and changing the sprite and particles
func onBreakAreaEntered(area: Area2D) -> void:
	if area.get_parent().name == "Ball" and !isBroken:
		$AnimatedSprite2D.play("broken")
		$GPUParticles2D.emitting = true
		isBroken = true
