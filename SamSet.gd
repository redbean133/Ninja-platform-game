extends Node2D

onready var hinhAnh = [
	preload("res://DoHoa/MotSoThuKhac/SamSet/1.png"),
	preload("res://DoHoa/MotSoThuKhac/SamSet/2.png"),
	preload("res://DoHoa/MotSoThuKhac/SamSet/3.png")
]

func _ready():
	pass
	
func _sam_Set():
	$Sprite.texture = hinhAnh[randi() % 3]
	position.x = rand_range(9500, 11500)
	$AnimationPlayer.play("SamSet")
	$Timer.wait_time = rand_range(5, 12)
	$Timer.start()

func _on_Timer_timeout():
	_sam_Set()
	$Set.play()
	$DungSamSet.start()

func _on_Player_samChop():
	$Mua.play()
	$Timer.wait_time = rand_range(5, 12)
	$Timer.start()

func _on_DungSamSet_timeout():
	$Set.stop()


func _on_Boss_playerWin():
	$Mua.stop()
	$Set.stop()
	$Timer.stop()
	hide()
