extends Node2D

export var gravity: int = 200
export var speed: int = 450
export var minLife: float = 1.2
export var maxLife: float = 1.7

onready var timer = $Timer
onready var trail = $Trail

var velocityY = 0
const maxGrav = 600
var fadeOut = false

func _ready():
	timer.start(rand_range(minLife, maxLife))

func _process(delta):
	move_local_y(-speed * delta)
	velocityY += gravity
#	velocityY = min(velocityY, maxGrav)
	position.y += velocityY * delta

func _on_Timer_timeout():
	if fadeOut:
		call_deferred("queue_free")
	fadeOut = true
	trail.emitting = false
	timer.start(trail.lifetime)
	
