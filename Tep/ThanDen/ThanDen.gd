extends KinematicBody2D

var trongLuc = 10
export(int) var tocDo = 50
export(int) var mau = 3
var nenNha = Vector2(0, -1)
var diChuyen = Vector2()
var phuongHuong = -1 #-1 la di ve ben trai, 1 la ben phai
var daChet = false
var biThuong = false
var khoangDichChuyen = 0
var dia_chi = Vector2()
var ban = true
var mucTieu = null
var nhinmucTieu = null
var gio = preload("res://Tep/ThanDen/PHONG_BA.tscn")
const la = preload("res://Tep/VatPhamRoi.tscn")

func _ready():
	$Hp_thanDen.max_value = mau
	$Hp_thanDen.value = mau
	$Hp_thanDen.hide()

func biThuong():
	$Hp_thanDen.show()
	mau = mau - 1
	$Hp_thanDen.value = mau
	if mau <= 0:
		chet()

func chet():
	daChet = true
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite/khoang_ban/CollisionShape2D.set_deferred("disabled", true)
	$tam_nhin/CollisionShape2D.set_deferred("disabled", true)
	$ThanDen/CollisionShape2D.set_deferred("disabled", true)
	diChuyen = Vector2(0, 0)
	$AnimatedSprite.play("chet")
	var addLa = la.instance()
	addLa.global_position = global_position
	get_parent().add_child(addLa)

func _physics_process(delta):
	if daChet == false:
		diChuyen.x = tocDo * phuongHuong
		diChuyen.y = 0
		khoangDichChuyen = khoangDichChuyen + 1
		$AnimatedSprite.play("bay")
		diChuyen = move_and_slide(diChuyen, nenNha)
		if  khoangDichChuyen >= 300:
			khoangDichChuyen = 0
			phuongHuong = phuongHuong * -1
		if phuongHuong == 1:
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		else:
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		if mucTieu && ban:
			var bann = (mucTieu.global_position - self.global_position).normalized()
			if bann:
				diChuyen =  Vector2(0, 0)
				$Timer.start()
				ban = false
				var danGio = gio.instance()
				if sign($Position2D.position.x) == 1:
					danGio.thayDoiHuongBan(1)
				else:
					danGio.thayDoiHuongBan(-1)
				get_parent().add_child(danGio)
				danGio.position = $Position2D.global_position

		if nhinmucTieu:
			var nhin = (nhinmucTieu.global_position - self.global_position).normalized()
			if nhin.x < -0.1:
				$AnimatedSprite.flip_h = false
				phuongHuong = -1
				tocDo = 75
			else:
				if nhin.x > 0.1:
					$AnimatedSprite.flip_h = true
					phuongHuong = 1
					tocDo = 75
				else:
					tocDo = 0

func _on_Timer_timeout():
	ban = true
	tocDo = 50

func _on_tam_nhin_body_entered(body):
	if body.name == "Player":
		nhinmucTieu = body

func _on_tam_nhin_body_exited(body):
	if body.name == "Player":
		nhinmucTieu = null

func _on_khoang_ban_body_entered(body):
	if body.name == "Player":
		mucTieu = body
		tocDo = 75

func _on_khoang_ban_body_exited(body):
	if body.name == "Player":
		mucTieu = null
		tocDo = 50

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "chet":
		hide()

func _on_ThanDen_body_entered(body):
	if body.name == "Player":
		body.biThuong("ThanDen")
