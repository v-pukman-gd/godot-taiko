extends Node2D

var size = "normal" # "big"
var type = "blue" # "red"

const NORMAL_SCALE = 0.8
const BIG_SCALE = 1.25

func _ready():
	set_sprite()
	
func set_sprite():
	match type:
		"red": $Sprite.frame = 7
		"blue": $Sprite.frame = 1
		
	match size:
		"normal": 
			$Sprite.scale = Vector2(NORMAL_SCALE,NORMAL_SCALE)
			$Sprite.position = Vector2(-45, -45)
		"big": 
			$Sprite.scale = Vector2(BIG_SCALE,BIG_SCALE)
			$Sprite.position = Vector2(-71, -71)

