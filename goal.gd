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
        var message := Label.new()
        message.text = "¡NIVEL 1 COMPLETADO!\nLlegaste a la puerta."
        message.position = Vector2(360, 250)
        message.add_theme_font_size_override("font_size", 32)
        get_tree().current_scene.add_child(message)
