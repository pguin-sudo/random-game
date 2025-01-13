extends CharacterBody2D

@export var speed = 1000

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	velocity.normalized()

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	send_data()

func send_data():
	Globaldata.get_player_position(global_position)
	
