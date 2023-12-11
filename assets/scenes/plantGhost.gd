extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	pass



func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("sup")
	pass # Replace with function body.


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("sup")
	pass # Replace with function body.
