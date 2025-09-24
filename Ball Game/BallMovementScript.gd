extends RigidBody2D
var CoinP = preload("res://CoinParticles.tscn")
#I dont understand a thing

#Used for launching the ball
var buttonPressed = false
var offset = Vector2(0, 0)
@export var offsetMultiplier: Vector2

#Trajectory line
@export var line: Line2D


func _on_button_button_down() -> void:
	buttonPressed = true
	offset = Vector2(100, 0)
	line.show()

func _on_button_button_up() -> void:
	buttonPressed = false
	offset = get_global_mouse_position() - global_position
	line.hide()


func updateTrajectory(currOffset: Vector2, delta: float):
	var maxPoints = 100
	
	line.global_rotation = 0
	line.clear_points()
	var pos = line.to_local(global_position)
	
	for i in maxPoints:
		line.add_point(pos)
		currOffset.y -= gravity_scale * delta * 10
		pos += -currOffset * delta


func _physics_process(delta: float) -> void:
	#Ball gets launched only once
	if offset.x != 100 and buttonPressed == false:
		linear_velocity += -offset * offsetMultiplier
		angular_velocity = -offset.x / 5
		offset = Vector2(100, 0)
		
	elif buttonPressed == true:
		var currOffset = get_global_mouse_position() - global_position
		updateTrajectory(currOffset * offsetMultiplier, delta)
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("KnockEnemy"):
		var NodeB = body.get_parent().get_parent().get_parent()
		if NodeB.KnockedOut == false:
			NodeB.KnockOut()
			NodeB.KnockOver()
			Globals.Score += 100
	if body.is_in_group("Glass"):
		if body.Broken == false:
			body.call_deferred("Break")
	if body.is_in_group("Exit"):
		$Camera2D/CanvasLayer/LevelEndMenu.visible = true
	if body.is_in_group("Coins"):
		var NewObj = CoinP.instantiate()
		NewObj.global_position = body.global_position
		get_parent().add_child(NewObj)
		Globals.Score += 250
		body.queue_free()


func _on_next_button_pressed() -> void:
	Globals.Level += 1
	get_tree().change_scene_to_file(Globals.Levels[Globals.Level])


func _on_menu_button_pressed() -> void:
	pass # Replace with function body.
