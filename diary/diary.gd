extends Panel

var control_list
var current_page

func _ready():
	control_list = [
		$FirstPage,
		$SecondPage,
		$ThirdPage,
		$FourthPage
	]
	current_page = 0
	
func _process(delta):
	$Buttons/Left.visible = current_page != 0
	$Buttons/Right.visible = current_page != 3



func _on_right_pressed():
	$NextPage.play()
	control_list[current_page].visible = false
	current_page += 1
	control_list[current_page].visible = true


func _on_left_pressed():
	$NextPage.play()
	control_list[current_page].visible = false
	current_page -= 1
	control_list[current_page].visible = true
