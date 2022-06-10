extends Area2D

func _ready():
	$AnimatedSprite.play("BinhThuong")

func _on_GaiAn_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite.play("Dam")
		body.biThuong("GaiAn")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dam":
		queue_free()
