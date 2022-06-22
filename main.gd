extends Control

var game_scn = preload("res://game.tscn")

func _ready():
	load_game($Control.start_bar_index)
	GameEvent.connect("bar_index_updated", $Control, "on_bar_index_updated")
	
func load_game(start_bar_index):
	for g in $GameC.get_children():
		g.hide()
		g.queue_free()
	
	var game = game_scn.instance()
	game.start_bar_index = start_bar_index
	$GameC.add_child(game)

func _on_Control_reload(start_bar_index):
	print("reload at:", start_bar_index)
	load_game(start_bar_index)
	
