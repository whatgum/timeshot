extends PathFollow2D

signal animationPlayer(animation, speed)
signal rewindAnimation
signal reforwardAnimation
signal stop
signal setPlaybackSpeed(speed)
signal play(rewinding)
signal switchPaths
signal FinishedTransit

var rewinding : bool = false

var currentPathIndex = 0
var pathNames = ["line_right_side", "Node2D connection to circle", "circle"]

var ghostTrailArray := []
var ghostTrail = load("res://ghostShipTrial.tscn")
var frameCount = 0
var howManyRewindFrames := 2
var signalTransition := false
var pathOn : String


func initialize_enemy(animation : Animation, speed : float) -> void:
	emit_signal("animationPlayer", animation, speed, 0)
	var interval : float = .00083
	for i in 120:
		var ghost : PathFollow2D = ghostTrail.instance()
		ghost.initialize_ghost(animation, speed,interval, i + 1)
		interval= interval + .00083
		get_parent().call_deferred("add_child", ghost)
		ghost.get_child(0).texture = self.get_child(0).texture
		connect("reforwardAnimation", ghost, "reforward")
		connect("rewindAnimation", ghost, "rewind")
		ghost.modulate.a = 0
		ghostTrailArray.append(ghost)
	get_child(2).play("event", speed)


func rewind():
	frameCount = frameCount + 1;
	if(frameCount == howManyRewindFrames):
		var ghost : PathFollow2D = ghostTrailArray.pop_back()
		ghost.startFade(.00083, self.get_child(1).current_animation_position)
		ghostTrailArray.push_front(ghost)
		frameCount = 0


func _physics_process(delta):
	if(rewinding):
		rewind()


func _input(event : InputEvent):
	if(event is InputEventMouseButton && event.button_index == BUTTON_LEFT && rewinding == true):
		rewinding = false
		emit_signal("reforwardAnimation")
	if(event is InputEventMouseButton && event.button_index == BUTTON_RIGHT && rewinding == false):
		rewinding = true
		emit_signal("rewindAnimation")


func switch_paths():
	if(rewinding):
		currentPathIndex = currentPathIndex - 1
	else:
		currentPathIndex = currentPathIndex + 1
	if(currentPathIndex < 0):
		return;
	if(currentPathIndex > pathNames.size()):
		return;
	var globalPos = self.global_position
	get_parent().remove_child(self)
	emit_signal("stop")
	emit_signal("switchPaths", self, globalPos, pathNames[currentPathIndex], rewinding)


func set_speed(speed : float):
	emit_signal("setPlaybackSpeed", speed)

func play_movement(rewinding : bool):
	emit_signal("play", rewinding)
	
func waitForTransition(pathName : String):
	pathOn = pathName
	signalTransition = true



func _on_movement_animation_finished(anim_name):
	if(signalTransition):
		get_parent().remove_child(self)
		if(rewinding):
			currentPathIndex = currentPathIndex - 1
		else:
			currentPathIndex = currentPathIndex + 1
		emit_signal("FinishedTransit", self, pathNames[currentPathIndex], rewinding)
		signalTransition = false
	elif(rewinding):
			switch_paths()
			print(currentPathIndex)
