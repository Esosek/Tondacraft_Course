class_name Player
extends CharacterBody3D

# celý číslo = int
# text = String (musí být uvozovky)
# desetinné číslo = float
# pravda / nepravda (true / false) = boolean

# násobení = *
# dělení = /

@export var speed = 5
@export var jump_velocity = 4.5
@export var mouse_sensitivity = 0.002
@onready var camera: Camera3D = $Camera3D

# Když zapnu hru, Godot zavolá tuhle funkci
func _init():
	print("PLAYER: Hra spuštěna!")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Když je hráč poprvé ve hře
func _ready():
	pass


func _physics_process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

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

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		
