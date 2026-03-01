extends CharacterBody2D
const SPEED = 600.0
const JUMP_VELOCITY = -700.0
const GRAVITY = 980.0

@onready var anim = $AnimatedSprite2D
@onready var exit2D = get_node("/root/Underground/Exit")
@onready var attack_area = $hitbox

var choice = null
var near_door = false
var entering_door = false
var current_door = null
var numJump = 0;

func _ready() -> void:
	
	#door2D.body_entered.connect(func(body): _on_door_entered(body, door2D))
	#door2D.body_exited.connect(func(body): _on_door_exited(body, door2D))
	exit2D.body_entered.connect(func(body): _on_door_entered(body, exit2D))
	exit2D.body_exited.connect(func(body): _on_door_exited(body, exit2D))
	anim.animation_finished.connect(_on_animation_finished)
	
	#print("Door name: ", door2D.name)
	print("Exit name: ", exit2D.name)

func _on_animation_finished():
	if anim.animation == "in":
		entering_door = false
		enter_door()

func _on_door_entered(body, door):
	if body == self:
		near_door = true
		current_door = door
		print("Near door: ", door.name)

func _on_door_exited(body, door):
	if body == self:
		near_door = false
		current_door = null
		print("Left door: ", door.name)

func enter_door():
	print("Entering door: ", current_door.name if current_door else "unknown")
	#if current_door == door2D:
	#	get_tree().change_scene_to_file("res://temple.tscn")
	if current_door == exit2D:
		get_tree().change_scene_to_file("res://main_menu.tscn")

func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("attack"):
		for body in attack_area.get_overlapping_bodies():
			if body.has_method("hit"):
				anim.play("attack")
				body.hit()

	if entering_door:
		velocity.x = 0
		return
	else:
		if Input.is_action_just_pressed("space") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif Input.is_action_just_pressed("space") and not is_on_floor() and numJump == 0:
			numJump += 1
			velocity.y = JUMP_VELOCITY/1.2
		if near_door and Input.is_action_just_pressed("forward"):
			entering_door = true
			anim.play("in")
		
		if is_on_floor():
			numJump = 0
		
		
		var direction = Input.get_axis("left", "right")
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
