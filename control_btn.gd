extends Control

signal reload
export(int) var start_bar_index = 0

func _ready():
	$BarIndex.value = start_bar_index

func _on_ReloadButton_pressed():
	print(start_bar_index)
	emit_signal("reload", start_bar_index)
	$CurrBarIndex.text = ""

func _on_BarIndex_value_changed(value):
	start_bar_index = int(value)

func on_bar_index_updated(index):
	$CurrBarIndex.text = str(index)
