extends Area2D

var player_near := false
var completed := false

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)
    $InteractLabel.visible = false

func _process(_delta: float) -> void:
    if player_near and not completed and Input.is_action_just_pressed("interact"):
        completed = true
        $InteractLabel.visible = false
        var player = get_tree().get_first_node_in_group("player")
        if player and player.has_method("level_complete"):
            player.level_complete()
        get_tree().change_scene_to_file("res://victory.tscn")

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        player_near = true
        $InteractLabel.visible = true

func _on_body_exited(body: Node2D) -> void:
    if body.is_in_group("player"):
        player_near = false
        $InteractLabel.visible = false
