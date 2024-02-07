extends CanvasLayer

const green: Color = Color("14bc14")
const red: Color = Color("fa352d")

@onready var arrow_label = $MarginContainer/MarginContainer/ArrowLabel

func _ready():
	update_arrow_label()
	
	
func update_arrow_label():
	arrow_label.text = "Arrows: " + str(GameMaster.arrow_amount)
	if GameMaster.arrow_amount > 0:
		arrow_label.modulate = green
	else:
		arrow_label.modulate = red
