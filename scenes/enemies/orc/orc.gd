extends RigidBody2D

@export var is_idle: bool = true
@export_enum("left", "right") var facing: int

@onready var animatedSprite := $AnimatedSprite2D
@onready var myHits := $MyHits

var speed: int = 100
var direction: Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 10
	lock_rotation = true
	
	if facing == 0:
		animatedSprite.flip_h = true
		direction.x *= -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_idle:
		animatedSprite.play("run")
		animatedSprite.flip_h = not direction.x > 0
		var movement = direction * speed * delta
		var collision = move_and_collide(movement)
		
		# If angle is between 70 and 110 degrees
		if collision != null and collision.get_angle() > 1.222 and collision.get_angle() < 1.92:
			direction.x *= -1
			
func on_hit(_body: Node, damage: int):
	print(damage)
