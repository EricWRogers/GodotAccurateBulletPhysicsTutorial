extends KinematicBody

signal fire_bullet

var ready_to_shoot : bool = true

var speed = 7
var acceleration = 20
var gravity = 9.8
var can_move = true
#var jump  = 5

export var mouse_sensitivity : float = 0.05

var dir : Vector3 = Vector3()
var vel : Vector3 = Vector3()
var fall : Vector3 = Vector3()

onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	for node in get_tree().get_nodes_in_group("game"):
		connect("fire_bullet", node, "_fire_bullet")

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-45), deg2rad(45))

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if can_move:	
		if Input.is_action_pressed("fire"):
			if ready_to_shoot:
				$Head/handgun/FirePoint/CPUParticles.restart()
				ready_to_shoot = false
				$Head/handgun/GunTimer.start()
				var fire_point_transform = $Head/handgun/FirePoint.global_transform
				emit_signal("fire_bullet", fire_point_transform)
		
		dir = Vector3()
		
		if Input.is_action_pressed("move_forward"):
			dir -= transform.basis.z
		if Input.is_action_pressed("move_backward"):
			dir += transform.basis.z
		if Input.is_action_pressed("move_left"):
			dir -= transform.basis.x
		if Input.is_action_pressed("move_right"):
			dir += transform.basis.x
		
		dir = dir.normalized()
		vel = vel.linear_interpolate(dir * speed, acceleration * delta)
		vel = move_and_slide(vel, Vector3.UP)

func _on_GunTimer_timeout():
	ready_to_shoot = true
