class_name Player
extends CharacterBody3D

#@export var speed = 5.0
#@export var speed: float = 5.0
@export var speed := 5.0
@export var jump_height := 4.5
@export var mouse_sensitivity := 0.002
@export var camera_clamp := 1.2

@onready var camera: Camera3D = $Camera3D

# Godot zavolá _init metodu pří spuštění hry
func _init() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
# Godot zavolá _ready metodu když je tato scéna načtená
func _ready() -> void:
	# print() metoda vypíše parametr do konzole
	pass
	
func take_damage(value: int):
	print("Player takes ", value, " damage")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_height

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -camera_clamp, camera_clamp)
