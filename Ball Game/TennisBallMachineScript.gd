extends Node2D

var tennisBall = preload("res://TennisBall.tscn")
var isInArea = false

func onBodyEntered(obj: RigidBody2D) -> void:
	if obj.name == "Ball":
		isInArea = true
		while(isInArea):
			var newObj = tennisBall.instantiate()
			add_child(newObj)
			
			newObj.linear_velocity = Vector2(-500, 0)
			
			await get_tree().create_timer(1.0).timeout
			
	



func onBodyExited(obj: RigidBody2D) -> void:
	if obj.name == "Ball":
		isInArea = false
