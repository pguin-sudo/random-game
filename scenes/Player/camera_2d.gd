extends Camera2D

@onready var timer = $shakingtime
@export var shake = 25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer.is_stopped():
		shakescreen()
		return
	position_smoothing_enabled = true
	offset = Vector2.ZERO

func shakescreen():
	var shakerange = Vector2(randf_range(-shake,shake), randf_range(-shake,shake))
	position_smoothing_enabled = false
	offset += shakerange

	
