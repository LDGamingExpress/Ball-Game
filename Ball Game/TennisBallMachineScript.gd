extends CharacterBody2D

var tennisBall = preload("res://TennisBall.tscn")
var isInArea = false
var isBroken = false

func onDeterctionAreaEntered(area: Area2D) -> void:
	if area.get_parent().name == "Ball" and !isBroken:
		isInArea = true
		while(isInArea):
			var newObj = tennisBall.instantiate()
			get_parent().call_deferred("add_child", newObj)
			
			newObj.global_position = global_position
			newObj.linear_velocity = Vector2(-350 * scale.x , 0)
			
			await get_tree().create_timer(1.0).timeout

func onDetectionAreaExited(area: Area2D) -> void:
	if area.get_parent().name == "Ball":
		isInArea = false


func onBreakAreaEntered(area: Area2D) -> void:
	if area.get_parent().name == "Ball" and !isBroken:
		$AnimatedSprite2D.play("broken")
		$GPUParticles2D.emitting = true
		isBroken = true
