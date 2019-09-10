extends HBoxContainer

onready var points_label = $points/count
onready var health_bar = $health_bar/bar
onready var tween = $tween

var animated_health = 0

func _ready():
	update_health(100)

func _process(delta):
	var round_value = round(animated_health)
	points_label.text = str(round_value)
	health_bar.value = round_value

func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
