extends Node2D

onready var anim = $Anim1 #$AnimatedSprite5

func _ready():
	hide()
	anim.connect("animation_finished", self, "hide")

func play(size, collected):
	show()
	
	if collected:
		if size == "big":
			anim.scale = Vector2(0.8, 0.8)
		else:
			anim.scale = Vector2(0.6, 0.6)
			
		anim.frame = 0
		anim.play()
	
