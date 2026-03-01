extends StaticBody2D
@onready var anim = get_node("/root/Underground/CharacterBody2D/Camera2D/AnimatedSprite2D2")
var key = false
func hit():
	key = true
	queue_free()
	anim.play("KeyShown")
	
	
