extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -700.0
const GRAVITY = 980.0

@onready var anim = $AnimatedSprite2D
@onready var life = $Camera2D/AnimatedSprite2D
@onready var exit2D = get_node("/root/Underground/Exit")
@onready var angel2D = get_node("/root/Underground/Angel")
@onready var rat2D = get_node("/root/Underground/Rat1")
@onready var attack_area = $hitbox

@onready var jumpStream = $JumpStream
@onready var hurtStream = $HurtStream
@onready var music = $Music



var near_door = false
var entering_door = false
var current_door = null
var numJump = 0
var hp = 3
var is_dead = false
var was_on_floor = true

func _ready() -> void:
	exit2D.body_entered.connect(func(body): _on_door_entered(body, exit2D))
	exit2D.body_exited.connect(func(body): _on_door_exited(body, exit2D))
	angel2D.body_entered.connect(func(body): _on_door_entered(body, angel2D))
	angel2D.body_exited.connect(func(body): _on_door_exited(body, angel2D))
	rat2D.body_entered.connect(func(body): _on_door_entered(body, rat2D))
	rat2D.body_exited.connect(func(body): _on_door_exited(body, rat2D))
	anim.animation_finished.connect(_on_animation_finished)
	music.play()
	update_hearts()

func _on_animation_finished():
	if anim.animation == "in":
		entering_door = false
		enter_door()

func _on_door_entered(body, door):
	if body != self:
		return
	near_door = true
	current_door = door
	if door == angel2D:
		take_damage(3)
	elif door == rat2D:
		take_damage(1)

func _on_door_exited(body, door):
	if body != self:
		return
	near_door = false
	current_door = null

func take_damage(amount):
	hurtStream.play()
	if is_dead:
		return
	hp -= amount
	update_hearts()

func enter_door():
	if current_door == null:
		return
	if current_door == exit2D:
		get_tree().change_scene_to_file("res://main_menu.tscn")

func update_hearts():
	var frame = clampi(hp, 0, 3)
	life.play(str(frame) + "heart")

func _physics_process(delta: float):
	if not is_inside_tree() or is_dead:
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Attack
	if Input.is_action_just_pressed("attack"):
		anim.play("attack")
		
		for body in attack_area.get_overlapping_bodies():
			if body.has_method("hit"):
				body.hit()
			
				
	for body in attack_area.get_overlapping_bodies():
		if body.has_method("death"):
			hp = 0
	# Door entry
	if entering_door:
		velocity.x = 0
		move_and_slide()
		return

	# Death
	if hp <= 0:
		is_dead = true
		anim.play("death")
		await anim.animation_finished
		get_tree().call_deferred("reload_current_scene")
		return

	# Jump
	var on_floor = is_on_floor()
	if Input.is_action_just_pressed("space"):
		if on_floor:
			jumpStream.play()
			velocity.y = JUMP_VELOCITY
		elif numJump == 0:
			numJump += 1
			jumpStream.play()
			velocity.y = JUMP_VELOCITY / 1.2

	if on_floor:
		numJump = 0

	# Door interact
	if near_door and Input.is_action_just_pressed("forward"):
		entering_door = true
		anim.play("in")

	# Movement & animation
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
		if on_floor:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if on_floor:
			anim.play("idle")

	if not on_floor:
		anim.play("jump")

	was_on_floor = on_floor
	move_and_slide()
