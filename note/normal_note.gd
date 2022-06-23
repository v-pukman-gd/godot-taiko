extends "res://note/base_note.gd"

const SCORE = 2020

func _on_collect(side):
	collected = true
	GameEvent.emit_signal("note_collected", SCORE)
	hide()
	
	return true

func _on_fail():
	failed = true
	GameEvent.emit_signal("note_failed")
