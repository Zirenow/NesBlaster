extends Node


# Called when the node enters the scene tree for the first time.
@export var emul_input:LineEdit
@export var emul_search_btn:Button
@export var emul_args_input:LineEdit
@export var should_launch_btn:CheckButton
var emulator_path:String
var argument_string:String
var should_launch:bool
func _ready() -> void:
	should_launch=true
	should_launch_btn.button_pressed=true

func launch_emulator(input_path:String):
	if not emulator_path.strip_edges().is_empty() and should_launch and FileAccess.file_exists(input_path):
	# Launch
		#buffer is created with input_path as its start
		var args := PackedStringArray([input_path])
		
		#arguments are parsed into a temporary array and joined to the buffer
		args.append_array(argument_string.split(" ", false))
 
		var pid:=OS.create_process(emulator_path,args)
		
	else:
		pass
	
	
	
func _on_button_pressed() -> void:
	
	# Fetch path from file explorer
	emulator_path=await Utils.get_file_from_explorer()
	emul_input.text=emulator_path
	

func _on_emul_name_text_submitted(new_text: String) -> void:
	emulator_path=new_text

func _on_emul_cmd_args_text_submitted(new_text: String) -> void:
	argument_string=new_text
	
func _on_should_launch_btn_toggled(toggled_on: bool) -> void:
	should_launch=toggled_on
	
