extends Control

func _ready() -> void:
    $Center/Panel/VBox/BackButton.grab_focus()

func _on_back_button_pressed() -> void:
    get_tree().change_scene_to_file("res://level_1_2d.tscn")

func _on_menu_button_pressed() -> void:
    get_tree().change_scene_to_file("res://main_menu.tscn")
