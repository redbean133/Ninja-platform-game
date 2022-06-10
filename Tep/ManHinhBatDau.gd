extends CanvasLayer

func _ready():
	$Nen/NhacNen.play()

func _on_PlayGame_pressed():
	$Nen/NhacNen.stop()
	$Control.show()
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Tep/MyGame.tscn") 
	$AnimationPlayer.play_backwards("fade")

func _on_NutHuongDan_pressed():
	$Nut_X.show()
	$TacGia.hide()
	$HuongDan.show()

func _on_Nut_X_pressed():
	$Nut_X.hide()
	$HuongDan.hide()
	$TacGia.hide()

func _on_NutCaiDat_pressed():
	$Nut_X.show()
	$HuongDan.hide()
	$TacGia.show()
