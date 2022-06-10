extends Node2D

signal red_left
signal red_right
signal blue_left
signal blue_right

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioRed.stream.set_loop(false)
	$AudioRedR.stream.set_loop(false)
	$AudioBlue.stream.set_loop(false)

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			var radius = $PointA.position.y - $PointB.position.y
			
			var x = event.position.x - $PointA.position.x
			var y = event.position.y - $PointA.position.y
			var c = sqrt(x*x + y*y)
			
			if c < radius:
				print("center touch!", c)
				
				$AnimationPlayer.play("press")
				if event.position.x < $PointA.position.x:					
					$AudioRed.play()
					emit_signal("red_left")
				else:
					$AudioRedR.play()
					emit_signal("red_right")
			else:
				if event.position.y > $PointC.position.y:
					print("side touch!", event.position.y)
					if event.position.x < $PointA.position.x:					
						$AudioBlue.play()
						emit_signal("blue_left")
					else:
						$AudioBlueR.play()
						emit_signal("blue_right")


#func play_red():
#	$AudioRed.play()
#
#func play_blue():
#	$AudioBlue.play()
