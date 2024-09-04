class_name Creeper
extends Enemy

@export var stop_distance = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Godot volá každý frame. Používá se pro všechno kromě fyzikálního pohybu
# parametr delta je čas mezi framy a slouží pro konzistentní update.
func _process(delta):
	super(delta)
	if velocity != Vector3.ZERO:
		# Play walk animation
		pass
	else:
		# Play idle animation
		pass
	
# Godot volá každý frame. Používá se pro fyzikální pohyb
# Pronásledování hráče
func _physics_process(delta):
	var player_position = player.position
	var target_position = (player_position - position).normalized()
	target_position = Vector3(target_position.x, 0, target_position.z)
	
	if position.distance_to(player_position) > stop_distance:
		move_and_collide(target_position * speed * delta)
		look_at(Vector3(player_position.x, 0, player_position.z))
	else:
		super.attack()
