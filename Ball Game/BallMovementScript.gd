extends RigidBody2D
var CoinP = preload("res://CoinParticles.tscn")
var ScoreText = preload("res://ScoreText.tscn")
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
		currOffset.y -= gravity_scale * delta * 9.8
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
		

# Function for collision detection
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("KnockEnemy"):#Detects if the head of a ragdoll enemy is hit
		var NodeB = body.get_parent().get_parent().get_parent()#Gets the characterbody of the enemy
		if NodeB.KnockedOut == false:#Checks that enemy has not already been knocked out
			var NewST = ScoreText.instantiate()#Instantiates text that shows score
			NewST.Score = 100
			NewST.global_position = body.global_position
			get_parent().add_child(NewST)
			NodeB.KnockOut()#Knocks out enemy
			NodeB.KnockOver()#Pushes over enemy by adding angular velocity to their head
			Globals.Score += 100
	if body.is_in_group("Glass"):#Detects if glass is hit
		if body.Broken == false:#Checks that glass has not already been broken (important to prevent repeated calls)
			body.call_deferred("Break")#Breaks glass, deferred in case it tries to break it repeatedly
	if body.is_in_group("Exit"):#Detects if the door to the next level is hit
		$Camera2D/CanvasLayer/LevelEndMenu/Label2.text = "Score: " + str(Globals.Score)
		$Camera2D/CanvasLayer/LevelEndMenu.visible = true
	if body.is_in_group("Coins"):#Detects if a coin is hit
		var NewObj = CoinP.instantiate()#Instantiates particles for the coin
		NewObj.global_position = body.global_position
		get_parent().add_child(NewObj)
		var NewST = ScoreText.instantiate()#Instantiates text that shows score
		NewST.Score = 250
		NewST.global_position = body.global_position
		get_parent().add_child(NewST)
		Globals.Score += 250
		body.queue_free()#Deletes coin

# Function to change level when "next level" button is pressed
func _on_next_button_pressed() -> void:
	Globals.Level += 1
	get_tree().change_scene_to_file(Globals.Levels[Globals.Level])


func _on_menu_button_pressed() -> void:
	pass # Replace with function body.
