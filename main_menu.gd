extends Control

func _ready() -> void:
    $StartButton.grab_focus()

func _on_start_button_pressed() -> void:
    get_tree().change_scene_to_file("res://start_intro.tscn")

func _on_exit_button_pressed() -> void:
    get_tree().quit()
