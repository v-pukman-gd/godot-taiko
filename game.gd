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
#var start_pos_in_px
var pre_start_length

var data_ready = false

var track_scn = preload("res://track.tscn")
var track

var music_scn = preload("res://music.tscn")
var music

var start_bar_index = 0

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
	print("setup:", start_bar_index)
	tempo = int(map.tempo)
	bar_length_in_m = 1600 # Godot meters
	quarter_time_in_sec = 60/float(tempo) # 60/60 = 1, 60/85 = 0.71
	speed = bar_length_in_m/float(4*quarter_time_in_sec) # each bar has 4 quarters # 
	note_scale = bar_length_in_m/float(4*400)
	start_pos_in_sec = (float(map.start_pos)/400.0) * quarter_time_in_sec
	#start_pos_in_px = start_pos_in_sec * speed
	pre_start_length = bar_length_in_m

	track = track_scn.instance()
	track.curr_bar_x = pre_start_length
	track.bars_data = map.tracks[0].bars.slice(start_bar_index, map.tracks[0].bars.size()-1)
	track.speed = Vector2(speed, 0)
	track.note_scale = note_scale
	track.position = Vector2(332, 192)
	add_child(track)
	
	music = music_scn.instance()
	music.audio = audio
	music.speed = speed
	music.pre_start_length = pre_start_length
	music.start_pos_in_sec = start_pos_in_sec + start_bar_index*4*quarter_time_in_sec # we confirm that all bars have fixed length - 4 quarters
	add_child(music)
	
	$Drums.connect("red_left", track, "on_red_left_pressed")
	$Drums.connect("red_right", track, "on_red_right_pressed")
	
	$Drums.connect("blue_left", track, "on_blue_left_pressed")
	$Drums.connect("blue_right", track, "on_blue_right_pressed")
	
	data_ready = true

func _process(delta):
	if not data_ready:
		return
		


#func _on_ReloadButton_pressed():
#	get_tree().change_scene("res://game.tscn")
