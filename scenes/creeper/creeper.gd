extends CharacterBody3D

@export var speed := 5
@export var damage := 1
@export var player: Player 
@export var time_between_attacks := 1.5

@onready var animation_player: AnimationPlayer = $Creeper/AnimationPlayer

var next_attack := 0.0

func _ready() -> void:
	if not player:
		printerr("CREEPER: Missing player reference")


func _process(delta: float) -> void:
	if velocity != Vector3.ZERO and !animation_player.is_playing():
		animation_player.play("Creeper_Walk_20")
		
	if next_attack > 0:
		#next_attack = next_attack - delta
		next_attack -= delta # zkratka


func _physics_process(delta: float) -> void:
	if global_position.distance_to(player.global_position) > 1.2:
		follow_player(delta)
	else:
		velocity = Vector3.ZERO
		attack()


func follow_player(delta: float):
	if not player:
		return
		
	var direction = (player.global_position - global_position).normalized()
	var target_position = Vector3(direction.x, 0, direction.z)
	velocity = target_position * speed * delta * 10
	move_and_slide()
	look_at(Vector3(player.position.x, 0, player.position.z))


func attack():
	if next_attack <= 0: 
		next_attack = time_between_attacks
		#Přidat animaci útoku
