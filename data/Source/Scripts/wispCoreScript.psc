Scriptname wispCoreScript extends ObjectReference  

ingredient property glowDust auto

EVENT onActivate(objectReference actronaut)
	int num = utility.randomInt(1,3)
	(actronaut as actor).addItem(glowDust,num*10)
	disable()
	delete()
endEVENT
