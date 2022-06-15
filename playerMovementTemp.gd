extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event : InputEvent):
	if(event is InputEventMouseButton && event.button_index == BUTTON_LEFT):
			self.position.y += 10


func _on_Area2D_area_entered(area):
	queue_free()
