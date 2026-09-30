extends CharacterBody2D

const SPEED := 260.0
const ACCELERATION := 1800.0
const FRICTION := 2200.0
const JUMP_FORCE := -520.0
const GRAVITY := 1400.0
const MAX_FALL_SPEED := 850.0
const SHOT_SCENE := preload("res://10rl/player_shot.tscn")

var facing := 1
var jumps_left := 1
var health := 5
var shoot_cooldown := 0.0
var invulnerable := 0.0

func _physics_process(delta: float) -> void:
    if invulnerable > 0.0:
        invulnerable -= delta
        modulate.a = 0.45 if int(invulnerable * 15.0) % 2 == 0 else 1.0
    else:
        modulate.a = 1.0

    if not is_on_floor():
        velocity.y = min(velocity.y + GRAVITY * delta, MAX_FALL_SPEED)
    else:
        jumps_left = 1

    var direction := Input.get_axis("ui_left", "ui_right")
    if direction != 0.0:
        velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
        facing = 1 if direction > 0.0 else -1
        $Sprite2D.flip_h = facing < 0
    else:
        velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)

    if Input.is_action_just_pressed("ui_accept"):
        if is_on_floor():
            velocity.y = JUMP_FORCE
        elif jumps_left > 0:
            velocity.y = JUMP_FORCE
            jumps_left -= 1

    shoot_cooldown = max(shoot_cooldown - delta, 0.0)
    if Input.is_action_just_pressed("shoot") and shoot_cooldown <= 0.0:
        shoot()
        shoot_cooldown = 0.22

    move_and_slide()

    if global_position.y > 760.0:
        respawn()

func shoot() -> void:
    var shot := SHOT_SCENE.instantiate()
    get_tree().current_scene.add_child(shot)
    shot.global_position = global_position + Vector2(30.0 * facing, -2.0)
    shot.direction = Vector2(facing, 0)

func take_damage(amount := 1) -> void:
    if invulnerable > 0.0:
        return
    health -= amount
    invulnerable = 1.0
    if health <= 0:
        respawn()

func respawn() -> void:
    global_position = Vector2(130, 450)
    velocity = Vector2.ZERO
    health = 5
    invulnerable = 1.0
