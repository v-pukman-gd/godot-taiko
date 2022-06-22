extends Node2D

var note_scn = preload("res://note/note.tscn")

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
	var note = note_scn.instance()
	if (note_data.markers.has("DD")):
		note.type = "red"
		note.size = "big"
	elif (note_data.markers.has("KK")):
		note.type = "blue"
		note.size = "big"
	elif (note_data.markers.has("d")):
		note.type = "red"
	else:
		note.type = "blue"
		
	note.position = Vector2(float(note_data.pos)*note_scale, -20)
	
	$Notes.add_child(note)
	
