extends StaticBody2D
@onready var anim = get_node("/root/Underground/CharacterBody2D/Camera2D/AnimatedSprite2D3")
var nail = false

func hit():
	nail = true
	anim.play("Nail")
	queue_free()
	
	
