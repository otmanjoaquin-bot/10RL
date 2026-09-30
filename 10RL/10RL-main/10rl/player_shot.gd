extends Node2D
var speed = 500.0
func _process(delta):
	position.x += speed * delta
	if position.x > 2000: queue_free()
func _ready():
	var s=Sprite2D.new()
	add_child(s)
