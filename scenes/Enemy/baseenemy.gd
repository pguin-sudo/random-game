extends CharacterBody2D

@export var speed = 400


func _physics_process(delta):
	var playerpos = Globaldata.playerpositon
	if global_position.distance_to(playerpos) < 10: 
		velocity = global_position.direction_to(playerpos)
		print("moving")
		print(global_position)
	move_and_slide() 
	print("stopped")
