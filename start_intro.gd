extends Control

func _ready() -> void:
    await get_tree().create_timer(6.0).timeout
    get_tree().change_scene_to_file("res://level_1_2d.tscn")
