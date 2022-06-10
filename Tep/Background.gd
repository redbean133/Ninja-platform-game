extends ParallaxBackground

var width = 1990

func _ready():
	#width = $Layer1/Sprite.texture.get_width()
	pass

func _process(delta):
	$Layer1/Sprite.translate(Vector2(-30*delta, 0))
	$Layer1/Sprite2.translate(Vector2(-30*delta, 0))
	if $Layer1/Sprite.position.x <= -width:
		$Layer1/Sprite.position.x = width
	if $Layer1/Sprite2.position.x <= -width:
		$Layer1/Sprite2.position.x = width
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
