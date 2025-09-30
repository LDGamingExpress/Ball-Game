extends RigidBody2D
var CoinP = preload("res://CoinParticles.tscn")
var ScoreText = preload("res://ScoreText.tscn")
#I dont understand a thing

#Used for launching the ball
var buttonPressed = false
var offset = Vector2(100, 0)
@export var offsetMultiplier: Vector2
var JustBounced = false

#Trajectory line
@export var line: Line2D

var sounds = [load("res://Sounds/Ball Launched.mp3"), load("res://Sounds/Cheers.mp3"), load("res://Sounds/Cartoon Dizzy Birds.mp3"), load("res://Sounds/Referee Whistle.mp3"), load("res://Sounds/SpringSound.mp3")]
var music = load("res://Music/GOAL.mp3")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

#marks the button as being pressed and changes the offset to show it has been clicked
func _on_button_button_down() -> void:
	buttonPressed = true
	offset = Vector2(100, 0)
	line.show()

#checks when button is released and changes the offset to vector between the ball and the mouse
func _on_button_button_up() -> void:
	buttonPressed = false
	offset = get_global_mouse_position() - global_position
	line.hide()

#updates the trajectory of the line by taking the current offset and simulating its path
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
	#Ball gets launched when the button has been released and only once
	if offset.x != 100 and buttonPressed == false:
		linear_velocity += -offset * offsetMultiplier
		angular_velocity = -offset.x / 5
		
		#plays ball launch sound
		$AudioStreamPlayer2D.pitch_scale = rng.randf_range(.8, 1.2)
		$AudioStreamPlayer2D.play()
		
		offset = Vector2(100, 0)
		
		#if the button is pressed it takes the current offset and updates the trajectory
	elif buttonPressed == true:
		var currOffset = get_global_mouse_position() - global_position
		updateTrajectory(currOffset * offsetMultiplier, delta)
		

# Function for collision detection
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Barrels"):
		body.get_node("AudioStreamPlayer2D").pitch_scale = rng.randf_range(.8, 1.2)
		body.get_node("AudioStreamPlayer2D").play()
	if body.is_in_group("Bouncy") and JustBounced == false:
		body.get_node("AudioStreamPlayer2D").pitch_scale = rng.randf_range(.8, 1.2)
		body.get_node("AudioStreamPlayer2D").play()
		linear_velocity.y = linear_velocity.y * 3
		var mag = sqrt(pow(linear_velocity.x,2) + pow(linear_velocity.y,2))
		#print(mag)
		if mag > 1600:
			linear_velocity = linear_velocity/mag*1600
		JustBounced = true
		BounceCheck()
	if body.is_in_group("KnockEnemy"):#Detects if the head of a ragdoll enemy is hit
		var NodeB = body.get_parent().get_parent().get_parent()#Gets the characterbody of the enemy
		if NodeB.KnockedOut == false:#Checks that enemy has not already been knocked out
			var NewST = ScoreText.instantiate()#Instantiates text that shows score
			NewST.Score = 100
			NewST.global_position = body.global_position
			
			#Plays the dizzy sound
			NodeB.get_node("AudioStreamPlayer2D").pitch_scale = rng.randf_range(1.0, 1.2)
			NodeB.get_node("AudioStreamPlayer2D").play()
			
			get_parent().add_child(NewST)
			NodeB.KnockOut()#Knocks out enemy
			NodeB.KnockOver()#Pushes over enemy by adding angular velocity to their head
			Globals.Score += 100
	if body.is_in_group("Glass"):#Detects if glass is hit
		if body.Broken == false:#Checks that glass has not already been broken (important to prevent repeated calls)
			body.call_deferred("Break")#Breaks glass, deferred in case it tries to break it repeatedly
	if body.is_in_group("EndGoal"):
		$Camera2D/CanvasLayer/GameEndMenu/Label2.text = "Score: " + str(Globals.Score)
		$Camera2D/CanvasLayer/GameEndMenu.visible = true
		
		#Plays the whistle sound
		body.get_node("AudioStreamPlayer2D").pitch_scale = rng.randf_range(.9, 1.1)
		body.get_node("AudioStreamPlayer2D").play()
	if body.is_in_group("Exit"):#Detects if the door to the next level is hit
		$Camera2D/CanvasLayer/LevelEndMenu/Label2.text = "Score: " + str(Globals.Score)
		$Camera2D/CanvasLayer/LevelEndMenu.visible = true
		
		#Plays GOAL theme
		$Music.stream = music
		$Music.play()
		
		#Plays the whistle sound
		body.get_node("AudioStreamPlayer2D").pitch_scale = rng.randf_range(.9, 1.1)
		body.get_node("AudioStreamPlayer2D").play()
	if body.is_in_group("Coins") and body.visible == true:#Detects if a coin is hit
		#Plays the cheers sound
		body.get_node("AudioStreamPlayer2D").pitch_scale = rng.randf_range(.8, 1.2)
		body.get_node("AudioStreamPlayer2D").play()
		
		var NewObj = CoinP.instantiate()#Instantiates particles for the coin
		NewObj.global_position = body.global_position
		get_parent().add_child(NewObj)
		var NewST = ScoreText.instantiate()#Instantiates text that shows score
		NewST.Score = 250
		NewST.global_position = body.global_position
		get_parent().add_child(NewST)
		Globals.Score += 250
		
		body.visible = false
		await get_tree().create_timer(3.0).timeout
		body.queue_free()#Deletes coin

# Function to change level when "next level" button is pressed
func _on_next_button_pressed() -> void:
	Globals.Level += 1
	get_tree().change_scene_to_file(Globals.Levels[Globals.Level])


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func BounceCheck():
	await get_tree().create_timer(0.25).timeout
	JustBounced = false
