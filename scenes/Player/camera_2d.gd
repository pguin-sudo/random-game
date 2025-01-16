extends Camera2D

@onready var timer = $ShakingCooldown
@export var shake = 10


func _physics_process(delta: float):
	if not timer.is_stopped():
		shakescreen()
		return
	position_smoothing_enabled = true
	offset = Vector2.ZERO


func shakescreen():
	var shakerange = Vector2(randf_range(-shake,shake), randf_range(-shake,shake))
	position_smoothing_enabled = false
	offset += shakerange

	
