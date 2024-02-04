extends Node2D

const speed := 600
const lifetime := 4.0
const damage := 20

var direction: Vector2 = Vector2.ZERO
var didImpact: bool = false

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
	if not impact_detector.has_overlapping_bodies() and not didImpact:
		position += delta * speed * direction
	
	
func _on_impact(body: Node) -> void:
	didImpact = true
	timer.start(1.5)
	explosion_animation.play("explosion")
	if body.has_method("on_hit"):
		body.on_hit(self, damage);
