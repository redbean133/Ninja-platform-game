extends Node2D

func _ready():
	pass 
	
func _on_Player_lose():
	$AmThanh/NhacNen.stop()
	$KetThucGame/NenDenNhat.show()
	$KetThucGame/NenDenDam.show()
	$KetThucGame/YouLose.show()
	$KetThucGame/ThongBaoThua.show()
	$KetThucGame/Thua.start()
	
func _on_Thua_timeout():
	get_tree().change_scene("res://Tep/ManHinhBatDau.tscn")


func _on_NutQuayLai_pressed():
	get_tree().change_scene("res://Tep/ManHinhBatDau.tscn")


func _on_Boss_playerWin():
	$AmThanh/HappyJungle.play()
	$KetThucGame/NenTrangNhat.show()
	$KetThucGame/KhungWin.show()
	$KetThucGame/YouWin.show()
	$KetThucGame/ThongBaoThang.show()
	$KetThucGame/NutQuayLai.show()
