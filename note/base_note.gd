extends Node2D

var color_type = "blue"
var size_type = "normal"

var collected = false
var failed = false

var red_sprite = preload("res://note/red_sprite.tscn")
var blue_sprite = preload("res://note/blue_sprite.tscn")

func _ready():
	_on_ready()
	
func _on_ready():
	set_group()
	set_sprite()
	set_label()
	
func set_sprite():
	var sprite
	match color_type:
		"red": sprite = red_sprite.instance()
		"blue": sprite = blue_sprite.instance()
		
	if sprite:
		$Sprite.add_child(sprite)
		
func set_group():
	$Area2D.add_to_group("note")
	
func set_label():
	$Label.text = get_label_text()
	
func get_label_text():
	if color_type == "red":
		if size_type == "big":
			return "DON"
		else:
			return "Do"
	elif color_type == "blue":
		if size_type == "big":
			return "KA"
		else:
			return "Ka"
	else:
		return "" #TODO: add yellow notes
		
	
		
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

