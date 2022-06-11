extends Node2D

#signal bar_index_updated
var map_bar_index = -1 

var bar_scn = preload("res://bar.tscn")

onready var bars_node = $Bars
var bars = []

var bars_data = [
		{
			"index": 0,
			"quarters_count": 4,
			"notes": []
		}, 
		{
			"index": 1,
			"quarters_count": 4,
			"notes": []
		}, 
		{
			"index": 2,
			"quarters_count": 4,
			"notes": [{
				"pos": 400,
				"len": 100,
				"markers": ["d"]
			}]
		}, 
		{
			"index": 3,
			"quarters_count": 4,
			"notes": [{
				"pos": 800,
				"len": 100,
				"markers": []
			}]
		}, 
		{
			"index": 4,
			"quarters_count": 4,
			"notes": [{
				"pos": 0,
				"len": 100,
				"markers": ["d"]
			}, {
				"pos": 300,
				"len": 100,
				"markers": ["DD"]
			}]
		}, 
		{
			"index": 5,
			"quarters_count": 4,
			"notes": [{
				"pos": 0,
				"len": 100,
				"markers": ["d"]
			}, {
				"pos": 300,
				"len": 100,
				"markers": ["KK"]
			}, {
				"pos": 1000,
				"len": 100,
				"markers": []
			}]
		}
	]

var curr_bar_x = 0
var curr_bar_index = 0

var note_scale = 0.5
var speed = Vector2(800, 0)

var colliding_notes = []

func _ready():
	for i in range(0, 4):
		add_bar()
		
func add_bar():
	print("add bar")
	if curr_bar_index >= bars_data.size(): return
	var bar_data = bars_data[curr_bar_index]
	if not bar_data: return
		
	var bar = bar_scn.instance()
	bar.index = bar_data.index
	bar.position = Vector2(curr_bar_x, 80)
	bar.note_scale = note_scale
	bar.notes_data = bar_data.notes
	bar.length = bar_data.quarters_count * 400 * note_scale
	
	bars.append(bar)
	bars_node.add_child(bar)
	
	curr_bar_x += bar.length
	curr_bar_index += 1
	
func _process(delta):
	bars_node.translate(-speed*delta)
	
	for bar in bars:		
		if bar.global_position.x + bar.length < self.global_position.x:
			remove_bar(bar)
			add_bar()
			
		if bar.global_position.x <= self.global_position.x:
			if map_bar_index < bar.index:
				map_bar_index = bar.index
				#emit_signal("bar_index_updated", map_bar_index)
				print("bar_index_updated:", map_bar_index)
				Global.emit_signal("bar_index_updated", map_bar_index)
			

func remove_bar(bar):
	print("delete bar")
	bar.queue_free()
	bars.erase(bar)

func _on_Picker_area_entered(area):
	if area.is_in_group("note"):
		area.get_parent().is_colliding = true
		colliding_notes.push_back(area.get_parent())
		#area.get_parent().queue_free()
		#print(area.get_parent())

func _on_Picker_area_exited(area):
	if area.is_in_group("note"):
		area.get_parent().is_colliding = false
		
		for n in colliding_notes:
			if n == area.get_parent():				
				colliding_notes.erase(n)
				
		#area.get_parent().queue_free()
		#print(area.get_parent())
		
func on_red_left_pressed():
	print("RL")
	collect_by_type("red")
	
func on_red_right_pressed():
	print("RR")
	collect_by_type("red")

func on_blue_left_pressed():
	print("BL")
	collect_by_type("blue")
		
func on_blue_right_pressed():
	print("BR")
	collect_by_type("blue")
	

func collect_by_type(type):
	var note = colliding_notes.pop_front()
	if note:
		if note.type == type:
			note.collect()
