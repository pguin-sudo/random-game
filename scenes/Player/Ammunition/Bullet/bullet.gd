extends RigidBody2D

@onready var sprite = $Sprite
var type = "Fire"
var pos
var rota 
var dir
@export var speed = 2000


func _ready():
	match type:
		"Fire": pass # sprite.set_texture()
		"Water": pass # sprite.set_texture()
		"Wind": pass # sprite.set_texture()
		"Earth": pass # sprite.set_texture()
	global_position=pos
	global_rotation=rota


func _physics_process(_delta):
	linear_velocity = Vector2(speed, 0).rotated(dir)
	# move_and_slide()


func _on_area_2d_area_entered(area):
	queue_free()
