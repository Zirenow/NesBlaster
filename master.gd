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
#endregion

#oo
var file_path
var file_size
var rom_file:RomData
func _ready() -> void:

	#file_path=""
	start_range.text="0"
	file_name_box.text="corruption.nes"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	severity_label.text="Severity: "+str(severity_slider.value)+"%"
	

# Function that scrambles the file
func corrupt_file():
	var mutated_bytes=0
	
	
	# data inside the class somehow doesnt copy
	var copied_data:PackedByteArray=rom_file.data.duplicate()
	
	
	if end_range.text as int <=rom_file.size:
		for i in range(start_range.text as int,end_range.text as int):
			if randf() < severity_slider.value / 100.0:
				match engine_type.get_selected_id():
					0:
						copied_data[i]=randi_range(0,255)
					1:
						copied_data[i] = (~copied_data[i]) & 0xFF
					2:
						copied_data[i]=copied_data[i] <<1
				
				mutated_bytes+=1
		OS.alert(str(mutated_bytes)+" byte(s) mutated","Succes!")
		# write mangled data to a new file
		var output_file = FileAccess.open(file_name_box.text, FileAccess.WRITE)
		output_file.store_buffer(copied_data)
		output_file.close()
		
		
	else:
		OS.alert("Range is longer than file","Error")
		
	
	

#TODO Check if file is not null
func _on_choose_file_pressed() -> void:
	DisplayServer.file_dialog_show(
		"Select Rom",
		"",
		"",
		false,
		DisplayServer.FILE_DIALOG_MODE_OPEN_FILE,
		["*.nes ; NES files"],
			func(status, selected_paths, _selected_filter):
				if selected_paths.size()>0:
					#file_path=selected_paths[0]
					#target_name_box.text=file_path
					rom_file=RomData.new(selected_paths[0])
					target_name_box.text=rom_file.path
				else:
					pass
				
	)

func check_input()->bool:
	var range_valid
	var file_range_valid
	var file_name_valid
	if start_range.text.is_valid_int() and end_range.text.is_valid_int():
		range_valid=true
	if file_name_box.text.is_valid_filename():
		file_name_valid=true
	
	if range_valid and file_name_valid:
		return true
	else:
		return false
		

func _on_corrupt_btn_pressed() -> void:
	if check_input():
		corrupt_file()
	else:
		OS.alert("Possible causes:\n
		- range is invalid or greater than file size\n
		- range is not a number\n
		- output file name is not valid\n
		- input file was not chosen","Error!")


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on and rom_file!=null:
		end_range.text=str(rom_file.size)
	else:
		end_range.text=""
