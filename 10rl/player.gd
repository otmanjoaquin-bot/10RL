extends CharacterBody2D

const SPEED = 220.0
const JUMP = -420.0
const SHOT = preload("res://10rl/player_shot.gd")

var facing := 1
var can_double_jump := true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += 1000.0 * delta
	else:
		can_double_jump = true

	var dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED
	if dir != 0:
		facing = sign(dir)

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or can_double_jump):
		velocity.y = JUMP
		can_double_jump = false

	if Input.is_action_just_pressed("ui_select"):
		shoot()

	move_and_slide()

func shoot():
	var p = Node2D.new()
	p.set_script(SHOT)
	get_parent().add_child(p)
	p.global_position = global_position + Vector2(40 * facing, 0)
	p.direction = facing
