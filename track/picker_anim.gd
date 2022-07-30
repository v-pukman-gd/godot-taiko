extends Node2D

onready var anim = $AnimatedSprite5
onready var anim2 = $AnimatedSprite6

func _ready():
	hide()
	anim.connect("animation_finished", self, "hide")

func play():
	show()
	
	anim.frame = 0
	anim.play()
	
	anim2.frame = 0
	anim2.play()

	
