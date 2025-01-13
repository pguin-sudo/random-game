extends CharacterBody2D

@export var speed = 100
@export var distance = 300.0

func _process(delta):
	var playerpos = Globaldata.playerpositon
	
	if playerpos is Vector2:
		print(global_position.distance_to(playerpos))

		if global_position.distance_to(playerpos) > distance: 
			velocity = global_position.direction_to(playerpos) * speed
			#print("moving")
			#print(global_position)
		else: velocity = Vector2.ZERO
	move_and_slide() 
