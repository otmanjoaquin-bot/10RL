extends Control

func _ready() -> void:
    $Center/Panel/VBox/StartButton.grab_focus()

func _on_start_button_pressed() -> void:
    get_tree().change_scene_to_file("res://level_1_2d.tscn")

func _on_exit_button_pressed() -> void:
    get_tree().quit()
