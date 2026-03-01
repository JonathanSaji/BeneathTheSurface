extends Node2D
@onready var anim = $AnimationPlayer
@onready var camera: Camera2D = $Scene/CharacterBody2D/Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.enabled = false
	anim.play("scroll_up")
	anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(character_name: StringName) -> void:
	if character_name == "scroll_up":
		camera.enabled = true
