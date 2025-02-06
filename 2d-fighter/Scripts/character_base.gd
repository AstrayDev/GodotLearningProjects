class_name CharacterBase extends CharacterBody2D

@onready var collision: HitComponent = $HitComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var attack_box: Area2D = $AttackBox
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
