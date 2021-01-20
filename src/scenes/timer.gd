extends RichTextLabel

var ms = 00
var s = 00
var m = 00
func _process(delta):
	if ms > 9:
		s += 1
		ms = 0
	if s > 59:
		m += 1
		s = 0
	set_text(str(m) + ":" + str(s) + ":" + str(ms))


func _on_Timer_timeout():
	ms += 1
	pass # Replace with function body.
