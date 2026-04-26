extends Label

var dialogue_data = {}
var is_speaking := false

func _ready():
	load_dialogue()
	visible = false
	say_sequence("intro", 10.0)

func load_dialogue():
	var file = FileAccess.open("res://dialogue/dialogue.json", FileAccess.READ)
	var text = file.get_as_text()
	dialogue_data = JSON.parse_string(text)

func say_sequence(key: String, gap: float = 10.0):
	if not dialogue_data.has(key):
		return

	is_speaking = true
	visible = true

	for line in dialogue_data[key]:
		text = line
		await get_tree().create_timer(gap).timeout

	visible = false
	is_speaking = false

func say_one(key: String):
	if not dialogue_data.has(key):
		return

	visible = true
	text = dialogue_data[key][0]

	await get_tree().create_timer(3.0).timeout
	visible = false
