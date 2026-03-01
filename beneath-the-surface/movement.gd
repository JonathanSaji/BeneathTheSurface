extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -350.0
const GRAVITY = 980.0

@onready var anim = $AnimatedSprite2D
@onready var area2D = get_node("/root/Prologue/Scene/Area2D")
 
var near_door = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	area2D.body_entered.connect(_on_door_entered)
	area2D.body_exited.connect(_on_door_exited)
	
	print(area2D)

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
	# change scene, play animation, etc.
	# get_tree().change_scene_to_file("res://next_level.tscn")
	
func _physics_process(delta : float):
	
	#this applies gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	#Jump
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if near_door and Input.is_action_just_pressed("forward"):  # W key
		enter_door()


	
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

		
	if direction != 0:
		anim.play("run")
