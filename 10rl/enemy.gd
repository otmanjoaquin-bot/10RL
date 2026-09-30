extends CharacterBody2D

@export var health := 2
@export var detection_range := 430.0
@export var projectile_scene: PackedScene
@export var projectile_speed := 280.0
@export var shoot_interval := 1.5

var player: Node2D
var shoot_timer := 0.7
var gravity := 1400.0

func _ready() -> void:
    player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta
    if player == null:
        player = get_tree().get_first_node_in_group("player")
    if player:
        var distance := global_position.distance_to(player.global_position)
        if distance <= detection_range:
            var dx := sign(player.global_position.x - global_position.x)
            $Sprite2D.flip_h = dx < 0
            shoot_timer -= delta
            if shoot_timer <= 0.0:
                shoot_at_player()
                shoot_timer = shoot_interval
    move_and_slide()

func shoot_at_player() -> void:
    if projectile_scene == null or player == null:
        return
    var shot = projectile_scene.instantiate()
    get_tree().current_scene.add_child(shot)
    shot.global_position = global_position + Vector2(0, -8)
    shot.direction = (player.global_position - global_position).normalized()
    shot.speed = projectile_speed

func take_damage(amount := 1) -> void:
    health -= amount
    modulate = Color(1.0, 0.45, 0.45)
    await get_tree().create_timer(0.1).timeout
    if is_instance_valid(self):
        modulate = Color.WHITE
    if health <= 0:
        queue_free()
