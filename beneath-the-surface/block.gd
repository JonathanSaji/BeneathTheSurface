extends StaticBody2D

@onready var anim = $AnimatedSprite2D

@export var hp = 2

func hit():
	hp -= 1
	if hp < 0:
		break_block()
	elif hp == 1:
		half_block()
	elif hp == 0:
		broken_block()
	else:
		full_block()

func break_block():
	queue_free()
	
func full_block():
	anim.play("full")

func half_block():
	anim.play("half")
	
func broken_block():
	anim.play("broken")
	
