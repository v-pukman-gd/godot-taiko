extends Node2D


func _ready():
	hide()
	$Anim1.connect("animation_finished", self, "hide")
	#play()

func play():
	show()
	
	$Anim1.frame = 0
	$Anim1.play()
	
	$Anim2.frame = 0
	$Anim2.play()
	
