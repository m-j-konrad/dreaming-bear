class_name Player
extends CharacterBody2D

const ANIM_IDLE = "idle"
const ANIM_RUN = "run"
const ANIM_JUMP = "jump"
const ANIM_FALL = "fall"
const ANIM_SIT = "sit"
const ANIM_USE = "yes"
const ANIM_SHOOT = "shoot"
const ANIM_TALK = "yes"
const ANIM_YAWNING = "idle_yawning"

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var max_health: int = 100
@export var max_idle_time: int = 5


@onready var state_machine = $StateMachine as StateMachine
@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var speech = $Label as Label
@onready var idle_timer = $IdleTimer as Timer


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health: int = max_health
# frames counting on falling
var fall_frames: int = 0
# number of falling frames until animate falling
var frames_to_fall: int = 75
# frames counting on jumping
var jump_frames: int = 0
# max frames jumping
var max_jump_frames: int = 100


func _ready():
	anim.current_animation = "fall"
	fall_frames = frames_to_fall
	idle_timer.timeout.connect(bear_is_tired)

func _physics_process(delta):
	move(delta)


func move(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		# set player velocity to speed
		velocity.x = direction * speed
		scale.x = scale.y * direction
	else:
		# decrease player velocity
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()


func bear_is_tired():
	idle_timer.stop()
	anim.play(ANIM_YAWNING)
	await anim.animation_finished
	state_machine.transition_to("Sit")
