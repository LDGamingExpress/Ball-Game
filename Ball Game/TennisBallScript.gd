extends RigidBody2D

#Times to keep track of for destroying the ball after a certain amount of time
var currTime = 0
var deleteTime = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Glass"):
		if body.Broken == false:#Checks that glass has not already been broken (important to prevent repeated calls)
			body.call_deferred("Break")#Breaks glass, deferred in case it tries to break it repeatedly

#sets time the ball should be destroyed
func _ready() -> void:
	deleteTime = 30 * 60

#destroys the ball when its the correct time
func _physics_process(_delta: float) -> void:
	currTime += 1
	
	if currTime >= deleteTime:
		queue_free()
