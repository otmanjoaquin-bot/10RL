extends Area2D

@export var speed := 620.0
var direction := Vector2.RIGHT

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position += direction.normalized() * speed * delta
	if global_position.x < -100.0 or global_position.x > 1250.0 or global_position.y < -100.0 or global_position.y > 800.0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1)
	queue_free()
