extends "res://note/base_note.gd"

const SCORE = 2020

func _on_collect(side):
	collected = true
	GameEvent.emit_signal("note_collected", {"size_type": size_type, "color_type": color_type, "score": SCORE})
	hide()
	
	return true

func _on_fail():
	failed = true
	GameEvent.emit_signal("note_failed", {"size_type": size_type, "color_type": color_type})
