extends Control


const VOLUME_BUTTON = preload("res://assets/sprites/Tilesets/VolumeButton.png")
const MUSIC_BUTTON = preload("res://assets/sprites/Tilesets/MusicButton.png")
const NO_VOLUME = preload("res://assets/sprites/Tilesets/NoVolume.png")
const NO_MUSIC = preload("res://assets/sprites/Tilesets/NoMusic.png")

var music_bus = AudioServer.get_bus_index("Music")
var sound_bus = AudioServer.get_bus_index("Effects")


@onready var sound = $TextureRect/Sound
@onready var music = $TextureRect/Music

func _on_play_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_diary_pressed():
	$TextureRect/DiaryPages.visible = !$TextureRect/DiaryPages.visible


func _on_quit_pressed():
	get_tree().quit()


func _on_music_pressed():
	if AudioServer.is_bus_mute(music_bus):
		music.texture_normal = MUSIC_BUTTON
		AudioServer.set_bus_mute(music_bus, false)
	else:
		music.texture_normal = NO_MUSIC
		AudioServer.set_bus_mute(music_bus, true)


func _on_sound_pressed():
	if AudioServer.is_bus_mute(sound_bus):
		sound.texture_normal = VOLUME_BUTTON
		AudioServer.set_bus_mute(sound_bus, false)
	else:
		sound.texture_normal = NO_VOLUME
		AudioServer.set_bus_mute(sound_bus, true)
