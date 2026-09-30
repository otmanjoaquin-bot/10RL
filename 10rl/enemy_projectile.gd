extends Node2D

var direction := -1
var speed := 260.0

func _process(delta):
	position.x += direction * speed * delta
	if abs(position.x) > 3000:
		queue_free()
