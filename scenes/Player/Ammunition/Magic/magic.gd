extends Node2D

#@onready var sprite = $Sprite
var type = "Fire"
var pos


func _ready():
	match type:
		"Fire": pass # sprite.set_texture()
		"Water": pass # sprite.set_texture()
		"Wind": pass # sprite.set_texture()
		"Earth": pass # sprite.set_texture()
	$CPUParticles2D.emitting = true
	global_position=pos
	


func _on_timer_timeout():
	queue_free()
