extends Node2D

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

func _ready():
	for i in range(0, 4):
		add_bar()
		
func add_bar():
	print("add bar")
	if curr_bar_index >= bars_data.size(): return
	var bar_data = bars_data[curr_bar_index]
	if not bar_data: return
		
	var bar = bar_scn.instance()
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

func remove_bar(bar):
	print("delete bar")
	bar.queue_free()
	bars.erase(bar)

func _on_Picker_area_entered(area):
	if area.is_in_group("note"):
		area.get_parent().is_colliding = true
		#area.get_parent().queue_free()
		#print(area.get_parent())

func _on_Picker_area_exited(area):
	if area.is_in_group("note"):
		area.get_parent().is_colliding = false
		#area.get_parent().queue_free()
		#print(area.get_parent())
