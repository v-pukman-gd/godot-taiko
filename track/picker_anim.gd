extends Node2D

onready var anim = $Anim1 #$AnimatedSprite5
#onready var anim2 = $AnimatedSprite6

#onready var note_sprite = $NoteSprite

func _ready():
	hide()
	anim.connect("animation_finished", self, "hide")

func play(size, collected):
	show()
	
	
	#anim2.frame = 0
	#anim2.play()
	
	if collected:
#		if size == "big":
#			$NoteSprite.frame = 3
#			anim.scale = Vector2(0.8, 0.8)
#		else:
#			$NoteSprite.frame = 1
#			anim.scale = Vector2(0.6, 0.6)
			
		anim.frame = 0
		anim.play()
		
		#$AnimationPlayer.play("label_bounce")
	
