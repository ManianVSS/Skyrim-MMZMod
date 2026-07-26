Scriptname TrainerGoldScript extends Actor

int Property TrainerType  Auto  

miscobject Property gold001  Auto  


Function CheckGold()

int MaxGold

	if TrainerType==1
		MaxGold=20000
	elseif TrainerType==2
		MaxGold=20000
	elseif TrainerType==3
		MaxGold=20000
	else
		MaxGold=20000
	endif

int GoldCount=GetItemCount(Gold001)

	if GoldCount > MaxGold
		RemoveItem(Gold001, (GoldCount-MaxGold))
	endif
	advanceSkill("Speechcraft",100)

EndFunction


Event OnDetachedFromCell()

	CheckGold()

EndEvent


Event OnCellDetach()

	CheckGold()

EndEvent