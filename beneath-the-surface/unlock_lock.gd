extends StaticBody2D
@onready var anim = get_node("/root/Underground/CharacterBody2D/Camera2D/AnimatedSprite2D2")

var key = false

func hit():
	if anim.animation == "KeyShown":
		key = true
		queue_free()
		anim.play("NoKeyShown")
		key = false
	else:
		key = false
		
	
	
	
