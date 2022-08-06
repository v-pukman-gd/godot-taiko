extends Node2D

onready var anim = $AnimationPlayer
onready var note_sprite = $NoteSprite

func _ready():
	hide()
	anim.connect("animation_finished", self, "stop")
	
func stop(name):
	anim.stop()
	hide()

func play(size, collected):
	anim.stop()
	show()
	
	if collected:
		if size == "big":
			$NoteSprite.frame = 3
		else:
			$NoteSprite.frame = 1
			
		anim.play()
