extends RichTextLabel

@export var speed = 0.05  # seconds per character

func _ready():
	visible_characters = 0
	typewrite("Well well well... a human who digs.")

func typewrite(text):
	self.text = text
	visible_characters = 0
	for i in len(text):
		visible_characters += 1
		await get_tree().create_timer(speed).timeout
