extends Node2D

var size = "normal" # "big"
var type = "blue" # "red"

const NORMAL_SCALE = 0.8
const BIG_SCALE = 1.25

var collected = false
var is_colliding = false
var failed = false

#var fail_mat = preload("res://fail_shader_mat.tres")

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

#func _process(delta):
#	if is_colliding and not collected:
#		self.scale += Vector2(1, 1)*delta
			
func collect():
	if failed: return
	
	collected = true
	Global.emit_signal("note_collected")
	hide()
		
func fail():
	if collected: return
	
	failed = true
	#$Sprite.material = fail_mat
#func is_trigger_pressed():
#
#	if type == "red":
#		if size == "normal":
#			return Input.is_action_just_pressed("red_left") or Input.is_action_just_pressed("red_right")
#		elif size == "big":
#			return Input.is_action_just_pressed("red_left") and Input.is_action_just_pressed("red_right")
#		else:
#			return false
#	elif type == "blue":
#		if size == "normal":
#			return Input.is_action_just_pressed("blue_left") or Input.is_action_just_pressed("blue_right")
#		elif size == "big":
#			return Input.is_action_just_pressed("blue_left") and Input.is_action_just_pressed("blue_right")
#		else:
#			return false
#	else:
#		return false
