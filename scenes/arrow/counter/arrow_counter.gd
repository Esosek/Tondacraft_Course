class_name Arrows
extends Control

@export var arrows = 0

@onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(arrows)
