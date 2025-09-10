extends CharacterBody2D
@export var SPEED = 150
@export var JUMP_VELOCITY = 300
@export var HEALTH = 5
var SCORE = 0

func _ready() -> void:
	# Runs code when node is loaded in
	pass

func _physics_process(delta: float) -> void:
	# Runs code at set interval (usually 16 ms)
	if !is_on_floor():
		velocity.y += get_gravity().y
	if Input.is_action_pressed("Left"):
		velocity.x = -SPEED
		$AnimatedSprite2D.play("Running")
	elif Input.is_action_pressed("Right"):
		velocity.x = SPEED
		$AnimatedSprite2D.play("Running")
	else:
		$AnimatedSprite2D.play("default")
	if Input.is_action_just_pressed("Jump"):
		velocity.y = -JUMP_VELOCITY
	move_and_slide()
	velocity.x = velocity.x*0.5
	if abs(velocity.x) < 1:
		velocity.x = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		hurt()
	if body.is_in_group("Goal"):
		win()
	if body.is_in_group("Coins"):
		body.queue_free()
		gain_coin()

func hurt():
	HEALTH -= 1
	velocity.y = -JUMP_VELOCITY*1.25
	if HEALTH < 1:
		print("You lose!")

func win():
	print("You win!")

func gain_coin():
	SCORE += 1
