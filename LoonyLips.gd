extends Control

onready var DisplayText = $RootContainer/DisplayText;
onready var PlayerText = $RootContainer/InputContainer/PlayerText;
onready var PlayerButton = $RootContainer/InputContainer/PlayerButton;
onready var PlayerButtonLabel = $RootContainer/InputContainer/PlayerButton/Label;

var player_inputs = [];
var prompts = ["a character", "something to be searched", "a villain", "something the villain did/is doing"];
var story = "At that time %s was searching for %s, but he/she wasn't aware that %s was already %s.";


func _ready():
	DisplayText.text = "Welcome to Loony Lips, we're going to tell a story and have a wonderful time! ";
	check_player_inputs_length();

func _on_PlayerText_text_entered(new_text: String):
	add_to_player_inputs(new_text);

func _on_TextureButton_pressed():
	if is_story_done() :
		get_tree().reload_current_scene();
		return;
		
	PlayerText.emit_signal("text_entered", PlayerText.text);

	
func add_to_player_inputs(new_text: String):
	player_inputs.append(new_text);
	DisplayText.text = "";
	PlayerText.clear();
	check_player_inputs_length();

func is_story_done():
	return player_inputs.size() >= prompts.size();

func check_player_inputs_length():
	if is_story_done():
		end_game();
	else:
		prompt_player();

func tell_story():
	DisplayText.text = story % player_inputs;

func prompt_player():
	DisplayText.text += "May I have " + prompts[player_inputs.size()] + " ?";
	PlayerText.grab_focus();

func change_to_end_player_button():
	PlayerButton.rect_min_size = Vector2(140, 73);
	PlayerButtonLabel.text = "Again!";


func end_game():
	PlayerText.queue_free();
	change_to_end_player_button();
	tell_story();
