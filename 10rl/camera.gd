extends Camera2D

@export var target_path: NodePath = NodePath("../Player")

func _ready() -> void:
    var target := get_node_or_null(target_path) as Node2D
    if target:
        position = target.position
        top_level = false
