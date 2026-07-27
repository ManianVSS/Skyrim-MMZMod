	;Khajit Chest Reset
	ResetChestByIDs(0x0007434B, ""Skyrim.esm")
	ResetChestByIDs(0x0007434D, ""Skyrim.esm")
	ResetChestByIDs(0x0007434E, ""Skyrim.esm")
	;Riverwood Trader chest Reset
	ResetChestByIDs(0x00078C0C, ""Skyrim.esm")
	;Belethor Trader chest Reset
	ResetChestByIDs(0x0009CAF8, ""Skyrim.esm")
	;Arcadia Trader chest Reset
	ResetChestByIDs(0x0009CD45, ""Skyrim.esm")
	;Spouse Blacksmith Trader chest Reset
	ResetChestByIDs(0x000C644B, ""Skyrim.esm")
	;WarMaidens
	ResetChestByIDs(0x0009CAFD, ""Skyrim.esm")
	;Radient Raiments Trader chest Reset
	ResetChestByIDs(0x000A6C04, ""Skyrim.esm")


Function ResetChestByIDs(int formID, string modName)
    ; Step 1: Get the Form from the specific plugin file
    Form baseForm = Game.GetFormFromFile(formID, modName)
    
    if baseForm
        ; Step 2: Cast/Get the ObjectReference (Note: Reset() works on ObjectReferences in the world)
        ObjectReference chestRef = baseForm as ObjectReference
        
        if chestRef
            ; Step 3: Reset the container inventory back to its default state
            chestRef.Reset()
            Debug.Notification("Vendor chest has been reset.")
        else
            Debug.Trace("Form is not a valid ObjectReference.")
        endif
    else
        Debug.Trace("Could not find Form ID in specified plugin.")
    endif
endFunction
