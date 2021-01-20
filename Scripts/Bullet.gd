extends Area

var bullet_speed : int = 20

func _physics_process(delta):
	translate(Vector3(0,-0.01,-1) * bullet_speed * delta)

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("Box"):
		body.damage(5)
	
	queue_free()
