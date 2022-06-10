extends Area2D
const tocDo = 350
var diChuyen = Vector2()
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

func _on_DanLua_body_entered(body):
	queue_free()
	if "KeThu" in body.name:
		body.biThuong()
	if body.name == "Boss":
		body.biThuong("PhiTieu")
