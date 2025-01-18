extends Node

#layer: 
#1 player recieve damage
#2 bullet and melee and magic recieve damage
#3 enemy recieve melee damage
#4 enemy recieve magic damage
#5 enemy recieve range damage
#
#6 enemy damage


signal enemydie
var playerpositon
var type
var score = 0

func _ready():
	randomize()


func enemydied():
	score += 1 
	
