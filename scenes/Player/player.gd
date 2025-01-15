extends CharacterBody2D


var face_direction = ""
var animation_to_play = "Wind"
var currenttype = "Wind"
var bulletpath = preload("res://scenes/Player/Bullet/Bullet.tscn")

@export var speed = 500

@onready var anim = $AnimatedSprite2D
@onready var cam = $Camera2D

func _ready():
	randomize()
	anim.stop()
	anim.play(animation_to_play)
	Globaldata.enemydie.connect(killedenemy)

func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	velocity.normalized()
	
	move_and_slide()
	if input_direction.length() > 0: 
		if abs(input_direction.x) > abs(input_direction.y): 	
			face_direction = "Left" if input_direction.x < 0 else "Right"
		else:
			face_direction = "Down" if input_direction.y > 0 else "Up"
	
	if velocity.length() <= 0.0: 
		#for idle anim using currenttype
		anim.play(currenttype)
	else:
		animation_to_play = currenttype + "Walk" + face_direction
		anim.play(animation_to_play)
	
	send_data()
	$PointNode.look_at(get_global_mouse_position())
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): 
		$PointNode/Point/Particles.emitting = true
		if $ShootCooldown.is_stopped(): shoot()
		return
	$PointNode/Point/Particles.emitting = false


func send_data():
	Globaldata.playerpositon = global_position
	Globaldata.type = currenttype


func shoot():
	var bullet = bulletpath.instantiate()
	bullet.dir = $PointNode.rotation
	bullet.pos = $PointNode/Point.global_position
	bullet.rota = $PointNode.global_rotation
	get_parent().add_child(bullet)
	$ShootCooldown.start()
	# print("done")
	

func killedenemy():
	cam.timer.start()
	$Canvas/Score.text = str(Globaldata.score)
