extends Node

onready var player = $AudioStreamPlayer

#var audio = preload("res://songs/Middle_of_The_Night/Middle_of_The_Night_CC_BY_SA.ogg")
var audio
var speed = 800
var pre_start_length = 1600
var start_pos_in_sec = 0
var started = false

func _ready():
	if audio:
		player.stream = audio
		player.stream.set_loop(false)
	
func start():
	started = true
	player.play(start_pos_in_sec)
	#player.play(0)
	#anim.play("sound_on")
	
func _process(delta):
	#if not game.game_started: return
	if not started:
		#print(pre_start_length)
		pre_start_length -= speed*delta
		if pre_start_length <= 0:
			start()
			return
