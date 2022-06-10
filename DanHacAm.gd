extends Area2D

var diChuyen = Vector2.ZERO
var huongBan = Vector2.ZERO
var tocDo = 500

func _ready():
	pass 
	
func _physics_process(delta):
	diChuyen = tocDo * huongBan * delta
	translate(diChuyen)
	
func thietLapHuongBan(phuongHuong):
	huongBan = phuongHuong
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Dan_DaHacAm_body_entered(body):
	if body.name != "Boss" || !("KeThu" in body.name):
		queue_free()
	if body.name == "Player":
		body.biThuong("DanHacAm")
