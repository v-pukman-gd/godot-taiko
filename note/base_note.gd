extends Node2D

var color_type = "blue"
var size_type = "normal"

var collected = false
var failed = false

func _ready():
	_on_ready()
	
func _on_ready():
	set_group()
	set_color_type()
	
func set_color_type():
	match color_type:
		"red": $Sprite.frame = 7
		"blue": $Sprite.frame = 1
		
func set_group():
	$Area2D.add_to_group("note")
		
func collect(side):
	if collected or failed: return
	return _on_collect(side)
	
func _on_collect(side):
	return true

func fail():
	if collected or failed: return
	_on_fail()
	
func _on_fail():
	pass

