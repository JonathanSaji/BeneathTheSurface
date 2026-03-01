extends RichTextLabel

@export var speed = 0.05  # seconds per character

func _ready():
	visible_characters = 0
	typewrite("12 Years Later... ")

func typewrite(text):
	self.text = text
	visible_characters = 0
	for i in len(text):
		visible_characters += 1
		await get_tree().create_timer(speed).timeout
