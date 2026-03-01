extends Control

@onready var play_btn    : Button = $ColorRect/VBoxContainer/Play
@onready var quit_btn    : Button = $ColorRect/VBoxContainer/Quit
@onready var anim = $AnimationPlayer


func _ready() -> void:
	play_btn.pressed.connect(_on_play_pressed)

	quit_btn.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	# get_tree().change_scene_to_file("res://Game.tscn")
	get_tree().change_scene_to_file("res://prologue.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
