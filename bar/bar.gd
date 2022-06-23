extends Node2D

var normal_note_scn = preload("res://note/normal_note.tscn")
var big_note_scn = preload("res://note/big_note.tscn")

var notes_data = [
	{
		"pos": 0,
		"len": 100,
		"markers": ["d"]
	},
	{
		"pos": 100,
		"len": 100,
		"markers": ["d"]
	},
	{
		"pos": 200,
		"len": 100,
		"markers": ["d"]
	},
	{
		"pos": 300,
		"len": 100,
		"markers": ["d"]
	},
	{
		"pos": 400,
		"len": 100,
		"markers": ["DD"]
	},
	{
		"pos": 800,
		"len": 100,
		"markers": []
	},
	{
		"pos": 1200,
		"len": 100,
		"markers": ["KK"]
	}
]

var index = 0
var note_scale = 0.5
var length = 1600 

func _ready():
	add_notes()
	$Sprite2.position.x = length/2 

func add_notes():
	for note_data in notes_data:
		add_note(note_data)
		
func add_note(note_data):
	var note_scn = normal_note_scn
	var note_color_type = "blue"
	
	if (note_data.markers.has("DD")):
		note_color_type = "red"
		note_scn = big_note_scn
	elif (note_data.markers.has("KK")):
		note_color_type = "blue"
		note_scn = big_note_scn
	elif (note_data.markers.has("d")):
		note_color_type = "red"
	else:
		note_color_type = "blue"
		
	var note = note_scn.instance()
	note.color_type = note_color_type
	note.position = Vector2(float(note_data.pos)*note_scale, -20)
	
	$Notes.add_child(note)
	
