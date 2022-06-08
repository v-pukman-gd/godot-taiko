extends Node2D

var note_scn = preload("res://note.tscn")

var bar_data = {
			"index": 2,
			"quarters_count": 4,
			"notes": [
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
		}

var note_scale = 0.5
var speed

func _ready():
	add_notes()

func add_notes():
	for note_data in bar_data.notes:
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
