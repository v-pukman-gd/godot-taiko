extends Node2D

enum Size {NORMAL, BIG}
enum Type {RED, BLUE}

export(Size) var size = Size.NORMAL
export(Type) var type = Type.BLUE

export(float) var normal_scale = 0.8
export(float) var big_scale = 1.25

func _ready():
	set_sprite()
	
func set_sprite():
	match type:
		Type.RED: $Sprite.frame = 7
		Type.BLUE: $Sprite.frame = 1
		
	match size:
		Size.NORMAL: 
			$Sprite.scale = Vector2(normal_scale,normal_scale)
			$Sprite.position = Vector2(-45, -45)
		Size.BIG: 
			$Sprite.scale = Vector2(big_scale,big_scale)
			$Sprite.position = Vector2(-71, -71)

