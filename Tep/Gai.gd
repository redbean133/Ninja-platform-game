extends Area2D

var diChuyen = Vector2()
export(int) var tocDo = 150
var phuongHuong = true #1 la di xuong, -1 la di len

func _ready():
	$Len.add_exception(get_tree().root.get_node("MyGame").get_node("Player"))
	$Xuong.add_exception(get_tree().root.get_node("MyGame").get_node("Player"))

func _physics_process(delta):
	diChuyen.x = 0
	if phuongHuong == true:
		diChuyen.y = -tocDo
	else:
		diChuyen.y = tocDo
	if $Len.is_colliding() == true && phuongHuong == true:
		phuongHuong = false
	if $Xuong.is_colliding() == true && phuongHuong == false:
		phuongHuong = true
	#diChuyen = move_local_y(diChuyen.y)
	


func _on_Gai_body_entered(body):
	if "Player" in body.name:
		body.biThuong("Gai")
