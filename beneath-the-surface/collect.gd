extends StaticBody2D
@onready var anim = get_node("/root/Underground/CharacterBody2D/Camera2D/AnimatedSprite2D2")
@onready var stream =  $KeyCollectEffect
var key = false
func hit():
	key = true
	stream.play()
	await stream.finished
	anim.play("KeyShown")
	queue_free()
	
	
