class_name Player
extends CharacterBody3D

signal health_updated

@export var speed = 5.0
@export var jump_velocity = 4.5
@export var mouse_sensitivity = 0.002
@export var camera_clamp = 1.2
@export var health = 1
@export var max_health = 5

@onready var camera = $Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Volá se při spuštění hry
func _init():
	# Zneviditelní myš a zamkne jí na střed obrazovky
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Volá se při načtení nodu do hry
func _ready():
	set_initial_health()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _unhandled_input(event):
	# Pohled myší
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -camera_clamp, camera_clamp)
		
func set_initial_health():
	health = max_health
	health_updated.emit(health)
	
func take_damage(value: int):
	print("Player takes ", value, " damage")
	health -= value
	if health <= 0:
		health = 0
		die()
	
func die():
	print("Player died")
