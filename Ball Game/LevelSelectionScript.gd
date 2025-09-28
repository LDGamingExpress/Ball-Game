extends Control


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_l_1_button_pressed() -> void:
	Globals.Levels = 1
	get_tree().change_scene_to_file("res://Level1.tscn")


func _on_l_6_button_pressed() -> void:
	Globals.Levels = 6
	get_tree().change_scene_to_file("res://Level6.tscn")


func _on_l_2_button_pressed() -> void:
	Globals.Levels = 2
	get_tree().change_scene_to_file("res://Level2.tscn")


func _on_l_7_button_pressed() -> void:
	Globals.Levels = 7
	get_tree().change_scene_to_file("res://Level7.tscn")


func _on_l_3_button_pressed() -> void:
	Globals.Levels = 3
	get_tree().change_scene_to_file("res://Level3.tscn")


func _on_l_8_button_pressed() -> void:
	Globals.Levels = 8
	get_tree().change_scene_to_file("res://Level8.tscn")


func _on_l_4_button_pressed() -> void:
	Globals.Levels = 4
	get_tree().change_scene_to_file("res://Level4.tscn")


func _on_l_9_button_pressed() -> void:
	Globals.Levels = 9
	get_tree().change_scene_to_file("res://Level9.tscn")


func _on_l_5_button_pressed() -> void:
	Globals.Levels = 5
	get_tree().change_scene_to_file("res://Level5.tscn")


func _on_l_10_button_pressed() -> void:
	Globals.Levels = 10
	get_tree().change_scene_to_file("res://Level10.tscn")
