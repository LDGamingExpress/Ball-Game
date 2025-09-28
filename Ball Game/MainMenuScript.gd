extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Level1.tscn")


func _on_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://LevelSelection.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Credits.tscn")
