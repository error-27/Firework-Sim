extends Position2D

var firework = preload("res://firework/Firework.tscn")
onready var timer = $Timer

export var minInterval: float
export var maxInterval: float
export var spread: float

func _ready():
	timer.start(rand_range(minInterval, maxInterval))


func _on_Timer_timeout():
	var newFirework = firework.instance()
	newFirework.rotate(deg2rad(rand_range(-spread, spread)))
	add_child(newFirework)
