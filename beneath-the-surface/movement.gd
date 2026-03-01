extends CharacterBody2D
const SPEED = 600.0
const JUMP_VELOCITY = -350.0
const GRAVITY = 980.0
@onready var anim = $AnimatedSprite2D
@onready var area2D = get_node("/root/Prologue/Scene/Area2D")

var near_door = false
var entering_door = false

func _ready() -> void:
	area2D.body_entered.connect(_on_door_entered)
	area2D.body_exited.connect(_on_door_exited)
	anim.animation_finished.connect(_on_animation_finished)
	print(area2D)

func _on_animation_finished():
	if anim.animation == "in":
		entering_door = false
		enter_door()

func _on_door_entered(body):
	print("something entered: ", body.get_name())
	if body == self:
		near_door = true
		print("near door = true")

func _on_door_exited(body):
	print("something exited: ", body.get_name())
	if body == self:
		near_door = false

func enter_door():
	print("Entering door!")
	# get_tree().change_scene_to_file("res://next_level.tscn")

func _physics_process(delta : float):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	if entering_door:
		velocity.x = 0
		return  # ← stops all input processing below
	else:
		
		if Input.is_action_just_pressed("space") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		if near_door and Input.is_action_just_pressed("forward"):
			anim.play("in")

		var direction = Input.get_axis("left","right")

		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		if direction > 0:
			anim.flip_h = false
		elif direction < 0:
			anim.flip_h = true

		

		if direction != 0:
			anim.play("run")
	move_and_slide()
