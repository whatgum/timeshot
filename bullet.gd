extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var toVector := Vector2(1,0)
var fromVector := Vector2(1,0)
var rewinding := false
var howManyRewindFrames := 2
var posArray := []
var ghostTrailArray := []
var ghostTrail = load("res://ghostTrail.tscn")
var frameCount = 0

func moveTo(position : Vector2, delta : float, speed : float) -> void:
	self.translate(position *(delta * speed))


func _ready():
	for i in 120:
		var ghost : Sprite = ghostTrail.instance()
		get_parent().call_deferred("add_child", ghost)
		ghost.texture = self.get_child(1).texture
		ghost.modulate.a = 0
		ghostTrailArray.append(ghost)

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _input(event : InputEvent):
	if(event is InputEventMouseButton && event.button_index == BUTTON_LEFT):
		rewinding = false
	if(event is InputEventMouseButton && event.button_index == BUTTON_RIGHT):
		rewinding = true


func record():
	var currentOrigin := self.transform.origin
	for i in howManyRewindFrames:
		posArray.push_front(currentOrigin)


func rewind():
	if(posArray.size() != 0):
		self.transform.origin = posArray.pop_front()
		frameCount = frameCount + 1;
		if(frameCount == howManyRewindFrames):
			var ghost : Sprite = ghostTrailArray.pop_front()
			ghost.startFade(self.global_position)
			ghostTrailArray.push_back(ghost)
			frameCount = 0
	if(posArray.size() == 0):
		#self.queue_free()
		pass

func _physics_process(delta):
	if(!rewinding):
		moveTo(toVector, delta, 100)
		record()
	else:
		rewind()
