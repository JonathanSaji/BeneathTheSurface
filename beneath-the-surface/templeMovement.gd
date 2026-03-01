extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -350.0
const GRAVITY = 980.0

@onready var anim = $AnimatedSprite2D  # fixed node path

func _ready() -> void:
	print(anim)

func _physics_process(delta: float):
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Flip sprite
	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true

	# Animations
	if not is_on_floor():
		anim.play("jump")
	elif direction != 0:
		anim.play("run")
	else:
		anim.play("idle")

	move_and_slide()
