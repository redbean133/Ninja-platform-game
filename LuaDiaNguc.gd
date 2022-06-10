extends Area2D
var mucTieu = null
func _ready():
	pass

func _on_LuaDiaNguc_body_entered(body):
	if body.name == "Player":
		$Timer.start()
		mucTieu = body
		body.biThuong("LuaDiaNguc")

func _on_Timer_timeout():
	if mucTieu != null:
		mucTieu.biThuong("LuaDiaNguc")

func _on_LuaDiaNguc_body_exited(body):
	if body.name == "Player":
		$Timer.stop()
		mucTieu == null

