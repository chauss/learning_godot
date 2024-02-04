extends RigidBody2D

const speed := 700
const lifetime := 3.0

var direction: Vector2 = Vector2.ZERO

@onready var timer := $Timer
@onready var impact_detector := $ImpactDetector

func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	
	impact_detector.connect("body_entered", _on_impact)
	timer.connect("timeout", queue_free)
	timer.start(lifetime)
	
	apply_impulse(direction * speed, position)


func _physics_process(_delta):
	look_at(global_position + get_linear_velocity())

	
func _on_impact(_body: Node) -> void:
	set_physics_process(false)
	sleeping = true
	
