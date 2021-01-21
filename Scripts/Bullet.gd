extends Spatial

var bullet_speed : int = 100
var bodies_to_exclude = []
var bullet_last_pos = Vector3.ZERO

func _ready():
	bullet_last_pos = global_transform.origin

func _physics_process(delta):
	translate(Vector3(0,-0.01,-1 * bullet_speed) * delta)
	_check_hit(bullet_last_pos)
	bullet_last_pos = global_transform.origin

func _check_hit(last_pos : Vector3):
	var space_state = get_world().get_direct_space_state()
	var our_pos = global_transform.origin
	var result = space_state.intersect_ray(last_pos, our_pos, bodies_to_exclude,
		 2, true, true)
	if result and result.collider.is_in_group("Box"):
		if result.collider.has_method("damage"):
			result.collider.damage(5)
			queue_free()

func _on_Timer_timeout():
	queue_free()
