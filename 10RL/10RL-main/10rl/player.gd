extends CharacterBody2D

const SPEED = 220.0
const JUMP = -420.0
const SHOT = preload("res://10rl/player_shot.gd")

@onready var sprite = $Sprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += 900.0 * delta
	var dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP
	if Input.is_action_just_pressed("ui_select"):
		shoot()
	move_and_slide()

func shoot():
	var p = Node2D.new()
	p.set_script(SHOT)
	get_parent().add_child(p)
	p.global_position = global_position + Vector2(40,0)
