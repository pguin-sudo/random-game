extends Node

#layer: 
#1 player recieve damage
#2 bullet recieve damage
#5 enemy recieve damage
#6 enemy damage
 

signal enemydie
var playerpositon
var type
var score = 0

func _ready():
	randomize()


func enemydied():
	score += 1 
	
