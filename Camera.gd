extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var parent_body 

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_body = get_node("/root/Spatial/KinematicBody")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return
	
