extends StaticBody2D
onready var danHacAm = preload("res://Tep/DanHacAm.tscn")

func _ready():
	pass 
	
func _process(delta):
	$MuiTen.rotation_degrees += 90.0 * delta
	if $MuiTen/RayCast2D.is_colliding():
		if $MuiTen/RayCast2D.get_collider() != null:
			if $MuiTen/RayCast2D.get_collider().name == "Player": #Ham nay tra ve doi tuong giao nhau dau tien cua RayCast2D
				ban()

func ban():
	var dan = danHacAm.instance()
	add_child(dan)
	dan.global_position = global_position
	dan.global_rotation = $MuiTen.rotation_degrees + 90
	dan.thietLapHuongBan(($MuiTen/RayCast2D.get_collision_point() - position).normalized())

func themNgoaiLe(nut):  ##################
	$MuiTen/RayCast2D.add_exception(nut)
