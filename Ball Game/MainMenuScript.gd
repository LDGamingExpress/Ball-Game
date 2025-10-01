extends Control

func _ready() -> void:
	Globals.Score = 0

func _on_start_button_pressed() -> void:
	Globals.Level = 0
	get_tree().change_scene_to_file("res://TutorialLevel.tscn")


func _on_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://LevelSelection.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Credits.tscn")
