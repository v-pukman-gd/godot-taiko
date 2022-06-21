extends Node2D

signal red_left
signal red_right
signal blue_left
signal blue_right

func _ready():
	$AudioRedL.stream.set_loop(false)
	$AudioRedR.stream.set_loop(false)
	
	$AudioBlueL.stream.set_loop(false)
	$AudioBlueR.stream.set_loop(false)

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			var radius = $PointA.position.y - $PointB.position.y
			
			var x = event.position.x - $PointA.position.x
			var y = event.position.y - $PointA.position.y
			var c = sqrt(x*x + y*y)
			
			if c < radius:
				if event.position.x < $PointA.position.x:
					on_red_pressed('L')
				else:
					on_red_pressed('R')
			else:
				if event.position.y > $PointC.position.y:
					if event.position.x < $PointA.position.x:
						on_blue_pressed('L')
					else:
						on_blue_pressed('R')
						
	elif event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_A:
				on_red_pressed('L')
			elif event.scancode == KEY_S:
				on_red_pressed('R')
			elif event.scancode == KEY_K:
				on_blue_pressed('L')
			elif event.scancode == KEY_L:
				on_blue_pressed('R')


func on_red_pressed(side):
	if side == 'L':
		$AudioRedL.play()
		emit_signal("red_left")
		$AnimationPlayer.play("press")
	elif side == 'R':
		$AudioRedR.play()
		emit_signal("red_right")
		$AnimationPlayer.play("press")
		
func on_blue_pressed(side):
	if side == 'L':
		$AudioBlueL.play()
		emit_signal("blue_left")
	elif side == 'R':
		$AudioBlueR.play()
		emit_signal("blue_right")
