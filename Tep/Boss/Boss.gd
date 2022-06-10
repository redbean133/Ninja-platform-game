extends KinematicBody2D

# Animation mac dinh la quay sang trai

signal playerWin
var mau = 100
var diChuyen = Vector2.ZERO
var tocDo = 100
var player = null
var denGanPlayer = false
var tanCongPlayer = false
var trieuHoi = true
var viTriDichChuyen = Vector2.ZERO
onready var danThuong = preload("res://Tep/Boss/DanThuong.tscn")
onready var danUlti = preload("res://Tep/Boss/DanUlti.tscn")
onready var vongXoayHacAm = preload("res://Tep/VongXoayHacAm.tscn")

func _ready():
	$TextureProgress.max_value = mau
	$TextureProgress.value = mau
	$TextureProgress.hide()
	$AnimatedSprite.play("NhanRoi")
	$BanThuong.start()
	$Ulti.start()

func _physics_process(delta):
	if player == null:
		$AnimatedSprite.play("NhanRoi")
	else:
		if denGanPlayer == true:
			var phuongHuongDiChuyen = (player.global_position - global_position).normalized()
			if phuongHuongDiChuyen.x > 0:
				$AnimatedSprite.flip_h = true
			else:
				$AnimatedSprite.flip_h = false
			diChuyen = phuongHuongDiChuyen * tocDo 
			if tanCongPlayer == false:
				diChuyen = move_and_slide(diChuyen)
	if mau <= 30 && trieuHoi == true && player != null:             
		trieuHoiVongXoayHacAm()
	if mau <= 0:
		chet()

func trieuHoiVongXoayHacAm():
	trieuHoi = false
	$AnimatedSprite.play("TrieuHoi")
	var vongXoay = vongXoayHacAm.instance()
	get_parent().add_child(vongXoay)
	vongXoay.themNgoaiLe(self)    
	var viTriVongXoay = Vector2.ZERO
	viTriVongXoay.x = (player.global_position.x + global_position.x) / 2
	viTriVongXoay.y = 180
	vongXoay.global_position = viTriVongXoay

func biThuong(tenKeThu):
	$TextureProgress.show()
	$AnimatedSprite.play("BiThuong")
	if tenKeThu == "PhiTieu":
		mau = mau - 3
	if tenKeThu == "Kiem":
		mau = mau - 5
	$TextureProgress.value = mau

func chet():
	tocDo = 0
	$Dead.play()
	$TextureProgress.hide()
	$VungTanCong/CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.play("KietSuc")
	yield($AnimatedSprite, "animation_finished")
	emit_signal("playerWin")
	get_parent().queue_free()  
	$BanThuong.stop()
	$Ulti.stop()
	$HoiMau.stop()
	$TanCongGan/CollisionShape2D.set_deferred("disabled", true)


func _on_VungDichChuyen_body_entered(body):
	if body.name == "Player":
		player = body
		denGanPlayer = true

func _on_VungDichChuyen_body_exited(body):
	if body.name == "Player":
		player = null
		denGanPlayer = false


func _on_VungTanCong_body_entered(body):
	if body.name == "Player":
		tanCongPlayer = true

func _on_VungTanCong_body_exited(body):
	if body.name == "Player":
		tanCongPlayer = false

func _on_BanThuong_timeout():
	if tanCongPlayer == true:
		$AnimatedSprite.play("HatDan")
		var dan = danThuong.instance()
		add_child(dan)
		dan.global_position = $ViTriBanThuong.global_position
		dan.thietLapHuongBan((player.position - $ViTriBanThuong.global_position).normalized())
		
func _on_Ulti_timeout():
	var soNgauNhien = randi() % 4
	if soNgauNhien != 0:
		if tanCongPlayer == true:
			$AnimatedSprite.play("RaLenh")
			var dan1 = danUlti.instance()
			var dan2 = danUlti.instance()
			var dan3 = danUlti.instance()
			var dan4 = danUlti.instance()
			add_child(dan1)
			add_child(dan2)
			add_child(dan3)
			add_child(dan4)
			$BanUlti.play()
			dan1.global_position = $DanUlti1.global_position
			dan1.thietLapHuongBan((player.position - $DanUlti1.global_position).normalized())
			dan2.global_position = $DanUlti2.global_position
			dan2.thietLapHuongBan((player.position - $DanUlti2.global_position).normalized())
			dan3.global_position = $DanUlti3.global_position
			dan3.thietLapHuongBan((player.position - $DanUlti3.global_position).normalized())
			dan4.global_position = $DanUlti4.global_position
			dan4.thietLapHuongBan((player.position - $DanUlti4.global_position).normalized())
	else:
		if denGanPlayer == true:
			if $AnimatedSprite.flip_h == true: #dang quay sang trai
				viTriDichChuyen.x = player.global_position.x 
			else:
				viTriDichChuyen.x = player.global_position.x 
			viTriDichChuyen.y = player.global_position.y - 110
			self.set_global_position(viTriDichChuyen)
			$AnimatedSprite.play("TanCongGan")
			$TanCongGan/CollisionShape2D.set_deferred("disabled", false)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "HatDan":
		$AnimatedSprite.play("NhanRoi")
	if $AnimatedSprite.animation == "RaLenh":
		$AnimatedSprite.play("NhanRoi")
	if $AnimatedSprite.animation == "BiThuong":
		$AnimatedSprite.play("NhanRoi")
	if $AnimatedSprite.animation == "TanCongGan":
		$TanCongGan/CollisionShape2D.set_deferred("disabled", true)
		$AnimatedSprite.play("NhanRoi")

func _on_HoiMau_timeout():
	if mau > 0 && mau < 100:
		mau = mau + 5
	if mau > 100:
		mau = 100
	$TextureProgress.value = mau

func _on_TanCongGan_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite.play("TanCongGan")
		body.biThuong("BossTanCongGan")
