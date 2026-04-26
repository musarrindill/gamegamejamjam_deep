extends Panel

@onready var label = $DialogueLabel

var dialogue_data = {}

func _ready():
	load_dialogue()
	visible = false
	say_sequence("intro", 10.0)

func load_dialogue():
	var file = FileAccess.open("res://dialogue/dialogue.json", FileAccess.READ)
	if file == null:
		print("JSON file not found")
		return

	dialogue_data = JSON.parse_string(file.get_as_text())

func say_one(key: String, duration: float = 3.0):
	if not dialogue_data.has(key):
		print("Missing key: ", key)
		return

	visible = true
	label.visible = true
	label.text = dialogue_data[key][0]

	await get_tree().create_timer(duration).timeout
	visible = false

func say_sequence(key: String, gap: float = 10.0):
	if not dialogue_data.has(key):
		print("Missing key: ", key)
		return

	visible = true
	label.visible = true

	for line in dialogue_data[key]:
		label.text = line
		await get_tree().create_timer(gap).timeout

	visible = false
