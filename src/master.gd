extends Control



#region Grab components from scene
@export_group("UI elements")
@export var target_name_box:	LineEdit
@export var file_name_box:		LineEdit
@export var start_range:		LineEdit
@export var end_range:			LineEdit
@export var should_override:	CheckButton
@export var engine_type:		OptionButton
@export var severity_slider:	HSlider
@export var severity_label:		Label
@export var Emulation:Node
#endregion


var rom_file:RomData
func _ready() -> void:
	start_range.text="0"
	file_name_box.text="corruption.nes"
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta) -> void:
	severity_label.text="Severity: "+str(severity_slider.value)+"%"
	

# Function that scrambles the file
func corrupt_file()->void:
	var mutated_bytes=0
	var copied_data:PackedByteArray=rom_file.data.duplicate()
	
	if end_range.text as int <=rom_file.size:
		for i in range(start_range.text as int,end_range.text as int):
			if randf() < severity_slider.value / 100.0:
				match engine_type.get_selected_id():
					0:
						copied_data[i]=randi_range(0,255) #random
					1:
						copied_data[i] = (~copied_data[i]) & 0xFF #flip
					2:
						copied_data[i]=copied_data[i] <<1 #shift right by one
				 
				mutated_bytes+=1
		OS.alert(str(mutated_bytes)+" byte(s) mutated","Succes!")
		# write mangled data to a new file
		var output_file = FileAccess.open(file_name_box.text, FileAccess.WRITE)
		output_file.store_buffer(copied_data)
		output_file.close()
		Emulation.launch_emulator(output_file.get_path())
		
		
	else:
		OS.alert("Range is longer than file","Error")
		
	
	

func _on_choose_file_pressed() -> void:
	rom_file=RomData.new(await Utils.get_file_from_explorer())
	target_name_box.text=rom_file.path 
	

func check_input()->bool:
	
	if !start_range.text.is_valid_int() or !end_range.text.is_valid_int():
		OS.alert("Range is not a number","Error!")
		return false
	if !file_name_box.text.is_valid_filename():
		OS.alert("Cannot create a file with such name","Error!")
		return false
	
	return true

func _on_corrupt_btn_pressed() -> void:
	if check_input():
		corrupt_file()
	else:
		pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on and rom_file!=null:
		end_range.text=str(rom_file.size)
	else:
		end_range.text=""
