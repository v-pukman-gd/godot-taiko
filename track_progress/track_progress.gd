extends Node2D

var notes_count = 100 #setget set_notes_count, _
var curr_value = 0

func _ready():
	GameEvent.connect("note_collected", self, "on_note_collected")


func on_note_collected(note):
	curr_value += 50.0/notes_count
	print("notes_count", notes_count, "curr_val", curr_value)
	$Texture/TextureProgress.value = int(curr_value)
	

func _on_Timer_timeout():
	#$Texture/TextureProgress.value += 1
	pass
