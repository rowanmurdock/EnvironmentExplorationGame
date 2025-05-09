extends Area2D

var scan_duration := 0.5


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	monitoring = false
	visible = false

func start_scan():
	monitoring = true
	visible = true
	$roverscanner.play("scan")  
	await get_tree().create_timer(scan_duration).timeout
	monitoring = false
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
