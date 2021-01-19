extends CanvasLayer


var scorelabel
var timerlabel
var message
var messagetimer
var restartButton


# Called when the node enters the scene tree for the first time.
func _ready():
	scorelabel = get_node("ScoreLabel")
	timerlabel = get_node("TimerLabel")
	message = get_node("Message")
	messagetimer = get_node("MessageTimer")
	restartButton = get_node("RestartButton")

	messagetimer.connect("timeout", self, "on_message_timer_timeout")
	restartButton.connect("pressed", self, "_on_restart_button_pressed")

func update_score(score):
	scorelabel.show()
	scorelabel.text = "Score: " + str(score)

func update_timer(time : float):
	timerlabel.show()
	timerlabel.text = "Seconds Left: " + str(time)

func show_message( text : String , time : float):
	message.show()
	message.text = text
	messagetimer.start(time)

func show_game_over(text : String):
	message.show()
	message.text = text
	restartButton.show()


func on_message_timer_timeout():
	message.hide()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
