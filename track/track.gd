extends Node2D

var map_bar_index = -1  # track exact bar index 

var bar_scn = preload("res://bar/bar.tscn")
var collect_anim = preload("res://note/collect_note_anim.tscn")

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


var note_scale = 0.5
var speed = 800
#var pre_start_length = 0

var curr_bar_x = 0
var curr_bar_index = 0

var colliding_notes = []

func _ready():
	# skip bars, but update curr_bar_x	
#	if curr_bar_index > 0:
#		for i in range(0, curr_bar_index):
#			#var bar_length = bars_data[i].quarters_count * 400 * note_scale
#			#bars_node.position.x -= bar_length
#
#			var bar = bar_scn.instance()
#			bar.index = -1
#			bar.position = Vector2(curr_bar_x, 80)
#			bar.note_scale = note_scale
#			bar.notes_data = []
#			bar.length = 4 * 400 * note_scale
#
#			bars.append(bar)
#			bars_node.add_child(bar)
#
#			curr_bar_x += bar.length
#			bars_node.position.x -= bar.length
	
	
	#if pre_start_length > 0:
	#	for i in range(0, pre_start_length):	
	#		bars_data.push_front({"index": -1, "quarters_count": 4, "notes": []})
		  
		
	#  add bars
	for i in range(0, 4):
		add_bar()
		
	#bars_node.position.x -= 4 * 400 * note_scale * curr_bar_index
		
	
func add_bar():
	#print("add bar")
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
	
func process_with_time(time, delta):
	#print("map_bar_index:", map_bar_index)
	#print("tpos: ", $BarsPosition.position.x)
	
	bars_node.position.x -= speed*delta
	
	var position_x = -time * speed + $BarsPosition.position.x
	
	#print("x: ", position_x)
	#print("curr x:", bars_node.position.x)
		
	if (bars_node.position.x - position_x) > speed*delta*2:
		print("FIX delay! ", bars_node.position.x - position_x)
		bars_node.position.x = position_x	
	
	
	for bar in bars:		
		if bar.global_position.x + bar.length < self.global_position.x:
			remove_bar(bar)
			add_bar()
			
		if bar.global_position.x <= self.global_position.x:
			if map_bar_index < bar.index:
				map_bar_index = bar.index
				#emit_signal("bar_index_updated", map_bar_index)
				#print("bar_index_updated:", map_bar_index)
				GameEvent.emit_signal("bar_index_updated", map_bar_index)
			

func remove_bar(bar):
	#print("delete bar")
	bar.queue_free()
	bars.erase(bar)

func _on_Picker_area_entered(area):
	if area.is_in_group("note"):
		#area.get_parent().is_colliding = true
		colliding_notes.push_back(area.get_parent())
		#area.get_parent().queue_free()
		#print(area.get_parent())

func _on_Picker_area_exited(area):
	if area.is_in_group("note"):
		#area.get_parent().is_colliding = false
		
		for n in colliding_notes:
			if n == area.get_parent():
				n.fail()				
				colliding_notes.erase(n)
				
		#area.get_parent().queue_free()
		#print(area.get_parent())
		
func on_red_left_pressed():
	#print("RL")
	collect_by_type("red", 'L')
	
func on_red_right_pressed():
	#print("RR")
	collect_by_type("red", 'R')

func on_blue_left_pressed():
	#print("BL")
	collect_by_type("blue", 'L')
		
func on_blue_right_pressed():
	#print("BR")
	collect_by_type("blue", 'R')
	

func collect_by_type(color_type, side):
	for n in colliding_notes:
		var d = n.global_position.x - $Picker.global_position.x
		if d <= 90 and d > -45:
			if n.color_type == color_type:
				var collected = n.collect(side)
				if collected:
					colliding_notes.erase(n)
					play_collect_anim(n)
					break
		elif d < -45 or n.color_type != color_type:
			n.fail()
			colliding_notes.erase(n)
			
func play_collect_anim(note):
	var anim = collect_anim.instance()
	
	anim.color_type = note.color_type
	anim.size_type = note.size_type
	anim.get_node("AnimationPlayer").connect("animation_finished", self, "remove_collect_anim", [anim])
	$CollectedNotesC.add_child(anim)
	
func remove_collect_anim(name, anim):
	anim.queue_free()
