extends Area2D
const tocDo = 350
var diChuyen = Vector2()
var huongBan = 1  #1 la ban ve ben phai, -1 la ben trai
var  X = 0
var Y = 0
var x = 0
var y = 0

func _ready():
	pass 

func thayDoiHuongBan(phuongHuong,a, b, c, d ):
	huongBan *= phuongHuong
	X = a
	Y = b
	x = c
	y = d

func _physics_process(delta):
	rotation = PI / 4
	$AnimatedSprite.play("phun")
	diChuyen.x =  40 * delta * huongBan
	diChuyen.y = (diChuyen.x + 2)
	if huongBan == -1:
		$AnimatedSprite.flip_h = true
		rotation = -PI/4
	else :
		$AnimatedSprite.flip_h = false
	translate(diChuyen)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_dan_lua_body_entered(body):
	if not("KeThu" in body.name):
		queue_free()
	if body.name == "Player":
		body.biThuong("BongMa")
