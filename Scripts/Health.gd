extends StaticBody

signal on_destoryed(points)

var health = 10
var destoyed = false

export var max_health = 10

func _ready():
	health = max_health
	for node in get_tree().get_nodes_in_group("game"):
		connect("on_destoryed", node, "add_score")

func damage(amount : int):
	health -= amount
	if health <= 0 and not destoyed:
		destoyed = true
		emit_signal("on_destoryed", 5)
		queue_free()
