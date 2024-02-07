extends CanvasLayer

@onready var arrow_label = $MarginContainer/MarginContainer/ArrowLabel

func _ready():
	update_arrow_label()
	
	
func update_arrow_label():
	arrow_label.text = "Arrows: " + str(GameMaster.arrow_amount)
