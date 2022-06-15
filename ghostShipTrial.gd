extends PathFollow2D

signal startAnimation(animation, speed, seekTo)
signal rewindAnimation
signal reforwardAnimation 
signal startPlaying
signal seekThenStop(intervial)

var pos_in_array : int = 0
var fadeaway := false


func initialize_ghost(animation : Animation, speed : float, seekTo : float, pos : int) -> void:
	emit_signal("startAnimation",animation, speed, seekTo)
	self.pos_in_array = pos


func startFade(intervialFromShip : float, shipInterval : float):
	fadeaway = true
	modulate.a = .5
	emit_signal("seekThenStop", shipInterval + intervialFromShip * pos_in_array)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(fadeaway):
		modulate.a = lerp(modulate.a,0,.1)
		if(modulate.a < 0.01):
			modulate.a = 0
			fadeaway = false
			emit_signal("startPlaying")

func rewind():
	emit_signal("rewindAnimation")

func reforward():
	emit_signal("reforwardAnimation")
