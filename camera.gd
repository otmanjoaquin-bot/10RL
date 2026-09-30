extends Camera2D

@export var target_path: NodePath = NodePath("../Player")

func _ready() -> void:
    var target := get_node_or_null(target_path) as Node2D
    if target:
        global_position = target.global_position

func _process(_delta: float) -> void:
    var target := get_node_or_null(target_path) as Node2D
    if target:
        global_position = target.global_position
