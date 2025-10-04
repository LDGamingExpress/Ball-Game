extends Control

func _ready() -> void:
	$AudioStreamPlayer2D.play(Globals.MusicPos)

func _on_main_menu_button_pressed() -> void:
	Globals.MusicPos = $AudioStreamPlayer2D.get_playback_position()
	get_tree().change_scene_to_file("res://MainMenu.tscn")
