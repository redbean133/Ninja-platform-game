extends KinematicBody2D

var trongLuc = 10
export(int) var tocDo = 50
export(int) var tocDoTanCong = 150
export(int) var mau = 3
var nenNha = Vector2(0, -1)
var diChuyen = Vector2()
var phuongHuong = -1 #-1 la di ve ben trai, 1 la ben phai
var phuongHuong2 = Vector2()
var daChet = false
var biThuong = false
var mucTieu = null
var player = null
const la = preload("res://Tep/VatPhamRoi.tscn")

func _ready():
	$HP_Nhen.max_value = mau
	$HP_Nhen.value = mau
	
func biThuong():
	$HP_Nhen.show()
	biThuong = true
	diChuyen.x = 0
	mau = mau - 1
	$HP_Nhen.value = mau
	if mau <= 0:
		chet()
	else:
		$AnimatedSprite.play("BiThuong")

func chet():
	daChet = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Nhen/CollisionShape2D.set_deferred("disabled", true)
	diChuyen = Vector2(0, 0)
	$AnimatedSprite.play("Chet")

func _physics_process(delta):
	if biThuong == false && daChet == false:
		if mucTieu == null:
			diChuyen.y += trongLuc
			diChuyen.x = tocDo * phuongHuong
			diChuyen = move_and_slide(diChuyen, nenNha)
			$AnimatedSprite.play("Chay")
			if is_on_wall():
				phuongHuong = phuongHuong * -1     #Neu no va vao tuong thi quay lai va RayCast2D cung quay lai
				$RayCast2D.position.x *= -1
			if phuongHuong == 1:
				$AnimatedSprite.flip_h = true
			else:
				$AnimatedSprite.flip_h = false
			if $RayCast2D.is_colliding() == false:  #is_colliding() dung khi co mot doi tuong bat ki giao voi vector RayCast2D
				phuongHuong = phuongHuong * -1      #vay nen binh thuong dieu kien la dung vi vector giao voi mat san
				$RayCast2D.position.x *= -1         #con khi con nhen sap bi roi thi thanh sai vi vector o ngoai khong trung, khong co bat cu thu gi giao voi vector
		else:
			if mucTieu != null:
				phuongHuong2 = (mucTieu.global_position - self.global_position).normalized()  #Vector don vi co huong tu con nhen den nguoi choi
				phuongHuong2.y = 0
				if phuongHuong2.x < 0:          #Vector chi sang ben trai nen con nhen khong quay lai vi animation mac dinh cua no la quay sang trai
					$AnimatedSprite.flip_h = false
				else:
					$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("TanCong")
				move_and_collide(phuongHuong2*tocDoTanCong*delta) #ham move_and_collide 

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Chet":
		$HP_Nhen.hide()
		$AnimatedSprite.play("BienMat")
		var addLa = la.instance()
		addLa.global_position = global_position
		get_parent().add_child(addLa)
	if $AnimatedSprite.animation == "BiThuong":
		biThuong = false
		$AnimatedSprite.play("Chay")
	if $AnimatedSprite.animation == "TanCong":
		$AnimatedSprite.play("Chay")

func _on_Nhen_body_entered(body):
	if "Player" in body.name:
		body.biThuong("Nhen")
		$Timer.start()
		player = body

func _on_Rada_body_entered(body):
	if "Player" in body.name:
		mucTieu = body

func _on_Rada_body_exited(body):
	if "Player" in body.name:
		mucTieu = null

func _on_Timer_timeout():
	if player != null:
		player.biThuong("Nhen")

func _on_Nhen_body_exited(body):
	if body.name == "Player":
		player = null
		$Timer.stop()
