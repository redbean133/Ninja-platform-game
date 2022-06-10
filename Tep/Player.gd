extends KinematicBody2D

var chuyenDong = Vector2()
var viTri = Vector2()
export(int) var tocDo = 30
var mau = 100
var mana = 100
var trongLuc = 10
var tocDoMax = 200
var trenMatDat = true
var nenNha = Vector2(0, -1)
var trangThaiChienDau = false
var tanCongBenPhai = true
var biThuong = false
var daChet = false
var ketThucGame = false
var soLuongLaDaNhat = 0
signal samChop
signal lose
const danLua = preload("res://Tep/DanLua.tscn")

func _ready():
	pass

func _physics_process(delta):
	if ketThucGame == false:
		if daChet == false:
			chuyenDong.y += trongLuc
			if is_on_floor():
				trenMatDat = true
			else:
				trenMatDat = false
			if Input.is_action_pressed("TanCong") && biThuong == false:
				trangThaiChienDau = true
			if trangThaiChienDau == true:
				chuyenDong.x = 0
				$AnimatedSprite.play("BienMat")
				$TanCong.play("TanCong")
				if tanCongBenPhai == true:
					$Kiem/KiemBenPhai.set_deferred("disabled", false)
				else:
					$Kiem/KiemBenTrai.set_deferred("disabled", false)
			else:
				$TanCong.play("BienMat")
				if Input.is_action_pressed("ui_right"):
					$AnimatedSprite.flip_h = false
					$TanCong.flip_h = false
					tanCongBenPhai = true
					if biThuong == false: 
						if trenMatDat == true:
							$AnimatedSprite.play("Chay")
						else:
							$AnimatedSprite.play("NhayLen")  
					if chuyenDong.x < tocDoMax:
						chuyenDong.x += tocDo
					if sign($ViTriBan.position.x) == -1:
						$ViTriBan.position.x *= -1
				elif Input.is_action_pressed("ui_left"):
					$TanCong.flip_h = true
					$AnimatedSprite.flip_h = true
					tanCongBenPhai = false
					if biThuong == false:  
						if trenMatDat == true:
							$AnimatedSprite.play("Chay")
						else:
							$AnimatedSprite.play("NhayLen") 
					if chuyenDong.x > -tocDoMax:
						chuyenDong.x -= tocDo
					if sign($ViTriBan.position.x) == 1:
						$ViTriBan.position.x *= -1
				else:
					chuyenDong.x = 0
				if Input.is_action_pressed("ui_up"):
					if trenMatDat == true: 
						$AnimatedSprite.play("NhayLen")
						$Nhay.play()
						chuyenDong.y = -15*tocDo
				if chuyenDong.x == 0 && chuyenDong.y > 0 && trenMatDat && biThuong == false && !Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):   #################################
					$AnimatedSprite.play("NhanRoi")
			if $AnimatedSprite.animation == "BienMat" && $TanCong.animation == "BienMat":
				$AnimatedSprite.play("BiThuong")
			if Input.is_action_just_pressed("ban") && mana >= 5:
				var danlua = danLua.instance()
				if sign($ViTriBan.position.x) == 1:
					danlua.thayDoiHuongBan(1)              #Thuc ra ham nay chi la cai dat huong ban ban dau cho vien dan, tuc ham nay chi dung 1 lan
				else:
					danlua.thayDoiHuongBan(-1)
				get_parent().add_child(danlua)
				danlua.position = $ViTriBan.global_position
				mana = mana - 5
			chuyenDong = move_and_slide(chuyenDong, nenNha)
			viTri = self.get_global_position()
			if viTri.y >= 800:
				mau = 0
			if mau <= 0:
				daChet = true
				chet()
		$Camera2D.align() 


func _on_TanCong_animation_finished():
	if $TanCong.animation == "TanCong":
		trangThaiChienDau = false
		$Kiem/KiemBenPhai.set_deferred("disabled", true)
		$Kiem/KiemBenTrai.set_deferred("disabled", true)
		if trenMatDat == true:
			$AnimatedSprite.play("NhanRoi")
		else:
			$AnimatedSprite.play("NhayLen")

func biThuong(tenKeThu):
	biThuong = true
	$Hurt.play()
	if tenKeThu == "Nhen":
		mau = mau - 5
	if tenKeThu == "Gai":
		mau = mau - 3
	if tenKeThu == "GaiAn":
		mau = mau - 10
	if tenKeThu == "ThanDen" or tenKeThu == "BongMa":
		mau = mau - 7
	if tenKeThu == "Rong":
		mau = mau - 10
	if tenKeThu == "LuaDiaNguc":
		mau = mau - 10
	if tenKeThu == "DanHacAm":
		mau = mau - 5
	if tenKeThu == "DanBossThuong":
		mau = mau - 15
	if tenKeThu == "DanBossUlti":
		mau = mau - 8
	if tenKeThu == "BossTanCongGan":
		mau = mau - 20
	$AnimatedSprite.play("BiThuong")

func _on_Kiem_body_entered(body):
	if "KeThu" in body.name:
		body.biThuong()
	if body.name == "Boss":
		body.biThuong("Kiem")

func chet():
	$AnimatedSprite.play("Chet")
	$Hurt.play()
	$Camera2D.current = false
	chuyenDong.x = 0
	chuyenDong.y = 0
	mana = 0
	$Ninja.disabled = true
	ketThucGame = true
	emit_signal("lose")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "BiThuong":
		if trenMatDat == true:
			$AnimatedSprite.play("NhanRoi")
		else:
			$AnimatedSprite.play("NhayLen")
		biThuong = false
	if $AnimatedSprite.animation == "Chet":
		$AnimatedSprite.play("NamChet")
	if $AnimatedSprite.animation == "NhayLen" && biThuong == true: ####################
		biThuong = false

func _on_ThoiGianHoiMana_timeout():
	if mau > 0 && mana < 100:
		mana = mana + 5
	if mana > 100:
		mana = 100

func _on_ThoiGianHoiMau_timeout():
	if mau > 0 && mau <100:
		mau = mau + 5
	if mau > 100:
		mau = 100

func _on_CongKhongGian_body_entered(body):
	if soLuongLaDaNhat == 15:
		var viTriMoi = Vector2(9949.453, 365.846)
		self.set_global_position(viTriMoi)
		emit_signal("samChop")

func soLuongLa():
	$NhatLa.play()
	soLuongLaDaNhat += 1
	if soLuongLaDaNhat == 15:
		get_tree().root.get_node("MyGame").get_node("CongKhongGian").get_node("MagicCircleRed").show()


func _on_HoiPhuc_body_entered(body):
	if body.name == "Player":
		$TGHoiNhanh.start()


func _on_HoiPhuc_body_exited(body):
	if body.name == "Player":
		$TGHoiNhanh.stop()


func _on_TGHoiNhanh_timeout():
	if mau > 0 && mau < 100:
		mau = mau + 10
	if mana < 100:
		mana = mana + 10
	if mau > 100:
		mau = 100
	if mana > 100:
		mana = 100


func _on_Boss_playerWin():
	ketThucGame = true
