tool
extends "res://note/base_note.gd"

const SCORE = 4040

var side_l = false
var side_r = false

func _init():
	size_type = "big"

func _on_collect(side):
	if side == "L": side_l = true
	elif side == "R": side_r = true
	if side_l and side_r:
		collected = true
		GameEvent.emit_signal("note_collected", {"size_type": size_type, "color_type": color_type, "score": SCORE})
		hide()
		return true
	else:
		return false

func _on_fail():
	failed = true
	GameEvent.emit_signal("note_failed", {"size_type": size_type, "color_type": color_type})
