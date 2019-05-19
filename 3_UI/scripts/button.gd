extends Button

func _ready():
	$ConfirmationDialog.get_cancel().connect("pressed", self, "_on_ConfirmationDialog_cancelled")
	$ConfirmationDialog.add_button("Custom button", true).connect("pressed", self, "_on_ConfirmationDialog_custom")

func _on_button_pressed():
	text = "Thanks!"
	#$ConfirmationDialog.popup_centered()
	$ConfirmationDialog.show_modal(true)

func _on_ConfirmationDialog_confirmed():
	print("Clicked OK")

func _on_ConfirmationDialog_cancelled():
	print("Clicked cancel")
	
func _on_ConfirmationDialog_custom():
	print("Clicked custom button")
	$ConfirmationDialog.hide()