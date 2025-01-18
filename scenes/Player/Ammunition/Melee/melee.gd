extends Node2D

var rota

func _ready():
	global_rotation = rota
	$CPUParticles2D.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_area_2d_area_entered(area):
	queue_free()
