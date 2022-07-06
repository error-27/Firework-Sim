extends Node2D

const trails = [preload("res://firework/materials/trails/Trail1.tres"), 
				preload("res://firework/materials/trails/Trail2.tres"), 
				preload("res://firework/materials/trails/TrailWide.tres")]

const explosions = [preload("res://firework/materials/explosions/CircleExplosionRed.tres"), 
					preload("res://firework/materials/explosions/CircleExplosionPatriot.tres"),
					preload("res://firework/materials/explosions/CircleExplosionGold.tres"),
					preload("res://firework/materials/explosions/GoldTrailExplosion.tres"),
					preload("res://firework/materials/explosions/BlueTrailExplosion.tres")]

var offshootScene = preload("res://firework/Offshoot.tscn")

onready var trailEmitter = $Trail
onready var explosionEmitter = $Explosion
onready var timer = $ExplodeTimer
onready var explodeSound = $AudioStreamPlayer2D

export var minTime: float
export var maxTime: float
export var speed: float = 200

var exploded: bool = false
var isOffshooting: bool = false

var offshootRes
var offshootAmount = 0
var offshootSpread = 0

func _ready():
	trailEmitter.process_material = trails[randi() % trails.size()]
	var explodeRes: ExplosionResource = explosions[randi() % explosions.size()]
	if explodeRes.explosion != null: 
		explosionEmitter.process_material = explodeRes.explosion
	else:
		explosionEmitter.hide()
	
	if explodeRes.offshoot != null:
		isOffshooting = true
		offshootRes = explodeRes.offshoot
		offshootAmount = explodeRes.offshootAmount
		offshootSpread = explodeRes.offshootSpread
	
	timer.start(rand_range(minTime, maxTime))

func _process(delta):
	move_local_y(-speed * delta)

func _on_Timer_timeout():
	if not exploded:
		trailEmitter.emitting = false
		explosionEmitter.emitting = true
		explodeSound.play()
		exploded = true
		speed = 0
		if isOffshooting:
			for i in offshootAmount:
				var offshootInstance = offshootScene.instance()
				offshootInstance.get_node("Trail").process_material = offshootRes
				offshootInstance.rotate(deg2rad(rand_range(-offshootSpread, offshootSpread)))
				offshootInstance.position = position
				get_parent().add_child(offshootInstance)
		timer.start(explosionEmitter.lifetime)
	else:
		call_deferred("queue_free")
