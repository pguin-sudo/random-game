extends CharacterBody2D

@export var speed = 100
@export var distance = 300.0

@onready var damage = 10
@onready var hp = 10
@onready var anim = $AnimatedSprite2D
var animation_to_play = "Enemy1" 

var face_direction = ""
var type = "Fire"

func _process(_delta):
	var playerpos = Globaldata.playerpositon
	
	if playerpos is Vector2:
		if global_position.distance_to(playerpos) > distance: 
			velocity = global_position.direction_to(playerpos) * speed
			# print("moving")
			# print(global_position)
			move_and_slide()
				
			if velocity.length() > 0: 
				if abs(velocity.x) > abs(velocity.y):
					animation_to_play = "Enemy1" + "Walk" + ("Left" if velocity.x < 0 else "Right")
				else:
					face_direction = "Enemy1" + "Walk" + ("Down" if velocity.y > 0 else "Up")
					
				animation_to_play = face_direction 
				anim.play(animation_to_play)
			else: 
				pass
				
				# anim.play(Idle)
				
		else: velocity = Vector2.ZERO
	move_and_slide() 



func Damaged():
	match type:
		"Fire": hp -= 15
		"Water": hp -=  5
		"Air": hp -=  5
		"Earth": hp -= 5
	if hp <= 0: 
		Globaldata.enemydied()
		Globaldata.emit_signal("enemydie")
		queue_free()


func _on_damage_area_entered(area):
	print("recieved 0")
	pass


func _on_recieve_area_entered(area):
	Damaged()
	print("recieved 1")
