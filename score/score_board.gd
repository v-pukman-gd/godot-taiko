extends Node2D

var notes_count = 0

var total_score = 0
var temp_score = 0

const COLLECTED_SCORE = 2020

func _ready():
	update_labels()
	
	GameEvent.connect("note_collected", self, "on_note_collected")
	GameEvent.connect("note_failed", self, "on_note_failed")
	
func on_note_collected(note):
	notes_count += 1
	temp_score = note.score
	total_score += note.score
	update_labels()

func on_note_failed(note):
	notes_count = 0
	update_labels()
	
func update_labels():
	# notes count
	$DrumScoreC/NotesCount.notes_count = notes_count

	# temp score
	$TempScore/Label.text = str(temp_score)
	if temp_score == 0:
		$TempScore/Label.hide()
	else:
		$TempScore/Label.show()
		
	# total score
	$TotalScore/Label.text = str(total_score)
	
	
