extends Node2D

var audio
var map
var audio_path = "res://songs/hansatom_-_Vitamins_CC_BY_NC/hansatom_-_Vitamins_CC_BY_NC.ogg" 
var map_path = "res://songs/hansatom_-_Vitamins_CC_BY_NC/hansatom_-_Vitamins_CC_BY_NC.mboy" 


#var audio_path = "res://songs/Middle_of_The_Night/Middle_of_The_Night_CC_BY_SA.ogg"
#var map_path = "res://songs/Middle_of_The_Night/Middle_of_The_Night_CC_BY_SA.mboy"

var tempo
var bar_length_in_m
var quarter_time_in_sec
var speed
var note_scale
var start_pos_in_sec
var start_pos_in_px
var pre_start_length

var data_ready = false

var track_scn = preload("res://track/track.tscn")
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
	print("start at:", start_bar_index)
	tempo = int(map.tempo)
	bar_length_in_m = 1600 # Godot meters
	quarter_time_in_sec = 60/float(tempo) # 60/60 = 1, 60/85 = 0.71
	speed = bar_length_in_m/float(4*quarter_time_in_sec) # each bar has 4 quarters # 
	note_scale = bar_length_in_m/float(4*400)
	start_pos_in_sec = (float(map.start_pos)/400.0) * quarter_time_in_sec
	start_pos_in_px = start_pos_in_sec * speed
	#pre_start_length = bar_length_in_m # bars count #bar_length_in_m
	
	music = music_scn.instance()
	music.audio = audio
	music.speed = speed
	music.tempo = tempo 
	# should include start_pos_in_px (related to start_pos_in_sec)
	music.pre_start_length = 1600 + start_pos_in_px 
	# include start_pos_in_sec here
	music.start_pos_in_sec = start_pos_in_sec + start_bar_index*4*quarter_time_in_sec # we confirm that all bars have fixed length - 4 quarters
	add_child(music)
	
	var bars = map.tracks[0].bars
	bars = bars.slice(start_bar_index, bars.size()-1)
	bars.push_front({"index": -1, "quarters_count": 4, "notes": []})
	
	
	track = track_scn.instance()	
	track.curr_bar_x = start_pos_in_px	
	track.bars_data = bars
	track.speed = speed
	track.note_scale = note_scale
	#track.position = $TrackPos.position
	$TrackC.add_child(track)	
	
	$Drums.connect("red_left", track, "on_red_left_pressed")
	$Drums.connect("red_right", track, "on_red_right_pressed")
	
	$Drums.connect("blue_left", track, "on_blue_left_pressed")
	$Drums.connect("blue_right", track, "on_blue_right_pressed")
	
	# set title
	$Title/Label.text = join_arr([map.audio.artist, map.audio.title], " - ")
	$Title/Genre/Label.text = join_arr([map.audio.genre, map.audio.subgenre], " / ")
	
	data_ready = true
	
func join_arr(arr, delimiter):
	var presents = []
	for el in arr: 
		if str(el) != "": presents.append(el)
		
	return PoolStringArray(presents).join(delimiter)

func _process(delta):
	if not data_ready:
		return
		
	track.process_with_time(music.time, delta)

#func _on_ReloadButton_pressed():
#	get_tree().change_scene("res://game.tscn")
