extends KinematicBody2D

signal bullet_hit(object, position)

const SPEED = 128
const RELOAD_TIME = 0.25

var direction

var bulletScene = preload("res://scenes/bullet.tscn")
var reloading = 0.0

func _ready():
	playAnimation("walk_down")

func _physics_process(delta):
	move_and_slide(processInput())
	centerCamera()

func _process(delta):
	reloading -= delta;

func _bullet_hit(object, position):
	emit_signal("bullet_hit", object, position)

func centerCamera():
	var camera = get_parent().get_node("camera")
	camera.position = position.round()
	
func processInput() -> Vector2:
	direction = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)
	if Input.is_action_pressed("ui_accept"):
		fireBullet()
		
	if direction.y == -1:
		playAnimation("walk_up")
	elif direction.y == 1:
		playAnimation("walk_down")
	elif direction.x == -1:
		playAnimation("walk_left")
	elif direction.x == 1:
		playAnimation("walk_right")

	return direction.normalized() * SPEED

func playAnimation(new_animation):
	if $animation.current_animation != new_animation:
		$animation.play(new_animation)

func fireBullet():
	if reloading > 0.0:
		return
	reloading = RELOAD_TIME
	
	var bullet = bulletScene.instance()
	bullet.fire(position, direction)
	get_parent().add_child(bullet)
	
	bullet.connect("hit", self, "_bullet_hit")


