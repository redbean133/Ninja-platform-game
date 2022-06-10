extends TextureProgress


func _ready():
	pass 
	
func _process(delta):
	value = get_tree().root.get_node("MyGame").get_node("Player").mana
	$Sprite2/Label.text = String(value)
	
	


