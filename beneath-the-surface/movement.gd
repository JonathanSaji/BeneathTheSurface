extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -700.0
const GRAVITY = 980.0

@onready var anim = $AnimatedSprite2D
 
func _physics_process(delta : float):
	
	#this applies gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	#Jump
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#horizontal movement
	var direction = Input.get_axis("left","right")
	
	
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
		
	#flipping sprite based on the dir
	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true
		
	move_and_slide()
"""
	if not is_on_floor():
		if anim.animation != "jump":
			anim.play("jump")
	elif direction != 0:
		if anim.animation != "run":
			anim.play("run")
	else:
		if anim.animation != "idle":
			anim.play("idle")
"""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(anim)
