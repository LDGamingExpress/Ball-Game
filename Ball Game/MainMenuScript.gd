extends Control

func _ready() -> void:
	Globals.Score = 0
	$AudioStreamPlayer2D.play(Globals.MusicPos)

func _on_start_button_pressed() -> void:
	Globals.Level = 0
	get_tree().change_scene_to_file("res://TutorialLevel.tscn")


func _on_level_button_pressed() -> void:
	Globals.MusicPos = $AudioStreamPlayer2D.get_playback_position()
	get_tree().change_scene_to_file("res://LevelSelection.tscn")


func _on_credits_button_pressed() -> void:
	Globals.MusicPos = $AudioStreamPlayer2D.get_playback_position()
	get_tree().change_scene_to_file("res://Credits.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
