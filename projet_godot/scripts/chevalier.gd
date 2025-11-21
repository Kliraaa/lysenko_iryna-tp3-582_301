extends CharacterBody2D


const SPEED = 450.0
const JUMP_VELOCITY = -550.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var death_sfx: AudioStreamPlayer = $death_sound


var taking_damage = false
var hearts_list : Array[TextureRect]
var health = 3

func _ready() -> void:
	var hearts_parent = $CanvasLayer/HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	print(hearts_list)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		audio_stream_player_2d.stop()
		

	# Get the input direction
	var direction := Input.get_axis("move-left", "move-right")
	
	# flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# ANIMATIONS 
	if taking_damage: 
		animated_sprite.play("death")
		
		return
	if direction == 0:
		animated_sprite.play("idle")
		audio_stream_player_2d.stop()
	else:
		animated_sprite.play("courir")
		if not audio_stream_player_2d.playing:
				audio_stream_player_2d.play()
		
	#apply movement
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("courir")
	else: 
		audio_stream_player_2d.stop()
		if velocity.y < 0:
			animated_sprite.play("saut_up")
		else:
			animated_sprite.play("tomber-saut_down")
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func take_damage(): 
	if health > 0:
		health -= 1
		update_heart_display()
	taking_damage = true
	death_sfx.play()

func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health
