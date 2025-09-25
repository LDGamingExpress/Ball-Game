extends RigidBody2D

var currTime = 0
var deleteTime = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Glass"):
		if body.Broken == false:#Checks that glass has not already been broken (important to prevent repeated calls)
			body.call_deferred("Break")#Breaks glass, deferred in case it tries to break it repeatedly

func _ready() -> void:
	deleteTime = 30 * 60

func _physics_process(_delta: float) -> void:
	currTime += 1
	
	if currTime >= deleteTime:
		queue_free()
