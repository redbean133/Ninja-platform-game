extends KinematicBody2D

var trongLuc = 10
export(int) var tocDo = 100
export(int) var mau = 7
var nenNha = Vector2(0, -1)
var diChuyen = Vector2()
var phuongHuong = -1 #-1 la di ve ben trai, 1 la ben phai
var daChet = false
var biThuong = false
const la = preload("res://Tep/VatPhamRoi.tscn")

func _ready():
	$HP_RongLua.hide()
	$HP_RongLua.max_value = mau
	$HP_RongLua.value = mau

func biThuong():
	$HP_RongLua.show()
	biThuong = true
	diChuyen.x = 0
	mau = mau - 1
	$HP_RongLua.value = mau
	if mau <= 0:
		chet()
	else:
		$AnimatedSprite.play("BiThuong")

func chet():
	daChet = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Rong/CollisionShape2D.set_deferred("disabled", true)
	diChuyen = Vector2(0, 0)
	$AnimatedSprite.play("Chet")
	$HP_RongLua.hide()
	var addLa = la.instance()
	addLa.global_position = global_position
	get_parent().add_child(addLa)

func _physics_process(delta):
	if biThuong == false && daChet == false:
		diChuyen.y += trongLuc
		diChuyen.x = tocDo * phuongHuong
		diChuyen = move_and_slide(diChuyen, nenNha)
		$AnimatedSprite.play("Chay")
		if is_on_wall():
			phuongHuong = phuongHuong * -1
			$RayCast2D.position.x *= -1
		if phuongHuong == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		if $RayCast2D.is_colliding() == false:
			phuongHuong = phuongHuong * -1
			$RayCast2D.position.x *= -1

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Chet":
		$AnimatedSprite.play("BienMat")
	if $AnimatedSprite.animation == "BiThuong":
		biThuong = false
		$AnimatedSprite.play("Chay")
	if $AnimatedSprite.animation == "TanCong":
		$AnimatedSprite.play("Chay")

func _on_Rong_body_entered(body):
	if "Player" in body.name:
		body.biThuong("Rong")

