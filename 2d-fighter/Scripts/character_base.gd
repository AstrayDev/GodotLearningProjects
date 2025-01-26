class_name Character_Base extends CharacterBody2D

@export var speed: float

@onready var collision: CollisionShape2D = $CharacterCollision
@onready var health_manager: HealthManager = $HealthManager
@onready var attack_box: Area2D = $AttackBox
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D