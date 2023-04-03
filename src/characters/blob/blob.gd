extends CharacterBody2D


@export var speed: float = 250.0
@export var jump_velocity: Vector2 = Vector2(800, -100.0)
@export var color: Color = Color.GREEN_YELLOW

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var abyss_collider = $RayCastAbyssCollider as RayCast2D


func _ready():
	modulate = color


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		anim.current_animation = "slide"
		if abyss_collider.get_collider() == null:
			scale.x = scale.x * -1
			speed = -speed
		
		velocity.x = speed * delta
	
	move_and_slide()


func jump():
	anim.current_animation = "jump"
	velocity.y = jump_velocity.y


