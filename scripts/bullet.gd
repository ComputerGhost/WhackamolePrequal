extends Area2D

signal hit(body, position)

const SPEED = 256
const MAX_AIRTIME = 1

var velocity = Vector2()
var airtime = 0

func fire(position, direction):
	self.global_position = position
	self.velocity = direction.normalized() * SPEED
	
func _process(delta):
	self.global_position += velocity * delta
	self.airtime += delta
	
	if self.airtime > MAX_AIRTIME:
		queue_free()
		return

	for body in get_overlapping_bodies():
		if body.name == "player":
			break
		emit_signal("hit", body, global_position)
		queue_free()

