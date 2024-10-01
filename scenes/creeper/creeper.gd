extends CharacterBody3D

@export var speed := 5

func _physics_process(delta: float) -> void:
	follow_player()
	
func follow_player():
	print("CREEPER: Pronásleduju hráče...")
