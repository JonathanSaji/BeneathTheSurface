extends StaticBody2D
@onready var anim = get_node("/root/Underground/CharacterBody2D/Camera2D/AnimatedSprite2D3")

var nail = false

func hit():
	if anim.animation == "Nail":
		nail = true
		get_tree().change_scene_to_file("res://Credits.tscn")
		queue_free()
		anim.play("NoNail")
		nail = false
	else:
		nail = false
		
	
	
	
