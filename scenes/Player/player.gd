extends CharacterBody2D

enum Style {
	MELEE, 
	RANGE,
	MAGIC, 
}

var face_direction = "Down"
var animation_to_play = "Wind"
var current_type = "Wind"
var current_style = Style.RANGE

var bullet_path = preload("res://scenes/Player/Ammunition/Bullet/bullet.tscn")
var magic_path = preload("res://scenes/Player/Ammunition/Magic/magic.tscn")

@export var speed = 500
@export var dash_speed = 15 * (10**3)
 
@onready var anim = $AnimatedSprite2D
@onready var cam = $Camera2D

func _ready():
	randomize()
	anim.stop()
	anim.play(animation_to_play)
	Globaldata.enemydie.connect(increase_score)

func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	velocity.normalized()
	

	if input_direction.length() > 0: 
		if abs(input_direction.x) > abs(input_direction.y): 	
			face_direction = "Left" if input_direction.x < 0 else "Right"
		else:
			face_direction = "Down" if input_direction.y > 0 else "Up"
	
	if velocity.length() <= 0.0: 
		#for idle anim using currenttype
		anim.play(current_type)
	else:
		animation_to_play = current_type + "Walk" + face_direction
		anim.play(animation_to_play)
	
	send_data()
	$PointNode.look_at(get_global_mouse_position())
	switch_type()
	attack()
	move_and_slide()

func switch_type():
	if Input.is_action_just_pressed("c"):
		match current_style:
			Style.MAGIC: current_style = Style.MELEE
			Style.MELEE: current_style = Style.RANGE
			Style.RANGE: current_style = Style.MAGIC


func attack():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): 
		match current_style:
			Style.RANGE: 
				if $ShootCooldown.is_stopped(): 
					$PointNode/Point/Particles.emitting = true
					attack_shoot()
			Style.MAGIC: 
				if $MagicCooldown.is_stopped(): attack_magic()
			Style.MELEE:
				if $MeleeCooldown.is_stopped():
					attack_melee()
	
	$PointNode/Point/Particles.emitting = false


func send_data():
	Globaldata.playerpositon = global_position
	Globaldata.type = current_type


func attack_shoot():
	var bullet = bullet_path.instantiate()
	bullet.dir = $PointNode.rotation
	bullet.pos = $PointNode/Point.global_position
	bullet.rota = $PointNode.global_rotation
	get_parent().add_child(bullet)
	$ShootCooldown.start()


func attack_magic():
	var magic = magic_path.instantiate()
	magic.pos = get_global_mouse_position()
	get_parent().add_child(magic)
	$MagicCooldown.start()


func attack_melee():
	var dash_vector = global_position.direction_to($PointNode/Point.global_position)
	velocity = dash_vector * dash_speed
	$MeleeCooldown.start()


func increase_score():
	cam.timer.start()
	$Canvas/Score.text = str(Globaldata.score)
