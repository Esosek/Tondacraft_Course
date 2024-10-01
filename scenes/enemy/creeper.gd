class_name Creeper
extends CharacterBody3D

@export var speed = 3
@export var player: CharacterBody3D

func _ready() -> void:
	if !player:
		printerr("Creeper is missing Player reference")

func follow_player():
	print("Following player...")
