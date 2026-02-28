extends Control

@onready var play_btn    : Button = $ColorRect/VBoxContainer/Play
@onready var options_btn : Button = $ColorRect/VBoxContainer/Options
@onready var quit_btn    : Button = $ColorRect/VBoxContainer/Quit
@onready var anim = $AnimationPlayer


func _ready() -> void:
	play_btn.pressed.connect(_on_play_pressed)
	options_btn.pressed.connect(_on_options_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)
	anim.animation_finished.connect(_on_animation_finished)

func _on_play_pressed() -> void:
	# get_tree().change_scene_to_file("res://Game.tscn")
	anim.play("scroll_up")

func _on_options_pressed() -> void:
	print("Options pressed")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_animation_finished(name):
	if name == "scroll_up":
		get_tree().change_scene_to_file("res://prologue.tscn")
