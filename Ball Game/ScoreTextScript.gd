extends Label
var Stage = 0
var Score = 100

func _ready() -> void:
	text = "+" + str(Score)#Displays score of the text

func _process(delta: float) -> void:
	position.y -= 0.2
	match(Stage):#Tracks the "Stage" to know when to fade in and out the text
		0:
			self_modulate.a = lerp(self_modulate.a,1.0,0.05)
			if self_modulate.a > 0.95:
				Stage = 1
		1:
			self_modulate.a = lerp(self_modulate.a,0.0,0.05)
			if self_modulate.a < 0.05:
				#print("Bloop!")
				queue_free()
	
