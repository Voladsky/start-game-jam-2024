extends Control





func _on_play_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_diary_pressed():
	$TextureRect/DiaryPages.visible = !$TextureRect/DiaryPages.visible


func _on_quit_pressed():
	get_tree().quit()
