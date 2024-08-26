class_name Enemy
extends Node

@export var health: int
@export var damage: int
@export var speed: float

func attack():
	print(name + " attacks")
