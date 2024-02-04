extends Node2D

const speed := 700
const lifetime := 4.0

var direction: Vector2 = Vector2.ZERO

@onready var timer := $Timer
@onready var impact_detector := $ImpactDetector
@onready var explosion_animation := $ExplosionAnimation

func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	
	impact_detector.connect("body_entered", _on_impact)
	timer.connect("timeout", queue_free)
	timer.start(lifetime)


func _process(delta):
	if not impact_detector.has_overlapping_bodies():
		position += delta * speed * direction
	
	
func _on_impact(_body: Node) -> void:
	timer.start(1.5)
	explosion_animation.play("explosion")
