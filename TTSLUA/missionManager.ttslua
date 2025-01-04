-- FTC-GUID: 471de1,cff35b

-- Note: this code handles per-player elements of mission management. Global elements are
-- handled by code in startMenu.ttslua.

lockInSecondariesBtn = {
    label = "L O C K   I N\nS E C O N D A R I E S", click_function = "lockInSecondaries", function_owner = self,
    position = {-3.3, 6.07, 0}, rotation = {0, 0, 0}, height = 450, width = 2800,
    font_size = 200, color = {0, 0, 0}, font_color = {1, 1, 1},
    tooltip = "With the initial set of secondary missions in your hand, select two of them by flipping them face down with the F key, then press this button. To use Tactical Missions, flip the two Tactical cards. To use Fixed Missions, flip your choice of two other cards."
}
prepGambitsBtn = {
    label = "P R E P A R E\nG A M B I T S", click_function = "prepareGambits", function_owner = self,
    position = {3.3, 6.07, 0}, rotation = {0, 0, 0}, height = 450, width = 2800,
    font_size = 200, color = {0, 0, 0}, font_color = {1, 1, 1},
    tooltip = "At the end of battle round 3, press this button to begin choosing a Gambit. One random Gambit will be discarded and the others will be placed in your hand. Select one by flipping it face down with the F key, then press Lock In Gambit."
}
prepGambitsBtnPariahNexusLabel = "P R E P A R E\nS E C R E T S"
prepGambitsBtnPariahNexusTooltip = "At the end of battle round 3, if you want to select a secret mission, press this button. Your four available secret missions will be placed in your hand. Select one by flipping it face down with the F key, then press Lock In Secret."
lockInGambitBtn = {
    label = "L O C K   I N\nG A M B I T", click_function = "lockInGambit", function_owner = self,
    position = {9.9, 6.07, 0}, rotation = {0, 0, 0}, height = 450, width = 2800,
    font_size = 200, color = {0, 0, 0}, font_color = {1, 1, 1},
    tooltip = "After pressing Prepare Gambits and then selecting one by flipping it face down with the F key, press this button to lock in your choice."
}
lockGambitBtnPariahNexusLabel = "L O C K   I N\nS E C R E T"
lockGambitBtnPariahNexusTooltip = "After pressing Prepare Secrets and then selecting one by flipping it face down with the F key, press this button to lock in your choice."

missionPackData = nil
selectedPack = nil
playerColor = nil
cardsDealt = false
handZone = nil
secondaryDeck = nil
secondaryDeckPosition = nil
secondary1Zone = nil
secondary2Zone = nil
otherSecondary1Zone = nil
otherSecondary2Zone = nil
gambitDeck = nil
gambitPosition = nil
discardPosition = nil
targetRotation = {x = 0, y = 270, z = 180}

function onSave()
    saved_data = JSON.encode({
        svSelectedPack = selectedPack,
        svCardsDealt = cardsDealt,
    })

    return saved_data
end

function onLoad(saved_data)
    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        selectedPack = loaded_data.svSelectedPack
        cardsDealt = loaded_data.svCardsDealt
        if not cardsDealt then
            cardsDealt = false
        end
    end

    if self.getGUID() == Global.getVar("redMissionManager_GUID") then
        self.setName("Mission Manager Red")
        self.setPosition({-19,-5,35.25})
        self.setRotation({0,0,0})
        playerColor = "Red"
        handZone = getObjectFromGUID(Global.getVar("redHandZone_GUID"))
        secondary1Zone = getObjectFromGUID(Global.getVar("secondary11CardZone_GUID"))
        secondary2Zone = getObjectFromGUID(Global.getVar("secondary12CardZone_GUID"))
        otherSecondary1Zone = getObjectFromGUID(Global.getVar("secondary21CardZone_GUID"))
        otherSecondary2Zone = getObjectFromGUID(Global.getVar("secondary22CardZone_GUID"))
        gambitPosition = { x = 70.25, y = 1.5, z = 8.05 }
        discardPosition = { x = 79.25, y = 1.5, z = 8.05 }
        secondaryDeckPosition = { x = 74.75, y = 0.94, z = 8.05 }
    else
        self.setName("Mission Manager Blue")
        self.setPosition({19,-5,-35.25})
        self.setRotation({0,180,0})
        playerColor = "Blue"
        handZone = getObjectFromGUID(Global.getVar("blueHandZone_GUID"))
        secondary1Zone = getObjectFromGUID(Global.getVar("secondary21CardZone_GUID"))
        secondary2Zone = getObjectFromGUID(Global.getVar("secondary22CardZone_GUID"))
        otherSecondary1Zone = getObjectFromGUID(Global.getVar("secondary11CardZone_GUID"))
        otherSecondary2Zone = getObjectFromGUID(Global.getVar("secondary12CardZone_GUID"))
        gambitPosition = { x = 70.25, y = 1.5, z = -8.05 }
        discardPosition = { x = 79.25, y = 1.5, z = -8.05 }
        secondaryDeckPosition = { x = 74.75, y = 0.94, z = -8.05 }
    end
    self.setScale({0.6,1,0.6})
    if selectedPack then
        updateForSelectedPack()
        tryDealFixedSecondaries()
    end
end

