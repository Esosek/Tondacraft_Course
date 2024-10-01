class_name Creeper
extends CharacterBody3D

@export var speed := 3
@export var stop_distance := 1.2
@export var damage := 1

@export var player: CharacterBody3D

@onready var animation_player: AnimationPlayer = $Creeper/AnimationPlayer

# Godot funkce si volá Godot a začínají podtržítkem
func _ready() -> void:
	if !player:
		printerr("Creeper is missing Player reference")


func _process(delta: float) -> void:
	# Takhle zkontroluješ jestli se tento objekt hýbe
	if velocity != Vector3.ZERO:
		animation_player.play("Creeper_Walk_20")


func _physics_process(delta: float) -> void:
	# Měří vzdálenost mezi creeperem a hráčem
	if position.distance_to(player.position) > stop_distance:
		follow_player(delta)
	else:
		velocity = Vector3.ZERO
		attack()
		


# Vlastní funkce musíš volat sám
func follow_player(delta: float):
	# Každý frame pohne crepeera směrem k hráči
	var direction = (player.position - position).normalized()
	var target_position = Vector3(direction.x, 0, direction.z)
	velocity = target_position * speed * delta * 10
	move_and_slide()
	look_at(Vector3(player.position.x, 0, player.position.z))


func attack():
	animation_player.play("Creeper_Attack_11")
	print("Damaging player for ", damage , " damage")
