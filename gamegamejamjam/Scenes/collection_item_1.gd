extends Area2D

@export var target_zone_name: String = "brain"
@export var speech_bubble: Panel

var is_carried := false
var carrier = null
var carry_offset := Vector2.ZERO

var possible_offsets := [
	Vector2(0, -40),
	Vector2(18, -30),
	Vector2(-18, -30),
	Vector2(25, -10),
	Vector2(-25, -10)
]

func _ready():
	randomize()
	body_entered.connect(_on_body_entered)

func _process(_delta):
	if is_carried and carrier:
		global_position = (carrier.global_position + carry_offset).round()

func _on_body_entered(body):
	if body.name == "Player" and not is_carried:
		pick_up(body)

func pick_up(body):
	if body.carried_items.has(self):
		return

	is_carried = true
	carrier = body
	body.carried_items.append(self)

	var random_index = randi() % possible_offsets.size()
	carry_offset = possible_offsets[random_index]
	if speech_bubble:
		speech_bubble.say_one("item_acquired_" + target_zone_name, 2.5)

func drop():
	is_carried = false

	if carrier:
		carrier.carried_items.erase(self)

	var drop_start = global_position

	var dir = Vector2.RIGHT
	if carrier:
		dir = (global_position - carrier.global_position).normalized()
		if dir == Vector2.ZERO:
			dir = Vector2.RIGHT

	var drop_end = drop_start + dir * 150
	var jump_peak = drop_start + Vector2(0, -100)

	carrier = null

	var tween = create_tween()
	tween.tween_property(self, "global_position", jump_peak, 0.2)
	tween.tween_property(self, "global_position", drop_end, 0.35)
