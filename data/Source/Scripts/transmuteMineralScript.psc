Scriptname transmuteMineralScript extends ActiveMagicEffect  
{script for spell to allow transmutation of ores}

import game

MiscObject Property Ore01  Auto  
{Lowest value ore}
MiscObject Property Ore02  Auto  
{Middle value ore}
MiscObject Property Ore03  Auto  
{Highest value ore}
Sound Property FailureSFX  Auto  
float property skillAdvancement = 30.0 auto
{How much to advance the skill?  Only works when spell actually transmutes something}
message property failureMSG auto

Function experienceIncrementSkill(String skillName, Int increment)
    Actor player = Game.GetPlayer()
    Float currentLevel = player.GetAV(skillName)
    Float newLevel=currentLevel+increment

	; if Increment is >= 100 cap it to 99
	If (increment >=100)
		increment = 99
	EndIf


    ; Prevent skill from exceeding 100
    If (newLevel > 100)
        ; Reduce skills by increment first if total will cross 100
		player.SetAV(skillName, 100-increment)
    EndIf

    ; Apply experience increment
    Game.IncrementSkillBy(skillName, increment)
	; Set level back to newLevel as reward
    player.SetAV(skillName, newLevel)
    Debug.Notification("MMZ Script Mod: Added level " + increment + " XP to " + skillName)
EndFunction

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	objectReference caster = akCaster
	if caster.getItemCount(Ore01) >= 100
		; if none of that, look for the base ore to upgrade
		caster.removeItem(Ore01, 100, TRUE)
		caster.addItem(Ore03, 100, FALSE)
		;experienceIncrementSkill("Alteration", 100)
		if Game.GetPlayer().GetAV("Alteration")>=100
			experienceIncrementSkill("Alteration", 2)
		else
			advanceSkill("alteration",skillAdvancement*100)
		endif
		;Int i = 0
		;While i < 100
		;	advanceSkill("alteration",skillAdvancement)
		;	i += 1
		;EndWhile
	elseif caster.getItemCount(Ore01) >= 50
		; if none of that, look for the base ore to upgrade
		caster.removeItem(Ore01, 50, TRUE)
		caster.addItem(Ore03, 50, FALSE)
		;experienceIncrementSkill("Alteration", 1)
		if Game.GetPlayer().GetAV("Alteration")>=100
			experienceIncrementSkill("Alteration", 1)
		else
			advanceSkill("alteration",skillAdvancement*50)
		endif

	elseif caster.getItemCount(Ore01) >= 10
		; if none of that, look for the base ore to upgrade
		caster.removeItem(Ore01, 10, TRUE)
		caster.addItem(Ore03, 10, FALSE)		
		advanceSkill("alteration",skillAdvancement*10)
	elseif caster.getItemCount(Ore01) >= 1
		; if none of that, look for the base ore to upgrade
		caster.removeItem(Ore01, 1, TRUE)
		caster.addItem(Ore03, 1, FALSE)
		advanceSkill("alteration",skillAdvancement)
	else
		; caster must have had no valid ore
		FailureSFX.play(caster)
		failureMSG.show()
	endif
endEVENT
