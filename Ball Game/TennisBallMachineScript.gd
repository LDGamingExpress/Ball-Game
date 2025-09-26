extends CharacterBody2D

var tennisBall = preload("res://TennisBall.tscn")
var isInArea = false
var isBroken = false
var ScoreText = preload("res://ScoreText.tscn")

var firedSound = load("res://Sounds/Tennis Ball Fired.mp3")
var brokenSound = load("res://Sounds/Tennis Ball Machine Broken.mp3")

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

#Detects when the ball has entered to detection area so the machine can fire
func onDeterctionAreaEntered(area: Area2D) -> void:
	#makes sure the object in the area is the ball and the machine isnt broken
	if area.get_parent().name == "Ball" and !isBroken:
		isInArea = true
		#fires the balls at a set interval
		while(isInArea):
			if !isBroken:
				var newObj = tennisBall.instantiate()
				get_parent().call_deferred("add_child", newObj)
				
				newObj.global_position = global_position
				newObj.linear_velocity = Vector2(-350 * scale.x , 0)
				
				$AudioStreamPlayer2D.stream = firedSound
				$AudioStreamPlayer2D.pitch_scale = rng.randf_range(.9, 1.1)
				$AudioStreamPlayer2D.play()
				
			await get_tree().create_timer(1.0).timeout

#checks when the ball leaves the area so the machine can stop firing
func onDetectionAreaExited(area: Area2D) -> void:
	if area.get_parent().name == "Ball":
		isInArea = false

#When the ball hits the top of the machine it breaks stopping it from firing and changing the sprite and particles
func onBreakAreaEntered(area: Area2D) -> void:
	if area.get_parent().name == "Ball" and !isBroken:
		$AnimatedSprite2D.play("broken")
		$AudioStreamPlayer2D.stream = brokenSound
		$AudioStreamPlayer2D.volume_db = 15
		$AudioStreamPlayer2D.pitch_scale = rng.randf_range(.8, 1.2)
		$AudioStreamPlayer2D.play()
		$GPUParticles2D.emitting = true
		$ExplosionParticles.emitting = true
		isBroken = true
		var NewST = ScoreText.instantiate()#Instantiates text that shows score
		NewST.Score = 150
		NewST.global_position = global_position
		get_parent().add_child(NewST)
		Globals.Score += 150
