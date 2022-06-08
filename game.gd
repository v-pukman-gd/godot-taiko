extends Node2D

var audio
var map
var audio_path = "res://songs/Middle_of_The_Night/Middle_of_The_Night_CC_BY_SA.ogg"
var map_path = "res://songs/Middle_of_The_Night/Middle_of_The_Night_CC_BY_SA.mboy"

var tempo
var bar_length_in_m
var quarter_time_in_sec
var speed
var note_scale
var start_pos_in_sec
var start_pos_in_px
var pre_start_duration_in_m

var data_ready = false

func _ready():
	audio = load(audio_path)
	map = load_map()
	setup()
	
func load_map():
	var file = File.new()
	file.open(map_path, File.READ)
	var content = file.get_as_text()
	file.close()
	return JSON.parse(content).get_result()
	
func setup():
	tempo = int(map.tempo)
	bar_length_in_m = 1600 # Godot meters
	quarter_time_in_sec = 60/float(tempo) # 60/60 = 1, 60/85 = 0.71
	speed = bar_length_in_m/float(4*quarter_time_in_sec) # each bar has 4 quarters # 
	note_scale = bar_length_in_m/float(4*400)
	start_pos_in_sec = (float(map.start_pos)/400.0) * quarter_time_in_sec
	start_pos_in_px = start_pos_in_sec * speed
	pre_start_duration_in_m = bar_length_in_m
	
	data_ready = true

func _process(delta):
	if not data_ready:
		return
		
	print(audio, map.tracks)
