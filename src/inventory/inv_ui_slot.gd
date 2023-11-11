extends Panel

@onready var item_visual : Sprite2D = $CenterContainer/Panel/item
@onready var item_amount_visual : Label = $CenterContainer/Panel/Amount

func update(item : InvSlot):
	if (!item or item.amount==0):
		item_visual.visible=false
		item_amount_visual.visible=false
	else:
		item_visual.visible=true
		item_amount_visual.visible=true
		item_visual.texute=item.item.texture
		item_amount_visual.text=str(item.amount)
		
