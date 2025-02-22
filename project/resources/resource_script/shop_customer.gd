extends Resource
class_name ShopCustomer

@export var code: String
@export var char: DialogicCharacter
var moodGood: bool
var interactionCounter: int

func dialogue(is_start:bool):
	var suffix = "START"
	if not is_start:
		suffix = "END"
	
	interactionCounter = Dialogic.VAR.get("InteractionCounter").get(code)
	if interactionCounter > 1:
		moodGood = Dialogic.VAR.get("MoodGood").get(code)
		if moodGood:
			suffix = "GoodMood_" + suffix
		else:
			suffix = "BadMood_" + suffix
	
	var timeline = (code+"_Day%02d_"+suffix)%interactionCounter
	print(timeline)
	Dialogic.start(timeline)
	pass
