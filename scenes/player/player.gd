extends CharacterBody2D
signal player_shot(pos)
signal player_fireball(pos, dir)

const SPEED: int = 300
const GRAVITY: int = 30
const JUMP_VELOCITY: int = 500
var didJustAirJump: bool = false
var canShoot: bool = true

@onready var playerAnimation := $PlayerAnimation
@onready var shootTimer := $ShootTimer
@onready var projectileStartLeft := $ProjectileStartLeft
@onready var projectileStartRight := $ProjectileStartRight

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if canShoot and Input.is_action_just_pressed("primary"):
		canShoot = false
		shootTimer.start()
		var startPos = projectileStartRight
		if playerAnimation.flip_h:
			startPos = projectileStartLeft
		var dir = Vector2.RIGHT
		if playerAnimation.flip_h:
			dir = Vector2.LEFT
		player_fireball.emit(startPos.global_position, dir)
	elif canShoot and Input.is_action_just_pressed("secondary"):
		canShoot = false
		shootTimer.start()
		var startPos = projectileStartRight
		if playerAnimation.flip_h:
			startPos = projectileStartLeft
		player_shot.emit(startPos.global_position)


func _physics_process(_delta):
	velocity.y += GRAVITY
	
	# Jumping
	if is_on_floor():
		didJustAirJump = false
		if Input.is_action_just_pressed("jump"):
			velocity.y = -JUMP_VELOCITY
	elif Input.is_action_just_pressed("jump") and not didJustAirJump:
		didJustAirJump = true 
		velocity.y = -JUMP_VELOCITY

	# Walking
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		playerAnimation.play("run")
		playerAnimation.flip_h = true
	elif Input.is_action_pressed("right"):
		playerAnimation.flip_h = false
		velocity.x = SPEED
		playerAnimation.play("run")
	else:
		velocity.x = 0
		playerAnimation.play("idle")
	if not is_on_floor():
		playerAnimation.play("idle")

	# "move_and_slide" already takes delta time into account.
	move_and_slide()
	


func _on_shoot_timer_timeout():
	canShoot = true