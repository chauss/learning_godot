extends CharacterBody2D
class_name Player

signal player_shot(pos)
signal player_fireball(pos, dir)
signal player_wants_to_enter

const SPEED: int = 200
const JUMP_VELOCITY: int = 300
var didJustAirJump: bool = false
var canShoot: bool = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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
	elif canShoot and Input.is_action_just_pressed("secondary") and GameMaster.arrow_amount > 0:
		canShoot = false
		shootTimer.start()
		var startPos = projectileStartRight
		if playerAnimation.flip_h:
			startPos = projectileStartLeft
		player_shot.emit(startPos.global_position)


func _physics_process(delta):
	velocity.y += gravity * delta
	
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
	
	if Input.is_action_just_pressed("enter"):
		player_wants_to_enter.emit()


func _on_shoot_timer_timeout():
	canShoot = true
