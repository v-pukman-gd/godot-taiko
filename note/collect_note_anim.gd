extends Node2D

var color_type = "blue"
var size_type = "normal" 

func _ready():
	setup_color()
	setup_size()

func setup_color():
	match color_type:
		"red": $Sprite.frame = 7
		"blue": $Sprite.frame = 1
		
func setup_size():
	match size_type:
		"normal": $Sprite.scale = Vector2(0.8, 0.8)
		"big": $Sprite.scale = Vector2(1.25, 1.25)
