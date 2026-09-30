extends CharacterBody2D

@export var projectile_scene: PackedScene
@export var detection_range := 300.0
var player
var health := 2
var cooldown := 0.0

func _ready():
 player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
 cooldown -= delta
 if player and global_position.distance_to(player.global_position) < detection_range and cooldown <= 0:
  shoot()
  cooldown = 2.0

func shoot():
 if projectile_scene:
  var shot = projectile_scene.instantiate()
  shot.direction = (player.global_position - global_position).normalized()
  get_parent().add_child(shot)
  shot.global_position = global_position

func take_damage():
 health -= 1
 modulate = Color.RED
 await get_tree().create_timer(0.1).timeout
 modulate = Color.WHITE
 if health <= 0:
  queue_free()
