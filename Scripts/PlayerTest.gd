extends Spatial


export (PackedScene) var bullet = preload("res://Prefabs/Bullet.tscn")
onready var bullet_container = $BulletContainer




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _fire_bullet(fire_point_transform):
	var a = bullet.instance()
	a.global_transform = fire_point_transform
	bullet_container.add_child(a)
