extends Node

onready var player = $AudioStreamPlayer

#var audio = preload("res://songs/Middle_of_The_Night/Middle_of_The_Night_CC_BY_SA.ogg")
var audio
var speed = 800
var tempo = 60
var pre_start_length = 1600
var start_pos_in_sec = 0
var started = false

var time = 0
var beat = 0
var pre_start_time = 0

const COMPENSATE_FRAMES = 0
const COMPENSATE_HZ = 60.0

func _ready():
	if audio:
		player.stream = audio
		player.stream.set_loop(false)
	
func start():
	started = true
	player.play(start_pos_in_sec) # !!!
	#player.play(0)
	#anim.play("sound_on")
	
func _process(delta):
	#if not game.game_started: return

	if not started:
		#print(pre_start_length)
		pre_start_length -= speed*delta
		time += delta
		if pre_start_length <= 0:
			pre_start_time = time
			time = 0
			start()
			#return
			
	
	if started:		
		time = player.get_playback_position() + AudioServer.get_time_since_last_mix()
		time -= AudioServer.get_output_latency()
		time += (1/COMPENSATE_HZ)*COMPENSATE_FRAMES
		time += pre_start_time
		time -= start_pos_in_sec
		
		#time += start_pos_in_sec
		#print("M Time is: ", time)
		
		#beat = int(time * tempo / 60.0)
		#print("beat is: ", beat)
