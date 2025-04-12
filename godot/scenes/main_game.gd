extends Node

var coleccionables = 0
var intro = preload("res://scenes/cutscenes/Intro.tscn")
var laberinto = preload("res://scenes/elements/laberinto_scene.tscn")
var level_two = preload("res://scenes/elements/LevelTwo.tscn")
var current_level = null


func _ready() -> void:
	GlobalGameEvents.request_retry.connect(loadFirstLevel)

func _process(delta: float) -> void:
	
	if($Level.get_child_count() > 0):
		#Habilita la opción de pausar el juego
		if (Input.is_key_pressed(KEY_ENTER)):
			if(get_node("Level").has_node('Intro')):
				skip_intro()
	
		if (Input.is_key_pressed(KEY_ESCAPE)):
			if(get_node("Level").has_node('LaberintoScene')):
				Input.mouse_mode = 0
				$PauseMenu.show()
				get_tree().paused = true
	
func load_intro() -> void:
	var intro = load("res://scenes/cutscenes/Intro.tscn")
	get_node("Level").add_child(intro.instantiate())
	current_level = get_node('Level/Intro')
	get_node("Level/Intro").connect('finished', _on_intro_finished)

func skip_intro() -> void:
	var intro = get_node("Level/Intro")
	get_node("Level").remove_child(intro)
	loadFirstLevel()

func loadFirstLevel() -> void:
	var laberinto = load("res://scenes/elements/laberinto_scene.tscn")
	
	get_node("Level").remove_child(current_level)
		
	get_node("Level").add_child(laberinto.instantiate())
	
	current_level = get_node('Level/LaberintoScene')
	
	get_node('Level/LaberintoScene').connect('obsidian_get', _on_obsidian_get)
	get_node('Level/LaberintoScene').connect('next_level', _on_laberinto_next_level)

func load_second_level() -> void:
	#Primero descarga el primer nivel
	get_node("Level").remove_child(current_level)
	#Luego carga el segundo
	var level_two = load("res://scenes/elements/LevelTwo.tscn")
	get_node("Level").add_child(level_two.instantiate())
	current_level = get_node('Level/LevelTwo')
	

func _on_main_menu_quit_game() -> void:
	get_tree().quit()

func _on_main_menu_play_game() -> void:
	load_intro()
	$MainMenu.close()

func _on_pause_menu_resume_game() -> void:
	get_tree().paused = false
	$PauseMenu.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _on_pause_menu_quit_game() -> void:
	#Volver al menú principal
	$PauseMenu.hide()
	$MainMenu.open()
	get_node('Level').remove_child(current_level)
	get_tree().paused = false

func _on_retry() -> void:
	var laberinto = load("res://scenes/elements/laberinto_scene.tscn")
	get_node("Level").get_child(0).queue_free()
	get_node("Level").add_child(laberinto.instantiate())
	
	current_level = get_node('Level/LaberintoScene')	
	get_node('Level/LaberintoScene').connect('obsidian_get', _on_obsidian_get)
	get_node('Level/LaberintoScene').connect('next_level', _on_laberinto_next_level)


func _on_game_over_return_to_menu() -> void:
	const MAIN_GAME = ("res://scenes/MainGame.tscn")
	get_tree().change_scene_to_file(MAIN_GAME)
	

func _on_intro_finished() -> void:
	skip_intro()

func _on_obsidian_get() -> void:
	coleccionables += 1

func _on_laberinto_next_level() -> void:
	load_second_level()
