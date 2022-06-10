extends KinematicBody2D

var trongLuc = 10
export(int) var tocDo = 50
export(int) var mau = 3
var nenNha = Vector2(0, -1)
var diChuyen = Vector2()
var phuongHuong = -1 #-1 la di ve ben trai, 1 la ben phai
var daChet = false
var biThuong = false
var m = 0
var lua = preload("res://Tep/BongMaBay/DanSamSet.tscn")
var dia_chi = Vector2()
var X = 0
var Y = 0
var ban = true
var mucTieu = null
var nhinmucTieu = null
const la = preload("res://Tep/VatPhamRoi.tscn")


func _ready():
	$Hp_bongma.max_value = mau
	$Timer.start()
	$Hp_bongma.hide()

func chet():
	daChet = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$tam_nhin/CollisionShape2D.set_deferred("disabled", true)
	$ThanThe/CollisionShape2D.set_deferred("disabled", true)
	diChuyen = Vector2(0, 0)
	hide()
	var addLa = la.instance()
	addLa.global_position = global_position
	get_parent().add_child(addLa)
		

func biThuong():
	$Hp_bongma.show()
	mau = mau - 1
	$Hp_bongma.value = mau
	if mau <= 0:
		chet()

func _physics_process(delta):
	diChuyen.y = 0
	if daChet == false:
		dia_chi = global_position + Vector2 ( 100, 100)
		var X = dia_chi.x - position.x
		var Y = dia_chi.y - position.y
		diChuyen.x = tocDo * phuongHuong
		diChuyen.y = 0
		m = m+1
		$AnimatedSprite.play("bay")
		diChuyen.y += 0
		diChuyen = move_and_slide(diChuyen, nenNha)
		if  m >= 300:
			m = 0
			phuongHuong  = phuongHuong * -1
		if phuongHuong == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		if mucTieu && ban:
			var bann = (mucTieu.global_position - self.global_position).normalized()
			if bann:
				$Timer.wait_time = 3
				ban = false
				var l = lua.instance()
				var k = lua.instance()
				if phuongHuong == 1:
					l.thayDoiHuongBan(1, X, Y , position.x , position.y)
					k.thayDoiHuongBan(1, X , Y , position.x , position.y)
				else:
					l.thayDoiHuongBan(-1, X , Y , position.x , position.y)
					k.thayDoiHuongBan(-1, X , Y , position.x , position.y)
				get_parent().add_child(l)
				get_parent().add_child(k)
				l.position = $AnimatedSprite/Position2D.global_position 
				k.position = $AnimatedSprite/Position2D2.global_position
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

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		mucTieu = body
		tocDo = 75

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		mucTieu = null
		tocDo = 50

func _on_tam_nhin_body_entered(body):
	if body.name == "Player":
		nhinmucTieu = body

func _on_tam_nhin_body_exited(body):
	if body.name == "Player":
		nhinmucTieu = null

func _on_ThanThe_body_entered(body):
	if body.name == "Player":
		body.biThuong("ThanDen")
