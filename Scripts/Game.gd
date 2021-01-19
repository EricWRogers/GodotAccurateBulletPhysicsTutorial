extends Node

export (PackedScene) var bullet = preload("res://Prefabs/Bullet.tscn")
onready var bullet_container = $BulletContainer

var _startTimer
var _gameTimer
var _player
var _hud

var score : int = 0
export var max_game_time = 20
var game_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_nodes()
	_startTimer.connect("timeout", self, "_OnStartTimerTimeout")
	_gameTimer.connect("timeout", self, "_OnGameTimerTimeout")
	_player.can_move = false
	_hud.show_message("Hold Steady! Left Click To Shoot", 5)

func _load_nodes():
	_startTimer = get_node("StartTimer")
	_gameTimer = get_node("GameTimer")
	_player = get_node("Player")
	_hud = get_node("HUD")

func _OnStartTimerTimeout():
	_gameTimer.start()
	_player.can_move = true
	add_score(0)

func _OnGameTimerTimeout():
	game_time += 1
	if game_time >= max_game_time:
		_player.can_move = false
		_hud.update_timer(0)
		_hud.show_game_over("Great Job! Click Restart To Play Again")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		_gameTimer.start(1)
		_hud.update_timer(max_game_time - game_time)

func _fire_bullet(fire_point_transform):
	var a = bullet.instance()
	a.global_transform = fire_point_transform
	bullet_container.add_child(a)

func add_score( points : int ):
	score += points
	_hud.update_score(score)
