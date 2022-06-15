extends AnimationPlayer



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_speed : float = 0
var current_place_in_playback : float = 0

func _on_Node2D_animationPlayer(animation : Animation, speed : float, seekTo : float):
	current_speed = speed
	self.add_animation("movement", animation)
	self.playback_speed = speed
	self.play("movement")
	self.seek(seekTo, false)


func _on_Node2D_reforwardAnimation():
	self.playback_speed = (self.playback_speed * 2) * -1
	current_speed = self.playback_speed

func _on_Node2D_rewindAnimation():
	self.playback_speed = (self.playback_speed /2) * -1
	current_speed = self.playback_speed

func seekThenStop(intevial : float):
	self.seek(intevial, false)
	self.playback_speed = 0
	self.current_place_in_playback = self.current_animation_position



func restartPlay():
	self.playback_speed = current_speed



func _on_Node2D_stop():
	self.stop()


func _on_Node2D_setPlayBackSpeed(speed):
	if(current_speed > 0):
		self.playback_speed = speed
	if(current_speed < 0):
		self.playback_speed = -1 * speed
	self.current_speed = speed


func _on_Node2D_play(rewinding):
	if(self.current_speed < 0):
		self.current_speed = self.current_speed * -1
	self.play("movement", -1, self.current_speed, rewinding)
	print(rewinding)
	print(self.current_speed)
