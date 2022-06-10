extends Area2D

var player = null

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_KeThuAI_body_entered(body):
	player = body


func _on_KeThuAI_body_exited(body):
	player = null