function updateForSelectedPack()
    missionPackData = Global.getTable("missionPackData")[selectedPack]

    if selectedPack == Global.getVar("MISSION_PACK_PARIAH_NEXUS") then
        prepGambitsBtn.label = prepGambitsBtnPariahNexusLabel
        prepGambitsBtn.tooltip = prepGambitsBtnPariahNexusTooltip
        lockInGambitBtn.label = lockGambitBtnPariahNexusLabel
        lockInGambitBtn.tooltip = lockGambitBtnPariahNexusTooltip
    end

    secondaryDeck = getObjectFromGUID(missionPackData[string.lower(playerColor) .. "SecondaryDeck_GUID"])
    gambitDeck = getObjectFromGUID(missionPackData.gambitDeck_GUID)

    self.clearButtons()
    self.createButton(lockInSecondariesBtn)
    self.createButton(prepGambitsBtn)
    self.createButton(lockInGambitBtn)
end

function packSelected(params)
    selectedPack = params.pack
    updateForSelectedPack()

    secondaryDeck.setPosition(secondaryDeckPosition)
    secondaryDeck.setName(playerColor .. " secondary mission cards")
    secondaryDeck.locked = false
    secondaryDeck.tooltip = true
    secondaryDeck.interactable = true

    tryDealFixedSecondaries()
end

function onPlayerChangeColor(player_color)
    if player_color == playerColor then
        -- Our player just sat down. Deal their cards if not already done.
        tryDealFixedSecondaries()
    end
end

function stringOrNil(str)
    if str == false then
        return "false"
    elseif str == true then
        return "true"
    elseif not str then
        return "nil"
    else
        return str
    end
end

function tryDealFixedSecondaries()
    -- Only deal out the cards if our player is seated, we know what mission pack
    -- we're playing, and we haven't already dealt them.
    if Player[playerColor].seated and selectedPack and not cardsDealt then
        fixedDeck = getObjectFromGUID(missionPackData.fixedSecondaryDeck_GUID)
        newFixedDeck = fixedDeck.clone({position = fixedDeck.getPosition()})
        newFixedDeck.deal(fixedDeck.getQuantity(), playerColor)
        cardsDealt = true
    end
end

function lockInSecondaries()
    local cardsInHand = handZone.getObjects()
    local faceDownCards = 0
    for _,card in ipairs(cardsInHand) do
        if card.is_face_down then
            faceDownCards = faceDownCards + 1
        end
    end

    if faceDownCards != 2 then
        broadcastToColor("Select exactly two secondary missions by flipping them face down (hover over them and press F) before pressing Lock In Secondaries.", playerColor, "Yellow")
        return
    end

    local cardsMoved = 0
    for _,card in ipairs(cardsInHand) do
        local cardMoved = false
        if card.is_face_down then
            if cardsMoved == 0 then
                card.setPosition(secondary1Zone.getPosition())
                card.setRotation(targetRotation)
                cardMoved = true
                cardsMoved = 1
            elseif cardsMoved == 1 then
                card.setPosition(secondary2Zone.getPosition())
                card.setRotation(targetRotation)
                cardMoved = true
                cardsMoved = 2
            end
        end

        if not cardMoved then
            if card.getGMNotes() == "TacticalObjectives" then
                card.destruct()
            else
                secondaryDeck.putObject(card)
            end
        end
    end

    Wait.time(shuffleAndMaybeFlipSecondaries, 0.5)
end

function shuffleAndMaybeFlipSecondaries()
    secondaryDeck.shuffle()

    if #secondary1Zone.getObjects() > 0 and #secondary2Zone.getObjects() > 0 and #otherSecondary1Zone.getObjects() > 0 and #otherSecondary2Zone.getObjects() > 0 then
        flipCardsInZone(secondary1Zone)
        flipCardsInZone(secondary2Zone)
        flipCardsInZone(otherSecondary1Zone)
        flipCardsInZone(otherSecondary2Zone)
    end
end

function flipCardsInZone(zone)
    local objects = zone.getObjects()
    for _,object in ipairs(objects) do
        if object.type == "Card" then
            object.flip()
        end
    end
end

function lockInGambit()
    local cardsInHand = handZone.getObjects()
    local faceDownCards = 0
    for _,card in ipairs(cardsInHand) do
        if card.is_face_down then
            faceDownCards = faceDownCards + 1
        end
    end

    if faceDownCards != 1 then
        broadcastToColor("Select exactly one gambit card by flipping it face down (hover over it and press F) before pressing Lock In Gambit.", playerColor, "Yellow")
        return
    end

    for _,card in ipairs(cardsInHand) do
        if card.is_face_down then
            card.setPosition(gambitPosition)
        else
            card.setPosition(discardPosition)
        end
        card.setRotation(targetRotation)
    end
end

function prepareGambits()
    newGambitDeck = gambitDeck.clone()
    newGambitDeck.shuffle()

    if selectedPack == Global.getVar("MISSION_PACK_LEVIATHAN") then
        -- Leviathan gambits have a "discard one, draw the rest" rule.

        local topCard = newGambitDeck.getObjects()[1]
        if topCard.gm_notes == "Proceed" then
            -- Top card is Proceed, deal it
            newGambitDeck.deal(1, playerColor)
        end

        newGambitDeck.takeObject({position = discardPosition, rotation = targetRotation, smooth = false})
    end

    newGambitDeck.deal(newGambitDeck.getQuantity(), playerColor)
end