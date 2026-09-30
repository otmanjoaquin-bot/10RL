extends Area2D

var completed := false

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
    if completed:
        return
    if body.is_in_group("player"):
        completed = true
        if body.has_method("level_complete"):
            body.level_complete()
        get_tree().change_scene_to_file("res://victory.tscn")
