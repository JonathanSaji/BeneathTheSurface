extends StaticBody2D

@export var hp = 1

func hit():
	hp -= 1
	if hp <= 0:
		break_block()

func break_block():
	# optionally play animation or particles here
	queue_free()
