extends Control


func _ready() -> void:
	$VBoxContainer/Music.button_pressed = !AudioServer.is_bus_mute(1)
	$VBoxContainer/SFX.button_pressed = !AudioServer.is_bus_mute(2)


func _on_music_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, !toggled_on)


func _on_sfx_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(2, !toggled_on)


func _on_open_pressed() -> void:
	visible = true


func _on_exit_pressed() -> void:
	visible = false
