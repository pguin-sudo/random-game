extends Control

var is_paused = false 


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel", true):
		toggle_pause(!is_paused)


func toggle_pause(toggled) -> void:
	is_paused = toggled
	
	visible = is_paused
	get_tree().paused = is_paused;
	$Options.visible = false
	$AudioStreamPlayer.playing = is_paused


func go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/Menu/main_menu.tscn")


func _exit_tree() -> void:
	toggle_pause(false)
