class_name Cutscene
extends Node2D

signal completed()

func complete():
	emit_signal("completed")
