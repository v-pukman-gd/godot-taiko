extends Node2D

var notes_count = 0

func _ready():
	update_notes_count_label()
	GameEvent.connect("note_collected", self, "on_note_collected")
	GameEvent.connect("note_failed", self, "on_note_failed")
	
func on_note_collected():
	notes_count += 1
	update_notes_count_label()

func on_note_failed():
	notes_count = 0
	update_notes_count_label()
	
func update_notes_count_label():
	$DrumScoreC/NotesCount.notes_count = notes_count
