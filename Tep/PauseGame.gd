extends Control

func _ready():
	pass 
		
func _input(event):
	if event.is_action_pressed("p"):
		get_tree().paused = not get_tree().paused
		visible = not visible

func _on_ChoiTiep_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible

func _on_ThoatGame_pressed():
	get_tree().paused = not get_tree().paused
	$ColorRect2.show()
	$CanvasLayer/AnimationPlayer.play("fade")
	yield($CanvasLayer/AnimationPlayer, "animation_finished")
	get_tree().reload_current_scene()
	$CanvasLayer/AnimationPlayer.play_backwards("fade")

func _on_QuayLaiManHinh_pressed():
	get_tree().paused = not get_tree().paused
	$ColorRect2.show()
	$CanvasLayer/AnimationPlayer.play("fade")
	yield($CanvasLayer/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Tep/ManHinhBatDau.tscn")
	$CanvasLayer/AnimationPlayer.play_backwards("fade")
