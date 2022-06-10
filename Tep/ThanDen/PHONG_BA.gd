extends Area2D
var diChuyen = Vector2()
var tocDo = 200
var huongBan = 1  #1 la ban ve ben phai, -1 la ben trai

func _ready():
	pass 

func thayDoiHuongBan(phuongHuong):
	huongBan *= phuongHuong

func _physics_process(delta):
	diChuyen.x = tocDo * delta * huongBan
	translate(diChuyen)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_PHONG_BA_body_entered(body):
	if not("KeThu" in body.name):
		queue_free()
	if body.name == "Player":
		body.biThuong("ThanDen")

