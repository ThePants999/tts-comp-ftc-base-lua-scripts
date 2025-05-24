-- FTC-GUID: 738804
-- CONTENT:
-- size changer manager
-- deploy zones manager
-- objectives manager
-- mission manager
-- game manager

menuX = 18
menuZ = 1.05-1.05

MISSION_PACK_LEVIATHAN = Global.getVar("MISSION_PACK_LEVIATHAN")
MISSION_PACK_PARIAH_NEXUS = Global.getVar("MISSION_PACK_PARIAH_NEXUS")

keepForTerrainEditor = true

mat_GUID = Global.getVar("mat_GUID")

function onLoad(saved_data)
    --self.setPosition({40,-4,0})
    self.setRotation({0,270,0})
    -- load from saved
    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        gameMode = loaded_data.svgameMode
        inGame = loaded_data.svinGame
        currentTurn = loaded_data.svcurrentTurn
        currentPhase = loaded_data.svcurrentPhase
        mapSizeSelected = loaded_data.svmapSizeSelected
        sizeConfirmed = loaded_data.svsizeConfirmed
        deploySelected = loaded_data.svdeploySelected
        packSelected = loaded_data.svPackSelected
    end

    mat = getObjectFromGUID(mat_GUID)
    if simulation then print("THIS IS "..currentTurn.." TURN") end

    redTurnCounter = getObjectFromGUID(Global.getVar("redTurnCounter_GUID"))
    blueTurnCounter = getObjectFromGUID(Global.getVar("blueTurnCounter_GUID"))
    gameTurnCounter = getObjectFromGUID(Global.getVar("gameTurnCounter_GUID"))
    redCpCounter = getObjectFromGUID(Global.getVar("redCPCounter_GUID"))
    blueCpCounter = getObjectFromGUID(Global.getVar("blueCPCounter_GUID"))
    if inGame == false then
        Notes.setNotes(notePadTxt)
    else
        Notes.setNotes("")
    end
    if deploymentIngamePlaced == true then
        deployIngameBtn.label = deployIngameLblOpen
    else
        deployIngameBtn.label = deployIngameLblClosed
    end
    if areaPlaced == true then
        areaBtn.label = areaLblOpen
    else
        areaBtn.label = areaLblClosed
    end
    if packSelected then
        missionPackData = Global.getTable("missionPackData")[packSelected]
    end
    gameTurnCounter.call("checkGameEnd")
    writeMenus()
    if not inGame then
        makeAnnouncement()
    end
end

function onSave()
    saved_data = JSON.encode({
        svinGame = inGame,
        svgameMode = gameMode,
        svcurrentTurn = currentTurn,
        svcurrentPhase = currentPhase,
        svmapSizeSelected = mapSizeSelected,
        svsizeConfirmed = sizeConfirmed,
        svdeploySelected = deploySelected,
        svPackSelected = packSelected,
    })

    return saved_data
end

function makeAnnouncement()
    local features={
    "2.58: added alternative objective layouts for Hidden Supplies, auto un-hide locked-in secondaries, plus minor fixes",
    "2.59: shuffle secondaries before drawing; remove tablet and datasheet bags",
    "2.60: Pariah Nexus support; allow DZ/objective height control during game",
    "2.61: Pariah Nexus day 1 card errata and tournament missions; fix pack selection before both players seated; Pariah Nexus reference sheet; Containment area lines",
    "2.62: fixed 'last roll' showing you the fifth-last roll",
    "2.63: update PDF URLs at last, and update Linchpin and Storm Hostile Objective cards, removed debug print statements (oops)",
    "2.64: minor bug fixes"
    }
    printToAll("NEW FEATURES:", "Yellow")
    for i, new in ipairs(features) do
        printToAll("- "..new, "Yellow")
    end
end

-- ********************
-- SIZE CHANGER MANAGER
-- ********************

positionValue={0,-9.52,0}
sizeData={
    {id=1, name='C o m b a t     P a t r o l - 44" x 30"', scale={1.22,1,0.83}, defaultObjectives=0},
    {id=2, name='Incursion / Strike Force - 44" x 60"', scale={0.83*2,1,1.22}, defaultObjectives=0},
    {id=3, name='O n s l a u g h t - 44" x 90"', scale={0.83*3,1,1.22}, defaultObjectives=0},
}

menuSizeX = 0
menuSizeY = 5
menuSizeZ = 25
arrowOffset=9.5

mapSizeSelected=2
numberSizes=#sizeData
sizeConfirmed=false

sizeMenuBtn={
    index=1, label="S E L E C T     B A T T L E F I E L D     S I Z E", click_function="none", function_owner=self,
    position={menuSizeX, menuSizeY ,menuSizeZ-2.05}, rotation={0,0,0}, height=450, width=8000, scale = {1.3,1.3,1.3},
    font_size=300, color={0,0,0}, font_color={1,1,1}
}

sizeBtn={
    index= i, label="Zone", click_function="none", function_owner=self,
    position={-menuSizeX, menuSizeY ,menuSizeZ}, rotation={0,0,0}, height=450, width=6000,scale = {1.3,1.3,1.3},
    font_size=300, color={0.6,0.6,0.6}, font_color={0,0,0}
}
sizeUpBtn={
    index=1, label="->", click_function="sizeUp", function_owner=self,
    position={-menuSizeX+arrowOffset, menuSizeY ,menuSizeZ}, rotation={0,0,0}, height=450, width=800,scale = {1.3,1.3,1.3},
    font_size=300, color={0,0,0}, font_color={1,1,1}
}
sizeDownBtn={
    index=1, label="<-", click_function="sizeDown", function_owner=self,
    position={-menuSizeX-arrowOffset, menuSizeY ,menuSizeZ}, rotation={0,0,0}, height=450, width=800,scale = {1.3,1.3,1.3},
    font_size=300, color={0,0,0}, font_color={1,1,1}
}
confirmBtn={
    index= i, label="C O N F I R M\nFOR GAMING", click_function="confirmSizeGame", function_owner=self,
    position={-menuSizeX, menuSizeY ,menuSizeZ+3.5}, rotation={0,0,0}, height=1400, width=4400, scale = {1.3,1.3,1.3},
    font_size=500, color={0,0.7,0}, font_color={0,0,0}
}
confirmBtn2={
    index= i, label="C O N F I R M\nFOR MAP MAKING", click_function="confirmSizeTerrain", function_owner=self,
    position={-menuSizeX, menuSizeY ,menuSizeZ+7.5}, rotation={0,0,0}, height=1400, width=4400, scale = {1.3,1.3,1.3},
    font_size=500, color={0.7,0,0}, font_color={0,0,0}
}

function refreshMat()
    mat = getObjectFromGUID(mat_GUID)
end

function writeSizeMenu()
    self.clearButtons()
    if sizeConfirmed then
        return
    end
    self.createButton(sizeMenuBtn)
    sizeBtn.label=sizeData[mapSizeSelected].name
    self.createButton(sizeBtn)
    self.createButton(sizeUpBtn)
    self.createButton(sizeDownBtn)
    self.createButton(confirmBtn)
    self.createButton(confirmBtn2)
    mat.setScale(sizeData[mapSizeSelected].scale)
    mat.setPosition(positionValue)
end

function sizeUp()
    sizeUpDown(1)
end

function sizeDown()
    sizeUpDown(-1)
end

function sizeUpDown(increment)
    mapSizeSelected=mapSizeSelected+increment
    if mapSizeSelected > #sizeData then
        mapSizeSelected=1
    end
    if mapSizeSelected < 1 then
        mapSizeSelected=#sizeData
    end
    updateDeployObjectivesSelection()
    writeMenus()
end

function confirmSizeGame()
    confirmSizeMat("game")
    --deleting the Combat Patrol Mission book unless on the appropriate map size
    if sizeData[mapSizeSelected].id ~= 1 then
        cpbook = getObjectFromGUID(Global.getVar("CPMissionBook_GUID"))
        destroyObject(cpbook)
    end
end

function confirmSizeTerrain()
    confirmSizeMat("terrain")
end

function confirmSizeMat(type)
    gameMode= type
    sizeConfirmed=true
    mat.setScale(sizeData[mapSizeSelected].scale)
    self.setRotation({0,270,0})
    writeMenus()
    if gameMode == "game" then
    end
    if gameMode == "terrain" then
        switchToTerrainEditor()
    end
end

function updateDeployObjectivesSelection()
    deploySelected = #DeployZonesData
end

function switchToTerrainEditor()
    printToAll("Deleting unnecessary things.\nPLEASE WAIT..", "Yellow")
    local pos={}
    for i, obj in ipairs(getAllObjects()) do
        pos=obj.getPosition()
        if ((pos.y > -8 and pos.y < 0.36) or pos.y > 0.71) and not obj.getVar("keepForTerrainEditor") then
            obj.destroy()
        end
    end
    Global.setVectorLines({})
    printToAll("DONE!", "Yellow")
end

-- END size changer

-- ********************
-- DEPLOY ZONES MANAGER
-- ********************

DeployZonesData = {
    --Pariah Nexus missions
    {name = "[PN] Hammer and Anvil", objectivesID = 101, draw = {
        --[[1]]{type = "line", color = "Red", position = "x", fromSide = 18},
        --[[2]]{type = "line", color = "Teal", position = "-x", fromSide = 18}}},
    {name = "[PN] Dawn of War", objectivesID = 102, draw = {
        --[[1]]{type = "line", color = "Teal", position = "-z", fromSide = 12},
        --[[2]]{type = "line", color = "Red", position = "z", fromSide = 12}}},
    {name = "[PN] Sweeping Engagement", objectivesID = 103, draw = {
        --[[1]]{type = "stepped", color = "Teal", position = "-z", steps = {{fromSide = 8}, {fromSide = 14}}},
        --[[2]]{type = "stepped", color = "Red", position = "z", steps = {{fromSide = 14}, {fromSide = 8}}}}},
    {name = "[PN] Search and Destroy", objectivesID = 104, draw = {
        --[[1]]{type = "quarter", color = "Teal", position = "-x-z", fromCenter = 9},
        --[[2]]{type = "quarter", color = "Red", position = "xz", fromCenter = 9},
        --[[3]]{type = "circle", color = "White", fromCenter = 9}}},
    {name = "[PN] Crucible of Battle", objectivesID = 105, draw = {
        --[[1]]{type = "triangle", color = "Red", position = "x"},
        --[[2]]{type = "triangle", color = "Teal", position = "-x"}}},
    {name = "[PN] Tipping Point", objectivesID = 106, draw = {
        --[[1]]{type = "stepped", color = "Teal", position = "-x", steps = {{fromSide = 12}, {fromSide = 20}}},
        --[[2]]{type = "stepped", color = "Red", position = "x", steps = {{fromSide = 20}, {fromSide = 12}}}}},
    --Pariah Nexus missions with Hidden Supplies
    {name = "[PN] Hammer and Anvil (HS)", objectivesID = 107, draw = {
        --[[1]]{type = "line", color = "Red", position = "x", fromSide = 18},
        --[[2]]{type = "line", color = "Teal", position = "-x", fromSide = 18}}},
    {name = "[PN] Dawn of War (HS)", objectivesID = 108, draw = {
        --[[1]]{type = "line", color = "Teal", position = "-z", fromSide = 12},
        --[[2]]{type = "line", color = "Red", position = "z", fromSide = 12}}},
    {name = "[PN] Sweeping Engagement (HS)", objectivesID = 109, draw = {
        --[[1]]{type = "stepped", color = "Teal", position = "-z", steps = {{fromSide = 8}, {fromSide = 14}}},
        --[[2]]{type = "stepped", color = "Red", position = "z", steps = {{fromSide = 14}, {fromSide = 8}}}}},
    {name = "[PN] Search and Destroy (HS)", objectivesID = 110, draw = {
        --[[1]]{type = "quarter", color = "Teal", position = "-x-z", fromCenter = 9},
        --[[2]]{type = "quarter", color = "Red", position = "xz", fromCenter = 9},
        --[[3]]{type = "circle", color = "White", fromCenter = 9}}},
    {name = "[PN] Crucible of Battle (HS)", objectivesID = 111, draw = {
        --[[1]]{type = "triangle", color = "Red", position = "x"},
        --[[2]]{type = "triangle", color = "Teal", position = "-x"}}},
    {name = "[PN] Tipping Point (HS)", objectivesID = 112, draw = {
        --[[1]]{type = "stepped", color = "Teal", position = "-x", steps = {{fromSide = 12}, {fromSide = 20}}},
        --[[2]]{type = "stepped", color = "Red", position = "x", steps = {{fromSide = 20}, {fromSide = 12}}}}},
    --Leviathan missions
    {name = "[L] Hammer and Anvil", objectivesID = 12, draw = {
        --[[1]]{type = "line", color = "Red", position = "x", fromCenter = 12},
        --[[2]]{type = "line", color = "Teal", position = "-x", fromCenter = 12}}},
    {name = "[L] Dawn of War", objectivesID = 13, draw = {
        --[[1]]{type = "line", color = "Teal", position = "-z", fromCenter = 12},
        --[[2]]{type = "line", color = "Red", position = "z", fromCenter = 12}}},
    {name = "[L] Sweeping Engagement", objectivesID = 14, draw = {
        --[[1]]{type = "triangle", color = "Red", position = "z"},
        --[[2]]{type = "triangle", color = "Teal", position = "-z"}}},
    {name = "[L] Search and Destroy", objectivesID = 15, draw = {
        --[[1]]{type = "quarter", color = "Teal", position = "-x-z", fromCenter = 9},
        --[[2]]{type = "quarter", color = "Red", position = "xz", fromCenter = 9},
        --[[3]]{type = "circle", color = "White", fromCenter = 9}}},
    {name = "[L] Crucible of Battle", objectivesID = 16, draw = {
        --[[1]]{type = "triangle", color = "Red", position = "x"},
        --[[2]]{type = "triangle", color = "Teal", position = "-x"}}},
    --Leviathan Missions with Hidden Supplies
    {name = "[L] Hammer and Anvil (HS)", objectivesID = 17, draw = {
        --[[1]]{type = "line", color = "Red", position = "x", fromCenter = 12 },
        --[[2]]{type = "line", color = "Teal", position = "-x", fromCenter = 12}}},
    {name = "[L] Dawn of War (HS)", objectivesID = 18, draw = {
        --[[1]]{type = "line", color = "Teal", position = "-z", fromCenter = 12 },
        --[[2]]{type = "line", color = "Red", position = "z", fromCenter = 12}}},
    {name = "[L] Sweeping Engagement (HS)", objectivesID = 19, draw = {
        --[[1]]{type = "triangle", color = "Red", position = "z"},
        --[[2]]{type = "triangle", color = "Teal", position = "-z"}}},
    {name = "[L] Search and Destroy (HS)", objectivesID = 20, draw = {
        --[[1]]{type = "quarter", color = "Teal", position = "-x-z", fromCenter = 9},
        --[[2]]{type = "quarter", color = "Red", position = "xz", fromCenter = 9},
        --[[3]]{type = "circle", color = "White", fromCenter = 9}}},
    {name = "[L] Crucible of Battle (HS)", objectivesID = 21, draw = {
        --[[1]]{type = "triangle", color = "Red", position = "x"},
        --[[2]]{type = "triangle", color = "Teal", position = "-x"}}},
    --Combat Patrol Missions
    {name = "(CP) Clash of Patrols", objectivesID = 22, draw = {
        --[[1]]{type = "line", color = "Red", position = "-z", fromCenter = 10 },
        --[[2]]{type = "line", color = "Teal", position = "z", fromCenter = 10}}},
    {name = "(CP) Archeotech Recovery", objectivesID = 23, draw = {
        --[[1]]{type = "line", color = "Red", position = "x", fromCenter = 12 },
        --[[2]]{type = "line", color = "Teal", position = "-x", fromCenter = 12}}},
    {name = "(CP) Forward Outpost", objectivesID = 24, draw = {
        --[[1]]{type = "line", color = "Red", position = "x", fromCenter = 12 },
        --[[2]]{type = "line", color = "Teal", position = "-x", fromCenter = 12}}},
    {name = "(CP) Scorched Earth", objectivesID = 25, draw = {
        --[[1]]{type = "triangle", color = "Red", position = "x"},
        --[[2]]{type = "triangle", color = "Teal", position = "-x"}}},
    {name = "(CP) Sweeping Raid", objectivesID = 26, draw = {
        --[[1]]{type = "line", color = "Red", position = "x", fromCenter = 12 },
        --[[2]]{type = "line", color = "Teal", position = "-x", fromCenter = 12}}},
    {name = "(CP) Display of Might", objectivesID = 27, draw = {
        --[[1]]{type = "line", color = "Red", position = "x", fromCenter = 12 },
        --[[2]]{type = "line", color = "Teal", position = "-x", fromCenter = 12}}},
    {name = "None", draw = {type = "none"}},
}

deployLineHeight = 2.1
deployLineYPos = deployLineHeight-0.1
sizeMulti = 36
arrowOffset = 7.5

defaultDeployHeight=2
deployOffset = 0
deployMenuBtn = {
    index = 1, label = "Select deployment zones", click_function = "none", function_owner = self,
    position = { - menuX, 5, -1}, rotation = {0, 0, 0}, height = 750, width = 8000,
    font_size = 500, color = {0, 0, 0}, font_color = {1, 1, 1}
}

secondRowOffset= 1.2
deployBtn = {
    index = i, label = "", click_function = "none", function_owner = self,
    position = { - menuX, 5, 1}, rotation = {0, 0, 0}, height = 750, width = 6000,
    font_size = 400, color = {1, 1, 1}, font_color = {0, 0, 0}
}
deployUpBtn = {
    index = 1, label = "->", click_function = "deployUp", function_owner = self,
    position = { - menuX + arrowOffset, 5, 1}, rotation = {0, 0, 0}, height = 750, width = 800,
    font_size = 300, color = {0, 0, 0}, font_color = {1, 1, 1}
}
deployDownBtn = {
    index = 1, label = "<-", click_function = "deployDown", function_owner = self,
    position = { - menuX - arrowOffset, 5, 1}, rotation = {0, 0, 0}, height = 750, width = 800,
    font_size = 300, color = {0, 0, 0}, font_color = {1, 1, 1}
}
deployOffsetMenuBtn = {
    index = 1, label = "Deploy\nHeight", click_function = "none", function_owner = self,
    position = {-menuX - 1.4*arrowOffset, 5, menuZ}, rotation = {0, 0, 0}, height = 450, width = 1000,
    font_size = 150, color = {0, 0, 0}, font_color = {1, 1, 1}
}
deployOffsetUpBtn = {
    index = 1, label = "+", click_function = "deployOffsetUp", function_owner = self,
    position = {-menuX - 1.4*arrowOffset, 5, menuZ - secondRowOffset}, rotation = {0, 0, 0}, height = 450, width = 800,
    font_size = 300, color = {0, 0, 0}, font_color = {1, 1, 1}
}
deployOffsetDownBtn = {
    index = 1, label = "-", click_function = "deployOffsetDown", function_owner = self,
    position = {-menuX - 1.4*arrowOffset, 5, menuZ + secondRowOffset}, rotation = {0, 0, 0}, height = 450, width = 800,
    font_size = 300, color = {0, 0, 0}, font_color = {1, 1, 1}
}

function drawDeployZone(zone)
    local drawDataZone = zone.draw
    for i, drawData in ipairs(drawDataZone) do
        if drawData.type == "arrow" then
            drawArrow(drawData)
        end
        if drawData.type == "line" then
            drawLine(drawData)
        end
        if drawData.type == "stepped" then
            drawSteps(drawData)
        end
        if drawData.type == "quarter" then
            drawQuarter(drawData)
        end
        if drawData.type == "diagonal" then
            drawDiagonal(drawData)
        end
        if drawData.type == "rectangle" then
            drawRectangle(drawData)
        end
        if drawData.type == "corner" then
            drawCorner(drawData)
        end
        if drawData.type == "triangle" then
            drawTriangle(drawData)
        end
        if drawData.type == "circle" then
            drawCircle(drawData, "deployZone")
        end
        if drawData.type == "circleInZone" then
            drawCircleInZone(drawData, "deployZone")
        end
    end
    setDeployHeight()
end

function setDeployHeight()
    local pos = {0,0,0}
    local found_GUID = {}
    for i, obj in ipairs(getAllObjects()) do
        if obj.getGMNotes() == "deployZone" then
            table.insert(found_GUID, #found_GUID+1, obj.getGUID())
        end
    end
    local found= nil
    for j, guid in ipairs(found_GUID) do
        found=getObjectFromGUID(guid)
        pos = found.getPosition()
        found.setPosition({pos[1], defaultDeployHeight+ deployOffset, pos[3]})
    end
end

function drawRectangle(drawData)
    local mat = getObjectFromGUID(mat_GUID)
    local linePosL = {x = 0, y = deployLineYPos, z = 0}
    local lineRotL = {x = 0, y = 90, z = 0}
    local lineScaleL = {x = 5, y = deployLineHeight, z = 0.02}
    local linePosS1 = {x = 0, y = deployLineYPos, z = 0}
    local lineRotS1 = {x = 0, y = 0, z = 0}
    local lineScaleS1 = {x = 5, y = deployLineHeight, z = 0.02}
    local linePosS2 = {x = 0, y = deployLineYPos, z = 0}
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "z" or drawData.position == "-z" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end
    if drawData.wide ~= 0 then
        mapBase = drawData.wide * 2
    end

    lineScaleL.x = drawData.wide * 2
    linePosL.x = drawData.fromCenter

    lineScaleS1.x = (mapHeight/2)-drawData.fromCenter
    linePosS1.x = drawData.fromCenter + ((mapHeight/2) - drawData.fromCenter)/2
    linePosS1.z = drawData.wide

    linePosS2.x = linePosS1.x
    linePosS2.z = -linePosS1.z

    if drawData.position == "x" then
        -- default values
    end
    if drawData.position == "-x" then
            linePosL.x = - linePosL.x
            linePosS2.x = -linePosS2.x
            linePosS1.x = -linePosS1.x
    end
    if drawData.position == "z" then
        linePosL.z = linePosL.x
        linePosL.x = 0
        lineRotL.y = 0

        local tmp = linePosS1.z
        linePosS1.z = linePosS1.x
        linePosS1.x = tmp
        lineRotS1.y = 90

        linePosS2.z = linePosS1.z
        linePosS2.x = -tmp

    end
    if drawData.position == "-z" then
        linePosL.z = -linePosL.x
        linePosL.x = 0
        lineRotL.y = 0

        local tmp = linePosS1.z
        linePosS1.z = -linePosS1.x
        linePosS1.x = -tmp
        lineRotS1.y = 90

        linePosS2.z = linePosS1.z
        linePosS2.x = tmp

    end
    spawnLine(linePosL, lineRotL, lineScaleL, drawData.color, "deployZone") -- orizz
    spawnLine(linePosS1, lineRotS1, lineScaleS1, drawData.color,  "deployZone") -- vert1
    spawnLine(linePosS2, lineRotS1, lineScaleS1, drawData.color, "deployZone") -- vert2
end

function drawCorner(drawData)
    local mat = getObjectFromGUID(mat_GUID)
    local linePosL = {x = 0, y = deployLineYPos, z = 0}
    local lineRotL = {x = 0, y = 0, z = 0}
    local lineScaleL = {x = 5, y = deployLineHeight, z = 0.02}
    local linePosS1 = {x = 0, y = deployLineYPos, z = 0}
    local lineRotS1 = {x = 0, y = 90, z = 0}
    local lineScaleS1 = {x = 5, y = deployLineHeight, z = 0.02}
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "x" or drawData.position == "-x" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end
    lineScaleL.x = (mapHeight/2) + drawData.wide
    linePosL.x = (mapHeight/4)-(drawData.wide/2)
    linePosL.z = drawData.fromCenter

    lineScaleS1.x = (mapBase/2)-drawData.fromCenter
    linePosS1.z = drawData.fromCenter + lineScaleS1.x/2
    linePosS1.x = -drawData.wide

    if drawData.position == "z" then
        -- default values
    end
    if drawData.position == "-z" then
            linePosL.x = - linePosL.x
            linePosL.z = - linePosL.z

            linePosS1.z = -linePosS1.z
            linePosS1.x = -linePosS1.x
    end
    if drawData.position == "x" then -- not valid, to do
        linePosL.z = linePosL.x
        linePosL.x = 0
        lineRotL.y = 0

        local tmp = linePosS1.z
        linePosS1.z = linePosS1.x
        linePosS1.x = tmp
        lineRotS1.y = 90
    end
    if drawData.position == "-x" then-- not valid, to do
        linePosL.z = -linePosL.x
        linePosL.x = 0
        lineRotL.y = 0

        local tmp = linePosS1.z
        linePosS1.z = -linePosS1.x
        linePosS1.x = -tmp
        lineRotS1.y = 90
    end
    spawnLine(linePosL, lineRotL, lineScaleL, drawData.color, "deployZone") -- long
    spawnLine(linePosS1, lineRotS1, lineScaleS1, drawData.color,  "deployZone") -- short
end

function drawDiagonal(drawData)
    local mat = getObjectFromGUID(mat_GUID)
    local linePos = {x = 0, y = deployLineYPos, z = 0}
    local lineRot = {x = 0, y = 0, z = 0}
    local lineScale = {x = 5, y = deployLineHeight, z = 0.02}
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "x" or drawData.position == "-x" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end
    local mainDiagonal = 0
    local edgeLoss = 0
    local triBase = 0 -- triangle with hypotenuse as the needed deploy line

    local edgeAngle = 0 -- angle of the line from the given map edge
    local edgeAngleRad = 0
    local halfTriBase = 0 -- triangle with hypotenuse that is half the line lenght
    local halfTriHeight = 0 -- triangle with hypotenuse that is half the line lenght
    mainDiagonal = math.sqrt(math.pow(mapBase, 2) + math.pow(mapHeight, 2))
    edgeAngleRad = math.atan(mapBase / mapHeight)
    edgeAngle = math.deg(edgeAngleRad)
    edgeLoss = drawData.fromCenter / math.cos(edgeAngleRad)
    triBase = mapBase-edgeLoss
    local ratio = triBase / mapBase
    lineScale.x = mainDiagonal * ratio
    lineRot.y = edgeAngle
    halfTriBase = lineScale.x * math.sin(edgeAngleRad) / 2
    halfTriHeight = lineScale.x * math.cos(edgeAngleRad) / 2
    linePos.x = (mapHeight/2) - (lineScale.x/2) * math.cos(edgeAngleRad)
    linePos.z = (mapBase/2) - (lineScale.x/2) * math.sin(edgeAngleRad)
    if drawData.position == "z" then -- upper right
        -- default values
    end
    if drawData.position == "-z" then
        linePos.x = - linePos.x
        linePos.z = - linePos.z
    end
    spawnLine(linePos, lineRot, lineScale, drawData.color,  "deployZone")
end

function drawTriangle(drawData)
    local mat = getObjectFromGUID(mat_GUID)
    local linePos = {x = 0, y = deployLineYPos, z = 0}
    local lineRot = {x = 0, y = 0, z = 0}
    local lineScale = {x = 5, y = deployLineHeight, z = 0.02}
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "z" or drawData.position == "-z" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end

    local triBase = 0 -- triangle with hypotenuse as the needed deploy line
    local triHeight = 0 -- triangle with hypotenuse as the needed deploy line

    local edgeAngle = 0 -- angle of the line from the given map edge
    local edgeAngleRad = 0

    triBase = mapBase
    triHeight = mapHeight/2
    edgeAngleRad = math.atan(triBase/triHeight )
    if drawData.position == "z" or drawData.position == "-z" then
        edgeAngleRad = -edgeAngleRad
    end
    edgeAngle = math.deg(edgeAngleRad)
    lineScale.x = math.sqrt(triBase^2+triHeight^2)
    lineRot.y = edgeAngle

    if drawData.position == "x" then
        linePos.x=mapHeight/4
        linePos.z=0
    end
    if drawData.position == "-x" then
        linePos.x=-mapHeight/4
        linePos.z=0
    end
    if drawData.position == "z" then
        lineRot.y= lineRot.y-90
        linePos.x=0
        linePos.z=mapHeight/4
    end
    if drawData.position == "-z" then
        lineRot.y= lineRot.y+90
        linePos.x=0
        linePos.z=-mapHeight/4
    end
    spawnLine(linePos, lineRot, lineScale, drawData.color,  "deployZone")
end

function drawQuarter(drawData)
    local mat = getObjectFromGUID(mat_GUID)
    local linePos = {x = 0, y = deployLineYPos, z = 0}
    local lineRot = {x = 0, y = 90, z = 0}
    local lineScale = {x = 5, y = deployLineHeight, z = 0.02}
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "x" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end
    lineScale.x = (mapBase/2)-drawData.fromCenter
    linePos.z =  (lineScale.x/2) + drawData.fromCenter
    if drawData.position == "xz" then
        -- default values
    end
    if drawData.position == "x-z" or drawData.position == "-x-z" then
        linePos.z = -linePos.z
    end
    spawnLine(linePos, lineRot, lineScale, drawData.color,  "deployZone") -- short line
    lineScale.x = (mapHeight/2)-drawData.fromCenter
    linePos.z = 0
    linePos.x =  (lineScale.x/2) + drawData.fromCenter
    lineRot.y = 0
    if drawData.position == "-xz" or drawData.position == "-x-z" then
        linePos.x = -linePos.x
    end
    spawnLine(linePos, lineRot, lineScale, drawData.color, "deployZone") -- long line
end

function drawCircle(drawData, type)
    local originalCircle=getObjectFromGUID(Global.getVar("centerCircle_GUID"))
    local circleObj = originalCircle.clone({ position = {0, -5, 0}})
    if circleObj then
        circleObj.setLock(true)
        circleObj.setScale({drawData.fromCenter, deployLineHeight, drawData.fromCenter})
        circleObj.setPosition({0, deployLineYPos, 0})
        circleObj.setColorTint(drawData.color)
        circleObj.setGMNotes(type)
        circleObj.setName("")
        local blockComp = circleObj.getComponent("BoxCollider")
        blockComp.set("enabled", false)
    end
end

function drawCircleInZone(drawData, type)
    local mat = getObjectFromGUID(mat_GUID)
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "z" or drawData.position == "-z" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end
    local posX=0
    local posZ=0
    if drawData.position == "x" then
        posX=((mapHeight/2-drawData.deployFromCenter)/2)+drawData.deployFromCenter
    end
    if drawData.position == "-x" then
        posX=-((mapHeight/2-drawData.deployFromCenter)/2)+drawData.deployFromCenter
    end
    if drawData.position == "z" then
        posZ=((mapHeight/2-drawData.deployFromCenter)/2)+drawData.deployFromCenter
    end
    if drawData.position == "-z" then
        posZ=-((mapHeight/2-drawData.deployFromCenter)/2)+drawData.deployFromCenter
    end
     drawCircleNotCentered(drawData, type, posX,posZ)
end

function drawCircleNotCentered(drawData, type, centerX, centerZ)
    local originalCircle=getObjectFromGUID(Global.getVar("centerCircle_GUID"))
    local circleObj = originalCircle.clone({ position = {0, -5, 0}})
    if circleObj then
        circleObj.setLock(true)
        circleObj.setScale({drawData.fromCenter, deployLineHeight, drawData.fromCenter})
        circleObj.setPosition({centerX, deployLineYPos, centerZ})
        circleObj.setColorTint(drawData.color)
        circleObj.setGMNotes(type)
        circleObj.setName("")
        local blockComp = circleObj.getComponent("BoxCollider")
        blockComp.set("enabled", false)
    end
end

function drawCornerQuarterCircles(radius, type)
    local originalCircle=getObjectFromGUID(Global.getVar("quarterCircle_GUID"))
    local mat = getObjectFromGUID(mat_GUID)
    local lineScale = {x = 0, y = deployLineHeight, z = 0.02}
    local x = mat.getScale().x * sizeMulti * 0.5 -- long edge
    local z = mat.getScale().z * sizeMulti * 0.5 -- short edge
    local cornerLocations = {
        {position = {x, deployLineYPos, z}, rotation = {0, 270, 0}},
        {position = {x, deployLineYPos, -z}, rotation = {0, 0, 0}},
        {position = {-x, deployLineYPos, z}, rotation = {0, 180, 0}},
        {position = {-x, deployLineYPos, -z}, rotation = {0, 90, 0}},
    }

    for i, location in ipairs(cornerLocations) do
        local circleObj = originalCircle.clone()
        if circleObj then
            circleObj.setLock(true)
            circleObj.setScale({radius, deployLineHeight, radius})
            circleObj.setPosition(location.position)
            circleObj.setRotation(location.rotation)
            circleObj.setColorTint("White")
            circleObj.setGMNotes(type)
            circleObj.setName("")
            local blockComp = circleObj.getComponent("BoxCollider")
            blockComp.set("enabled", false)
        end
    end
end

function drawSteps(drawData)
    local mat = getObjectFromGUID(mat_GUID)
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "z" or drawData.position == "-z" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end

    length = mapBase / #drawData.steps
    zPos = (mapBase / 2) - (length / 2)
    for index, step in pairs(drawData.steps) do
        local xPos = 0
        if step.fromCenter then
            xPos = step.fromCenter
        else
            xPos = (mapHeight / 2) - step.fromSide
        end
        drawLineCommon(xPos, zPos, length, false, drawData.position, drawData.color)

        zPos = zPos - (length / 2)

        if index < #drawData.steps then
            -- Also draw a line connecting this step and the next.
            nextStepFromCenter = 0
            if step.fromCenter then
                nextStepFromCenter = drawData.steps[index + 1].fromCenter
            else
                nextStepFromCenter = (mapHeight / 2) - drawData.steps[index + 1].fromSide
            end
            connectorLength = nextStepFromCenter - xPos

            connectorXPos = xPos + (connectorLength / 2)
            connectorLength = math.abs(connectorLength)

            drawLineCommon(connectorXPos, zPos, connectorLength, true, drawData.position, drawData.color)
        end

        zPos = zPos - (length / 2)
    end
end

function drawLine(drawData)
    local mat = getObjectFromGUID(mat_GUID)
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "z" or drawData.position == "-z" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end
    if drawData.fromSide then
        if drawData.fromSide ~= 0 then
            drawData.fromCenter = (mapHeight / 2) - drawData.fromSide
        end
    end
    drawLineCommon(drawData.fromCenter, 0, mapBase, false, drawData.position, drawData.color)
end

function drawLineCommon(xPos, zPos, length, rotated, position, color)
    local linePos = {x = xPos, y = deployLineYPos, z = zPos}
    local lineRot = {x = 0, y = 90, z = 0}
    if rotated then
        lineRot.y = 0
    end
    local lineScale = {x = length, y = deployLineHeight, z = 0.02}
    if position == "x" then
        -- default values
    end
    if position == "-x" then
        linePos.x = -linePos.x
    end
    if position == "z" then
        lineRot.y = 90 - lineRot.y
        local oldZ = linePos.z
        linePos.z = linePos.x
        linePos.x = oldZ
    end
    if position == "-z" then
        lineRot.y = 90 - lineRot.y
        local oldZ = linePos.z
        linePos.z = -linePos.x
        linePos.x = oldZ
    end
    spawnLine(linePos, lineRot, lineScale, color, "deployZone")
end

function drawArrow(drawData)
    local mat = getObjectFromGUID(mat_GUID)
    local linePos = {x = 0, y = deployLineYPos, z = 0}
    local lineRot = {x = 0, y = 0, z = 0}
    local lineScale = {x = 5, y = deployLineHeight, z = 0.02}
    local mapBase =  mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge
    if drawData.position == "z" or drawData.position == "-z" then
        mapBase = mat.getScale().x * sizeMulti
        mapHeight = mat.getScale().z * sizeMulti
    end
    if drawData.wide ~= 0 then
        mapBase = drawData.wide *2
    end
    local triBase = (mapBase / 2) -- triangle with hypotenuse as the needed deploy line
    local triHeight = (mapHeight / 2) - drawData.fromCenter - drawData.fromEdge -- triangle with hypotenuse as the needed deploy line
    local edgeAngle = 0 -- angle of the line from the given map edge
    local edgeAngleRad = 0
    local halfTriBase = 0 -- triangle with hypotenuse that is half the line lenght
    local halfTriHeight = 0 -- triangle with hypotenuse that is half the line lenght
    lineScale.x = math.sqrt(math.pow(triBase, 2) + math.pow(triHeight, 2))
    edgeAngleRad = math.atan(triBase / triHeight)
    edgeAngle = math.deg(edgeAngleRad)
    lineRot.y = edgeAngle
    halfTriBase = (lineScale.x / 2) * math.sin(edgeAngleRad)
    halfTriHeight = (lineScale.x  / 2 ) * math.cos(edgeAngleRad)
    linePos.x = triHeight - halfTriHeight + drawData.fromCenter
    linePos.z = -1 * (triBase - halfTriBase)
    if drawData.position == "x" then
        --default values
    end
    if drawData.position == "-x" then
        linePos.z = -linePos.z
        linePos.x = -linePos.x
    end
    if drawData.position == "z" then
        local tmp = linePos.z
        linePos.z = linePos.x
        linePos.x = -tmp
        lineRot.y = 90 + lineRot.y
    end
    if drawData.position == "-z" then
        local tmp = linePos.z
        linePos.z = -linePos.x
        linePos.x = tmp
        lineRot.y = 90 + lineRot.y
    end

    spawnLine(linePos, lineRot, lineScale, drawData.color, "deployZone")
    if drawData.position == "x" or drawData.position == "-x"  then
        linePos.z = -linePos.z
        lineRot.y = -lineRot.y
    end
    if drawData.position == "z" or drawData.position == "-z"  then
        linePos.x = -linePos.x
        lineRot.y = -lineRot.y
    end
    spawnLine(linePos, lineRot, lineScale, drawData.color, "deployZone")
end

function spawnLine(linePos, lineRot, lineScale, color, type)
    local lineObj = spawnObject({ --Chip_10
        type = "BlockSquare",
        position = linePos,
        rotation = lineRot,
        scale = lineScale,
    })
    if lineObj then
        lineObj.setLock(true)
        lineObj.setGMNotes(type)
        lineObj.setColorTint(color)
        local blockComp = lineObj.getComponent("BoxCollider")
        blockComp.set("enabled", false)
    end
end

function destroyDeployZones()
    for i, obj in ipairs(getAllObjects()) do
        if obj.getGMNotes() == "deployZone" then
            obj.destroy()
        end
    end
end

function disableCollidersDeployZones()
    for i, obj in ipairs(getAllObjects()) do
        if obj.getGMNotes() == "deployZone" or obj.getGMNotes() == "areaDeny" or obj.getGMNotes() == "quarter" then
            local blockComp = obj.getComponent("BoxCollider")
            blockComp.set("enabled", false)
        end
    end

end

function placeDeploy()
    destroyDeployZones()
    local data = DeployZonesData[deploySelected]
    drawDeployZone(data)
    if data.objectivesID then
        spawnObjectives()
    end
    writeMenus()
end

function deployUp()
    deployUpDown(true)
end

function deployDown()
    deployUpDown(false)
end

function deployUpDown(upDown)
    deployOffset = 0
    objectivesOffset = 0
    deploymentPregamePlaced = true
    if DeployZonesData[deploySelected].objectivesID then
        destroyAllObjectives()
    end
    local add=1
    if not upDown then
        add=-1
    end
    deploySelected = deploySelected + add
    if deploySelected > #DeployZonesData then
        deploySelected = 1
    end
    if deploySelected < 1 then
        deploySelected = #DeployZonesData
    end
    writeMenus()
    placeDeploy()
end

function deployOffsetUp()
    deployOffsetUpDown(true)
end

function deployOffsetDown()
    deployOffsetUpDown(false)
end

function deployOffsetUpDown(upDown) -- true up, false down
    local amt = 1
    if not upDown then amt = -1 end
    deployOffset = deployOffset + amt
    if deployOffset > 25 then
        deployOffset = 25
    end
    if deployOffset < 0 then
        deployOffset = 0
    end
    writeMenus()
    setDeployHeight()
end

-- END deploy zones manager

-- ******************
-- OBJECTIVES MANAGER
-- ******************

objectivesData = {
    --Pariah Nexus missions
        {id = 101, name = "[PN] Hammer and Anvil", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fromSide", pos={10, objectivesOffset, 0}},
            {type = "fromSide", pos={-10, objectivesOffset, 0}},
            {type = "fromSide", pos={0, objectivesOffset, 6}},
            {type = "fromSide", pos={0, objectivesOffset, -6}}}},
        {id = 102, name = "[PN] Dawn of War", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fromSide", pos={10, objectivesOffset, 0}},
            {type = "fromSide", pos={-10, objectivesOffset, 0}},
            {type = "fromSide", pos={0, objectivesOffset, 6}},
            {type = "fromSide", pos={0, objectivesOffset, -6}}}},
        {id = 103, name = "[PN] Sweeping Engagement", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fromSide", pos={18, objectivesOffset, 6}},
            {type = "fromSide", pos={-18, objectivesOffset, -6}},
            {type = "fromSide", pos={10, objectivesOffset, -18}},
            {type = "fromSide", pos={-10, objectivesOffset, 18}}}},
        {id = 104, name = "[PN] Search and Destroy", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fromSide", pos={14, objectivesOffset, 10}},
            {type = "fromSide", pos={-14, objectivesOffset, -10}},
            {type = "fromSide", pos={14, objectivesOffset, -10}},
            {type = "fromSide", pos={-14, objectivesOffset, 10}}}},
        {id = 105, name = "[PN] Crucible of Battle", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fromSide", pos={14, objectivesOffset, 10}},
            {type = "fromSide", pos={-14, objectivesOffset, -10}},
            {type = "fromSide", pos={20, objectivesOffset, -8}},
            {type = "fromSide", pos={-20, objectivesOffset, 8}}}},
        {id = 106, name = "[PN] Tipping Point", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fromSide", pos={14, objectivesOffset, 10}},
            {type = "fromSide", pos={-14, objectivesOffset, -10}},
            {type = "fromSide", pos={22, objectivesOffset, -8}},
            {type = "fromSide", pos={-22, objectivesOffset, 8}}}},
    --Pariah Nexus missions with Hidden Supplies
        {id = 107, name = "[PN] Hammer and Anvil (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fromSide", pos={10, objectivesOffset, 0}},
            {type = "fromSide", pos={-10, objectivesOffset, 0}},
            {type = "fromSide", pos={0, objectivesOffset, 6}},
            {type = "fromSide", pos={0, objectivesOffset, -6}}}},
        {id = 108, name = "[PN] Dawn of War (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fromSide", pos={10, objectivesOffset, 0}},
            {type = "fromSide", pos={-10, objectivesOffset, 0}},
            {type = "fromSide", pos={0, objectivesOffset, 6}},
            {type = "fromSide", pos={0, objectivesOffset, -6}}}},
        {id = 109, name = "[PN] Sweeping Engagement (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fromSide", pos={18, objectivesOffset, 6}},
            {type = "fromSide", pos={-18, objectivesOffset, -6}},
            {type = "fromSide", pos={10, objectivesOffset, -18}},
            {type = "fromSide", pos={-10, objectivesOffset, 18}}}},
        {id = 110, name = "[PN] Search and Destroy (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fromSide", pos={14, objectivesOffset, 10}},
            {type = "fromSide", pos={-14, objectivesOffset, -10}},
            {type = "fromSide", pos={14, objectivesOffset, -10}},
            {type = "fromSide", pos={-14, objectivesOffset, 10}}}},
        {id = 111, name = "[PN] Crucible of Battle (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fromSide", pos={14, objectivesOffset, 10}},
            {type = "fromSide", pos={-14, objectivesOffset, -10}},
            {type = "fromSide", pos={20, objectivesOffset, -8}},
            {type = "fromSide", pos={-20, objectivesOffset, 8}}}},
        {id = 112, name = "[PN] Tipping Point (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fromSide", pos={14, objectivesOffset, 10}},
            {type = "fromSide", pos={-14, objectivesOffset, -10}},
            {type = "fromSide", pos={22, objectivesOffset, -8}},
            {type = "fromSide", pos={-22, objectivesOffset, 8}}}},
    --Leviathan missions
        {id = 12, name = "[L] Hammer and Anvil", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fixed", pos={20, objectivesOffset, 0}},
            {type = "fixed", pos={-20, objectivesOffset, 0}},
            {type = "fixed", pos={0, objectivesOffset, 16}},
            {type = "fixed", pos={0, objectivesOffset, -16}}}},
        {id = 13, name = "[L] Dawn of War", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fixed", pos={20, objectivesOffset, 0}},
            {type = "fixed", pos={-20, objectivesOffset, 0}},
            {type = "fixed", pos={0, objectivesOffset, 16}},
            {type = "fixed", pos={0, objectivesOffset, -16}}}},
        {id = 14, name = "[L] Sweeping Engagement", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fixed", pos={12, objectivesOffset, 16}},
            {type = "fixed", pos={20, objectivesOffset, -8}},
            {type = "fixed", pos={-12, objectivesOffset, -16}},
            {type = "fixed", pos={-20, objectivesOffset, 8}}}},
        {id = 15, name = "[L] Search and Destroy", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fixed", pos={16, objectivesOffset, 12}},
            {type = "fixed", pos={16, objectivesOffset, -12}},
            {type = "fixed", pos={-16, objectivesOffset, 12}},
            {type = "fixed", pos={-16, objectivesOffset, -12}}}},
        {id = 16, name = "[L] Crucible of Battle", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fixed", pos={10, objectivesOffset, -14}},
            {type = "fixed", pos={16, objectivesOffset, 12}},
            {type = "fixed", pos={-10, objectivesOffset, 14}},
            {type = "fixed", pos={-16, objectivesOffset, -12}}}},
    --Leviathan Missions with Hidden Supplies
        {id = 17, name = "[L] Hammer and Anvil (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fixed", pos={20, objectivesOffset, 0}},
            {type = "fixed", pos={-20, objectivesOffset, 0}},
            {type = "fixed", pos={0, objectivesOffset, 16}},
            {type = "fixed", pos={0, objectivesOffset, -16}}}},
        {id = 18, name = "[L] Dawn of War (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fixed", pos={20, objectivesOffset, 0}},
            {type = "fixed", pos={-20, objectivesOffset, 0}},
            {type = "fixed", pos={0, objectivesOffset, 16}},
            {type = "fixed", pos={0, objectivesOffset, -16}}}},
        {id = 19, name = "[L] Sweeping Engagement (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fixed", pos={12, objectivesOffset, 16}},
            {type = "fixed", pos={20, objectivesOffset, -8}},
            {type = "fixed", pos={-12, objectivesOffset, -16}},
            {type = "fixed", pos={-20, objectivesOffset, 8}}}},
        {id = 20, name = "[L] Search and Destroy (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fixed", pos={16, objectivesOffset, 12}},
            {type = "fixed", pos={16, objectivesOffset, -12}},
            {type = "fixed", pos={-16, objectivesOffset, 12}},
            {type = "fixed", pos={-16, objectivesOffset, -12}}}},
        {id = 21, name = "[L] Crucible of Battle (HS)", objectives = {
            {type = "diagonal", orientation="-xz", pos={6, objectivesOffset, 0}},
            {type = "diagonal", orientation="-xz", pos={-6, objectivesOffset, 0}},
            {type = "fixed", pos={10, objectivesOffset, -14}},
            {type = "fixed", pos={16, objectivesOffset, 12}},
            {type = "fixed", pos={-10, objectivesOffset, 14}},
            {type = "fixed", pos={-16, objectivesOffset, -12}}}},
    --Combat Patrol Missions
        {id = 22, name = "(CP) Clash of Patrols", objectives = {
            {type = "fixed", pos={10, objectivesOffset, 0}},
            {type = "fixed", pos={-10, objectivesOffset, 0}},
            {type = "fixed", pos={0, objectivesOffset, 6}},
            {type = "fixed", pos={0, objectivesOffset, -6}}}},
        {id = 23, name = "(CP) Archeotech Recovery", objectives = {
            {type = "fixed", pos={0, objectivesOffset, 0}},
            {type = "fixed", pos={16, objectivesOffset, 8}},
            {type = "fixed", pos={-16, objectivesOffset, -8}},
            {type = "fixed", pos={8, objectivesOffset, -8}},
            {type = "fixed", pos={-8, objectivesOffset, 8}}}},
        {id = 24, name = "(CP) Forward Outpost", objectives = {
            {type = "fixed", pos={16, objectivesOffset, 0}},
            {type = "fixed", pos={-16, objectivesOffset, 0}},
            {type = "fixed", pos={0, objectivesOffset, 8}},
            {type = "fixed", pos={0, objectivesOffset, -8}}}},
        {id = 25, name = "(CP) Scorched Earth", objectives = {
            {type = "fixed", pos={10, objectivesOffset, -4}},
            {type = "fixed", pos={-10, objectivesOffset, 4}},
            {type = "fixed", pos={0, objectivesOffset, 6}},
            {type = "fixed", pos={0, objectivesOffset, -6}}}},
        {id = 26, name = "(CP) Sweeping Raid", objectives = {
            {type = "fixed", pos={16, objectivesOffset, 6}},
            {type = "fixed", pos={-16, objectivesOffset, -6}},
            {type = "fixed", pos={3, objectivesOffset, -9}},
            {type = "fixed", pos={-3, objectivesOffset, 9}}}},
        {id = 27, name = "(CP) Display of Might", objectives = {
            {type = "fixed", pos={14, objectivesOffset, 0}},
            {type = "fixed", pos={-14, objectivesOffset, 0}},
            {type = "fixed", pos={0, objectivesOffset, 8}},
            {type = "fixed", pos={0, objectivesOffset, -8}}}},
        {id = 0, name = "None", objectives = {}},
    }

    objectivesOffsetMenuBtn = {
    index = 1, label = "Obj.\nHeight", click_function = "none", function_owner = self,
    position = {-menuX + 1.4*arrowOffset, 5, menuZ}, rotation = {0, 0, 0}, height = 450, width = 1000,
    font_size = 150, color = {0, 0, 0}, font_color = {1, 1, 1}
}
objectivesOffsetUpBtn = {
    index = 1, label = "+", click_function = "objectivesOffsetUp", function_owner = self,
    position = {-menuX + 1.4*arrowOffset, 5, menuZ - secondRowOffset}, rotation = {0, 0, 0}, height = 450, width = 800,
    font_size = 300, color = {0, 0, 0}, font_color = {1, 1, 1}
}
objectivesOffsetDownBtn = {
    index = 1, label = "-", click_function = "objectivesOffsetDown", function_owner = self,
    position = {-menuX + 1.4*arrowOffset, 5, menuZ + secondRowOffset}, rotation = {0, 0, 0}, height = 450, width = 800,
    font_size = 300, color = {0, 0, 0}, font_color = {1, 1, 1}
}

defaultObjectivesHeight=1.0

function spawnObjectives()
    destroyAllObjectives()
    if deploySelected < #DeployZonesData and DeployZonesData[deploySelected].objectivesID then
        for id, objectiveSet in ipairs(objectivesData) do
            if objectiveSet.id == DeployZonesData[deploySelected].objectivesID then
                local spawned = nil
                local pos={}
                local template = getObjectFromGUID(Global.getVar("templateObjective_GUID"))
                for i, objective in ipairs(objectiveSet.objectives) do
                    pos={objective.pos[1], objective.pos[2], objective.pos[3]}
                    if objectivesOffset == nil then pos[2] = 1 else pos[2] = defaultObjectivesHeight + objectivesOffset end
                    if objective.type == "fixed" then
                        -- no change to pos
                    end
                    if objective.type == "fromSide" then
                        -- The X and Z values in pos are relative. A positive value is distance from
                        -- one edge and a negative value is distance from the other. The value 0 is
                        -- special and is actually absolute.
                        local mapBase = mat.getScale().z * sizeMulti --short edge
                        local mapHeight = mat.getScale().x * sizeMulti --long edge
                        if pos[1] > 0 then
                            pos[1] = (mapHeight / 2) - pos[1]
                        elseif pos[1] < 0 then
                            pos[1] = ((mapHeight / 2) + pos[1]) * -1
                        end
                        if pos[3] > 0 then
                            pos[3] = (mapBase / 2) - pos[3]
                        elseif pos[3] < 0 then
                            pos[3] = ((mapBase / 2) + pos[3]) * -1
                        end
                    end
                    if objective.type == "diagonal" then
                        pos=calcDiagonalPos(objective.orientation, pos[1], pos[2])
                    end
                    spawned = template.clone({ position = pos })
                    spawned.setGMNotes("objective")
                    spawned.setPosition(pos)
                    spawned.setRotation({0,270,180})
                    spawned.setLock(true)
                end
                break
            end
        end
    end
end

function calcDiagonalPos(orientation, relPosOnDiagonal, posY)
    local posX = 0
    local posZ = 0
    local mat = getObjectFromGUID(mat_GUID)
    local mapBase = mat.getScale().z * sizeMulti --short edge
    local mapHeight = mat.getScale().x * sizeMulti --long edge


    local edgeAngle = 0 -- angle of the line from the given map edge
    local edgeAngleRad = 0
    local halfTriBase = 0 -- triangle with hypotenuse that is half the line lenght
    local halfTriHeight = 0 -- triangle with hypotenuse that is half the line lenght

    edgeAngleRad = math.atan(mapBase / mapHeight)
    edgeAngle = math.deg(edgeAngleRad)

    posX=relPosOnDiagonal * math.cos(edgeAngleRad)
    posZ=relPosOnDiagonal * math.sin(edgeAngleRad)
    if orientation == "xz" then
        -- default values
    end
    if orientation == "x-z" then
        posZ=-posZ
    end
    if orientation == "-xz" then
        posX=-posX
    end
    if orientation == "-x-z" then
        posX=-posX
        posZ=-posZ
    end

    return {posX,posY,posZ}
end

function destroyAllObjectives()
    for i, obj in ipairs(getAllObjects()) do
        if obj.getGMNotes() == "objective" then
            obj.destroy()
        end
    end
end

function setObjectivesHeight()
    local pos = {0,0,0}
    local found_GUID = {}
    for i, obj in ipairs(getAllObjects()) do
        if obj.getGMNotes() == "objective" then
            table.insert(found_GUID, #found_GUID+1, obj.getGUID())
        end
    end
    local found= nil
    for j, guid in ipairs(found_GUID) do
        found=getObjectFromGUID(guid)
        pos = found.getPosition()
        found.setPosition({pos[1], defaultObjectivesHeight+ objectivesOffset, pos[3]})
    end
end

function objectivesOffsetUp()
    objectivesOffsetUpDown(true)
end

function objectivesOffsetDown()
    objectivesOffsetUpDown(false)
end

function objectivesOffsetUpDown(upDown) -- true up, false down
    local amt = 0.2
    if not upDown then amt = -0.2 end
    objectivesOffset = objectivesOffset + amt
    if objectivesOffset > 25 then
        objectivesOffset = 25
    end
    if objectivesOffset < 0 then
        objectivesOffset = 0
    end
    writeMenus()
    setObjectivesHeight()
end

-- END objectives manager

-- ***************
-- MISSION MANAGER
-- ***************

-- Why is there a mission manager here, but there's also a file "missionManager.ttslua"? They do indeed
-- have similar roles; the code here handles the parts that are single-instance, while the other file
-- handles the parts that are per-player. So, for example, when "Play Leviathan" is clicked, the code
-- here fetches the deployment/primary/mission cards, while the per-player mission managers fetch the
-- secondary cards.

packSelected = nil
missionPackData = nil

selectLeviathanBtn = {
    label = "Play\nLeviathan",
    click_function = "selectLeviathan",
    function_owner = self,
    position = {-2, 5, -16.5},
    rotation = {0, 0, 0},
    height = 700,
    width = 1500,
    font_size = 200,
    color = {1, 1, 1},
    font_color = {0, 0, 0},
}
selectPariahNexusBtn = {
    label = "Play\nPariah Nexus",
    click_function = "selectPariahNexus",
    function_owner = self,
    position = {2, 5, -16.5},
    rotation = {0, 0, 0},
    height = 700,
    width = 1500,
    font_size = 200,
    color = {1, 1, 1},
    font_color = {0, 0, 0},
}

selectedMission = 0
canChangeMission = true
missionHeaderBtn = {
    label = "M I S S I O N   S E L E C T I O N",
    click_function = "none",
    function_owner = self,
    position = {9.25, 5, -17.1},
    rotation = {0, 0, 0},
    height = 250,
    width = 4000,
    font_size = 200,
    color = {1, 1, 1},
    font_color = {0, 0, 0},
}
randomiseMissionBtn = {
    label = "Fully\nRandom",
    click_function = "randomiseMission",
    function_owner = self,
    position = {5.85, 5, -16.2},
    rotation = {0, 0, 0},
    height = 550,
    width = 750,
    font_size = 160,
    color = {1, 1, 1},
    font_color = {0, 0, 0}
}
randomTournamentMissionBtn = {
    label = "Random\nGW",
    click_function = "randomTournamentMission",
    function_owner = self,
    position = {12.65, 5, -16.2},
    rotation = {0, 0, 0},
    height = 550,
    width = 750,
    font_size = 160,
    color = {1, 1, 1},
    font_color = {0, 0, 0}
}
missionSelectionDownBtn = {
    label = "<-",
    click_function = "missionSelectionDown",
    function_owner = self,
    position = {7.55, 5, -16.2},
    rotation = {0, 0, 0},
    height = 550,
    width = 750,
    font_size = 320,
    color = {1, 1, 1},
    font_color = {0, 0, 0}
}
missionSelectionUpBtn = {
    label = "->",
    click_function = "missionSelectionUp",
    function_owner = self,
    position = {10.95, 5, -16.2},
    rotation = {0, 0, 0},
    height = 550,
    width = 750,
    font_size = 320,
    color = {1, 1, 1},
    font_color = {0, 0, 0}
}
missionSelectionDispBtn = {
    label = "?",
    click_function = "none",
    function_owner = self,
    position = {9.25, 5, -16.2},
    rotation = {0, 0, 0},
    height = 550,
    width = 750,
    font_size = 320,
    color = {1, 1, 1},
    font_color = {0, 0, 0}
}

function selectLeviathan()
    selectMissionPack(MISSION_PACK_LEVIATHAN)
end

function selectPariahNexus()
    selectMissionPack(MISSION_PACK_PARIAH_NEXUS)
end

function selectMissionPack(packIndex)
    packSelected = packIndex
    Global.call("setMissionPack", {pack = packSelected})

    redMissionManager = getObjectFromGUID(Global.getVar("redMissionManager_GUID"))
    redMissionManager.call("packSelected", {pack = packSelected})
    blueMissionManager = getObjectFromGUID(Global.getVar("blueMissionManager_GUID"))
    blueMissionManager.call("packSelected", {pack = packSelected})

    missionPackData = Global.getTable("missionPackData")[packSelected]
    deploymentDeck = getObjectFromGUID(missionPackData.deploymentDeck_GUID)
    missionDeck = getObjectFromGUID(missionPackData.missionDeck_GUID)
    primaryDeck = getObjectFromGUID(missionPackData.primaryDeck_GUID)
    gambitDeck = getObjectFromGUID(missionPackData.gambitDeck_GUID)

    deploymentDeck.setPosition({85, 0.94, 11})
    deploymentDeck.locked = false
    deploymentDeck.tooltip = true
    deploymentDeck.interactable = true
    missionDeck.setPosition({85, 0.94, 8.3})
    missionDeck.locked = false
    missionDeck.tooltip = true
    missionDeck.interactable = true
    primaryDeck.setPosition({85, 0.94, 5.6})
    primaryDeck.locked = false
    primaryDeck.tooltip = true
    primaryDeck.interactable = true
    gambitDeck.setPosition({85, 0.94, 2.9})
    gambitDeck.locked = false
    gambitDeck.tooltip = true
    gambitDeck.interactable = true

    writeMenus()
end

function missionSelectionDown()
    if canChangeMission then
        selectedMission = selectedMission - 1
        if selectedMission <= 0 then selectedMission = #missionPackData.tournamentMissions end
        updateMission()
    end
end

function missionSelectionUp()
    if canChangeMission then
        selectedMission = selectedMission + 1
        if selectedMission > #missionPackData.tournamentMissions then selectedMission = 1 end
        updateMission()
    end
end

function randomiseMission()
    if canChangeMission then
        selectedMission = 0
        updateMission()
    end
end

function randomTournamentMission()
    if canChangeMission then
        selectedMission = math.random(#missionPackData.tournamentMissions)
        updateMission()
    end
end

function updateMission()
    canChangeMission = false
    Global.call("moveAllFromZoneToDeck", {zone = "deployment", deck = "deployment"})
    Global.call("moveAllFromZoneToDeck", {zone = "mission", deck = "mission"})
    Global.call("moveAllFromZoneToDeck", {zone = "primary", deck = "primary"})

    if selectedMission == 0 then
        missionSelectionDispBtn.label = "?"
        Global.call("moveOneFromDeckToZone", {deck = "deployment", zone = "deployment"})
        Global.call("moveOneFromDeckToZone", {deck = "mission", zone = "mission"})
        Global.call("moveOneFromDeckToZone", {deck = "primary", zone = "primary"})
    else
        mission = missionPackData.tournamentMissions[selectedMission]
        missionSelectionDispBtn.label = mission.name
        Global.call("moveOneFromDeckToZone", {deck = "deployment", zone = "deployment", card = mission.deployment})
        Global.call("moveOneFromDeckToZone", {deck = "mission", zone = "mission", card = mission.mission})
        Global.call("moveOneFromDeckToZone", {deck = "primary", zone = "primary", card = mission.primary})
    end
    writeMenus()

    Wait.time(function() canChangeMission = true end, 0.3)
end

-- END MISSION MANAGER

-- ************
-- GAME MANAGER
-- ************

simulation = false -- is used to test in single player
redFirstLbl = "R  e  d    p l a y e r    f i r s t\n(click to toggle)"
blueFirstLbl = "B l u e    p l a y e r    f i r s t\n(click to toggle)"
inGame = false
gameTurnCounter = nil
armyMover = ""
first = "Red"
currentTurn = "Red"
cpEveryTurn = true

-- track if player has gained CP so far this battle round
-- true if a CP has been gained, else false
redCpIncrementTracker = false
blueCpIncrementTracker = false

phases = {"Command", "Movement", "Shooting", "Charge", "Fight"}
currentPhase = 1
startBtn = {
    index = 1, label = "S T A R T  G A M E", click_function = "startGame", function_owner = self,
    position = {0, 5, - 1}, rotation = {0, 0, 0}, height = 750, width = 5000,
    font_size = 500, color = {0, 0.6, 0}, font_color = {1, 1, 1}
}
firstPlayerBtn = {
    index = 1, label = redFirstLbl, click_function = "togglePlyr", function_owner = self,
    position = {0, 5, 1}, rotation = {0, 0, 0}, height = 750, width = 5000,
    font_size = 300, color = {1, 0, 0}, font_color = {1, 1, 1}
}
nextPhaseLbl = "P A S S\nT U R N"
nextPhaseBtn = {
    index = 1, label = nextPhaseLbl, tooltip = "Left click - Next phase\nRight click - Skip to next turn", click_function = "nextPhase", function_owner = self,
    position = {0, 5, 0}, rotation = {0, 0, 0}, height = 1500, width = 5000,
    font_size = 600, color = {1, 0, 0}, font_color = {1, 1, 1}
}
IncrementRedCpBtn = {
    index = 1, label = "Gain a CP", tooltip = "Increment Red CP counter\nWill only increment once per Round", click_function = "incrementRedCp", function_owner = self,
    position = {-46.2, 5, -3.75}, rotation = {0, 0, 0}, height = 1650, width = 3000,
    font_size = 600, color = {1, 0, 0}, font_color = {1, 1, 1}
}
IncrementBlueCpBtn = {
    index = 1, label = "Gain a CP", tooltip = "Increment Blue CP counter\nWill only increment once per Round", click_function = "incrementBlueCp", function_owner = self,
    position = {46.2, 5, -3.75}, rotation = {0, 0, 0}, height = 1650, width = 3000,
    font_size = 600, color = {0, 0, 1}, font_color = {1, 1, 1}
}

notePadTxt = "This is the Forty Thousand Collection 'FTC' gaming template for Warhammer 40k, version 2.0+, competitive fork. Only Grand Tournament play is supported.\n\nPlease raise issues at https://github.com/ThePants999/tts-comp-ftc-base-lua-scripts/issues.\n\nInstructions can be found in the Notebook.\n\nSearch for FTC or BCB Map Additive Load on the workshop for maps to load!\n\n\nJoin the TTS 40K Discord server: https://discord.gg/2ST7xyWgEa"

quartersPlaced = false
quartersLblOpen = "Hide\nTable Quarters"
quartersLblClosed = "Show\nTable Quarters"
quartersBtn = {
    label = quartersLblClosed, click_function = "showHideQuarters", function_owner = self,
    position = {menuX - 9, 5, menuZ }, rotation = {0, 0, 0}, height = 1500, width = 2600,
    font_size = 300, color = {1, 1, 1}, font_color = {0, 0, 0}
}
areaPlaced = false
areaLblOpen = "Hide\nArea Denial"
areaLblClosed = "Show\nArea Denial"
areaBtn = {
    label = areaLblClosed, click_function = "showHideAreaDeny", function_owner = self,
    position = {menuX - 3, 5, menuZ }, rotation = {0, 0, 0}, height = 1500, width = 2600,
    font_size = 300, color = {1, 1, 1}, font_color = {0, 0, 0}
}
engagePlaced = false
engageLblOpen = "Hide\nLeviathan\nEngage"
engageLblClosed = "Show\nLeviathan\nEngage"
engageBtn = {
    label = engageLblClosed, click_function = "showHideEngage", function_owner = self,
    position = {menuX + 3, 5, menuZ}, rotation = {0, 0, 0}, height = 1500, width = 2600,
    font_size = 300, color = {1, 1, 1}, font_color = {0, 0, 0}
}
stratreservesPlaced = false
stratreservesLblOpen = "Hide\nStrat Reserves"
stratreservesLblClosed = "Show\nStrat Reserves"
stratreservesBtn = {
    label = stratreservesLblClosed, click_function = "showHideStratreserves", function_owner = self,
    position = {menuX + 9, 5, menuZ}, rotation = {0, 0, 0}, height = 1500, width = 2600,
    font_size = 300, color = {1, 1, 1}, font_color = {0, 0, 0}
}
deploymentIngamePlaced = false
deployIngameLblOpen = "Hide\ndeployment\nzones"
deployIngameLblClosed = "Show\ndeployment\nzones"
deployIngameBtn = {
    index = 1, label = deployIngameLblClosed, click_function = "showHideIngameDeployment", function_owner = self,
    position = {menuX + 27, 5, menuZ}, rotation = {0, 0, 0}, height = 1500, width = 2600,
    font_size = 300, color = {1, 1, 1}, font_color = {0, 0, 0}
}
investigatePlaced = false
investigateLblOpen = "Hide\nInvestigate Signals"
investigateLblClosed = "Show\nInvestigate Signals"
investigateBtn = {
    label = investigateLblClosed, click_function = "showHideInvestigateSignals", function_owner = self,
    position = {menuX + 15, 5, menuZ}, rotation = {0, 0, 0}, height = 1500, width = 2600,
    font_size = 300, color = {1, 1, 1}, font_color = {0, 0, 0}
}
containmentPlaced = false
containmentLblOpen = "Hide\nContainment"
containmentLblClosed = "Show\nContainment"
containmentBtn = {
    label = containmentLblClosed, click_function = "showHideContainment", function_owner = self,
    position = {menuX + 21, 5, menuZ}, rotation = {0, 0, 0}, height = 1500, width = 2600,
    font_size = 300, color = {1, 1, 1}, font_color = {0, 0, 0}
}
position = {menuX, 5, menuZ}

function writeMenus()
    self.clearButtons()
    if not sizeConfirmed then
        writeSizeMenu()
        writeDeployMenu()
    else
        if inGame == false then
            writeStartMenu()
            writeDeployMenu()
        else
            writeIngameMenu()
        end
    end

end

function writeStartMenu()
    if gameMode ~= "game" then return end
    self.createButton(startBtn)
    self.createButton(firstPlayerBtn)
end

function writeDeployMenu()
    deployBtn.label = DeployZonesData[deploySelected].name
    self.createButton(deployBtn)
    self.createButton(deployUpBtn)
    self.createButton(deployDownBtn)
    self.createButton(deployOffsetMenuBtn)
    self.createButton(deployOffsetUpBtn)
    self.createButton(deployOffsetDownBtn)
    self.createButton(deployMenuBtn)
    self.createButton(objectivesOffsetDownBtn)
    self.createButton(objectivesOffsetUpBtn)
    self.createButton(objectivesOffsetMenuBtn)

    self.createButton(areaBtn)
    self.createButton(quartersBtn)
    self.createButton(engageBtn)
    self.createButton(stratreservesBtn)
    self.createButton(investigateBtn)
    self.createButton(containmentBtn)

    if gameMode == "game" then
        if not packSelected then
            self.createButton(selectLeviathanBtn)
            self.createButton(selectPariahNexusBtn)
        else
            self.createButton(missionHeaderBtn)
            self.createButton(randomiseMissionBtn)
            self.createButton(randomTournamentMissionBtn)
            self.createButton(missionSelectionDownBtn)
            self.createButton(missionSelectionUpBtn)
            self.createButton(missionSelectionDispBtn)
        end
    end
end

function writeIngameMenu()
    self.createButton(areaBtn)
    self.createButton(engageBtn)
    self.createButton(quartersBtn)
    self.createButton(stratreservesBtn)
    self.createButton(investigateBtn)
    self.createButton(containmentBtn)
    self.createButton(deployIngameBtn)
    self.createButton(IncrementRedCpBtn)
    self.createButton(IncrementBlueCpBtn)
    self.createButton(deployOffsetMenuBtn)
    self.createButton(deployOffsetUpBtn)
    self.createButton(deployOffsetDownBtn)
    self.createButton(objectivesOffsetDownBtn)
    self.createButton(objectivesOffsetUpBtn)
    self.createButton(objectivesOffsetMenuBtn)

    nextPhaseBtn.color = currentTurn
    local visibleTo=nextPhaseBtn.color
    Global.UI.setAttribute("passTurn", "visibility", visibleTo)
    Global.UI.setAttribute("passTurnBtn", "color", nextPhaseBtn.color)
    nextPhaseBtn.label = phases[currentPhase].."\nNEXT PHASE"
    if currentPhase == #phases then
        nextPhaseBtn.label = phases[currentPhase].."\nPASS TURN"
    end
    Global.UI.setValue("passTurnTxt", nextPhaseBtn.label)
    self.createButton(nextPhaseBtn)
end

function startGame(obj, player, alt)
    if alt then
        simulation = true
    end
    local playerList = Player.getPlayers()
    local numberOfPlayers = 0
    for i, p in ipairs(playerList) do
        numberOfPlayers = numberOfPlayers + 1
    end

    if Player["Red"].seated == false or Player["Blue"].seated == false then
        broadcastToAll("Must have both players seated", {1, 0, 0})
        if simulation == false then
            return
        end
    end
    Global.call("recordPlayers")
    inGame = true

    local scoresheet = getObjectFromGUID(Global.getVar("scoresheet_GUID"))
    scoresheet.call("startGame")

    startCustomTurns()
    destroyDeployZones()
    deploymentIngamePlaced = false
    areaPlaced = false
    broadcastToAll(phases[currentPhase].." phase", "Yellow")
    resetActivationTokens()
    Notes.setNotes("")
    writeMenus()
    simulation = false
end

function resetActivationTokens()
    for i, obj in ipairs(getAllObjects()) do
        if obj.getVar("BCBtype") == "ActivationToken" then
            obj.call("resetAlredyActed")
        end
    end
end

function newRoundStarted()
    redCpIncrementTracker = false
    blueCpIncrementTracker = false
end

function incrementRedCp(params)
    if not inGame then return end
    if not redCpIncrementTracker then
        redCpIncrementTracker = true
        redCpCounter.Counter.increment()
    else
        broadcastToAll("Red has already gained a CP this battle round!", "Yellow")
    end
end

function incrementBlueCp(params)
    if not inGame then return end
    if not blueCpIncrementTracker then
        blueCpIncrementTracker = true
        blueCpCounter.Counter.increment()
    else
        broadcastToAll("Blue has already gained a CP this battle round!", "Yellow")
    end
end

function nextPhase(obj, player_color_click, alt_click)
    resetActivationTokens()
    if alt_click then
        passTurn(obj, player_color_click, alt_click)
        return
    end
    currentPhase = currentPhase + 1
    if currentPhase > #phases then
        currentPhase = 1
        passTurn(obj, player_color_click, alt_click)
    end
    broadcastToAll(phases[currentPhase].." phase", "Yellow")
    writeMenus()
end

function passTurn(obj, player_color_click, alt_click)
    if player_color_click ~= currentTurn then

        if simulation then
            broadcastToAll("INTRUDER", "Pink")
        else
            return
        end

    end
    currentPhase = 1
    if currentTurn == "Red" then
        currentTurn = "Blue" -- it has to be the opposite
        blueTurnCounter.call("increaseSelf")
        blueCpCounter.Counter.increment()
        if cpEveryTurn then
          redCpCounter.Counter.increment()
          Wait.time(function() broadcastToAll("Both CPs incremented!", "White") end, 0.3)
        else
          Wait.time(function() broadcastToAll("Blue CPs incremented!", "Blue") end, 0.3)
        end
    else
        currentTurn = "Red"
        redTurnCounter.call("increaseSelf")
        redCpCounter.Counter.increment()
        if cpEveryTurn then
          blueCpCounter.Counter.increment()
          Wait.time(function() broadcastToAll("Both CPs incremented!", "White") end, 0.3)
        else
          Wait.time(function() broadcastToAll("Red CPs incremented!", "Red") end, 0.3)
        end
    end
    if simulation then
        broadcastToAll("It's "..currentTurn.." turn", currentTurn)
    else
        if Player[currentTurn].steam_name then
            broadcastToAll("It's "..Player[currentTurn].steam_name.." turn", currentTurn)
        else
            broadcastToAll("It's "..currentTurn.." turn", currentTurn)
        end
    end
    writeMenus()
end

function startCustomTurns()
    if first == "Red" then
        currentTurn = "Blue" -- it has to be the opposite
    else
        currentTurn = "Red"
    end
    passTurn(self, currentTurn, false)
end

function startBuiltinTurns()
    if first == "Red" then
        Turns.order = {"Red", "Blue"}
    else
        Turns.order = {"Blue", "Red"}
    end
    Turns.pass_turns = true
    Turns.enable = false
    Turns.enable = true
end

function togglePlyr()
    self.clearButtons()
    if first == "Red" then
        firstPlayerBtn.label = blueFirstLbl
        firstPlayerBtn.color = {0, 0, 1}
        first = "Blue"
    else
        firstPlayerBtn.label = redFirstLbl
        firstPlayerBtn.color = {1, 0, 0}
        first = "Red"
    end
    writeMenus()
end

function showHideIngameDeployment()
    if deploymentIngamePlaced == false then -- place
        deployIngameBtn.label = deployIngameLblOpen
        if deploySelected < #DeployZonesData then
            drawDeployZone(DeployZonesData[deploySelected])
        end
        deploymentIngamePlaced = true
    else -- recall
        deployIngameBtn.label = deployIngameLblClosed
        if deploySelected < #DeployZonesData then
            destroyDeployZones()
        end
        deploymentIngamePlaced = false
    end
    writeMenus()
end

function showHideAreaDeny()
    if areaPlaced == false then -- place
        areaBtn.label = areaLblOpen
        drawCircle({color="White", fromCenter=6}, "areaDeny")
        drawCircle({color="White", fromCenter=3}, "areaDeny")
        areaPlaced = true
    else -- recall
        areaBtn.label = areaLblClosed
        for i, obj in ipairs(getAllObjects()) do
            if obj.getGMNotes() == "areaDeny" then
                obj.destroy()
            end
        end
        areaPlaced = false
    end
    writeMenus()
end

function showHideEngage()
    if not engagePlaced then
        engageBtn.label = engageLblOpen

        local mat = getObjectFromGUID(mat_GUID)
        local lineScale = {x = 0, y = deployLineHeight, z = 0.02}
        local mapBase = mat.getScale().z * sizeMulti -- short edge
        local mapHeight = mat.getScale().x * sizeMulti -- long edge

        -- Engage lines
        xLength = (mapHeight / 2) - 3
        zLength = (mapBase / 2) - 3
        lineScale.x = xLength
        --(linePos, lineRot, lineScale, color, orientation, type)
        spawnLine({(xLength / 2) + 3, deployLineHeight, -3}, {0, 0, 0}, lineScale, "White", "engage")
        spawnLine({(xLength / 2) + 3, deployLineHeight, 3}, {0, 0, 0}, lineScale, "White", "engage")
        spawnLine({((xLength / 2) * -1) - 3, deployLineHeight, -3}, {0, 0, 0}, lineScale, "White", "engage")
        spawnLine({((xLength / 2) * -1) - 3, deployLineHeight, 3}, {0, 0, 0}, lineScale, "White", "engage")
        lineScale.x = zLength
        spawnLine({-3, deployLineHeight, (zLength / 2) + 3}, {0, 90, 0}, lineScale, "White", "engage")
        spawnLine({3, deployLineHeight, (zLength / 2) + 3}, {0, 90, 0}, lineScale, "White", "engage")
        spawnLine({-3, deployLineHeight, (((zLength / 2) * -1) - 3)}, {0, 90, 0}, lineScale, "White", "engage")
        spawnLine({3, deployLineHeight, (((zLength / 2) * -1) - 3)}, {0, 90, 0}, lineScale, "White", "engage")

        engagePlaced = true
    else
        engageBtn.label = engageLblClosed

        for i, obj in ipairs(getAllObjects()) do
            if obj.getGMNotes() == "engage" then
                obj.destroy()
            end
        end
        engagePlaced = false
    end

    writeMenus()
end

function showHideQuarters()
    if quartersPlaced == false then -- place
        quartersBtn.label = quartersLblOpen
        local mat = getObjectFromGUID(mat_GUID)
        local lineScale = {x = 5, y = deployLineHeight, z = 0.02}
        local mapBase = mat.getScale().z * sizeMulti --short edge
        local mapHeight = mat.getScale().x * sizeMulti --long edge
        --(linePos, lineRot, lineScale, color, orientation, type)
        lineScale.x = mapHeight
        spawnLine({0, deployLineHeight, 0}, {0,0,0}, lineScale, "White", "quarter")
        lineScale.x = mapBase
        spawnLine({0, deployLineHeight ,0}, {0,90,0}, lineScale, "White", "quarter")
        quartersPlaced = true
    else -- recall
        quartersBtn.label = quartersLblClosed
        for i, obj in ipairs(getAllObjects()) do
            if obj.getGMNotes() == "quarter" then
                obj.destroy()
            end
        end
        quartersPlaced = false
    end
    writeMenus()
end

function showHideStratreserves()
    if not stratreservesPlaced then
        stratreservesBtn.label = stratreservesLblOpen

        local playerSides = "None"

        -- check that a deployment zone has been specified to determine which sides to colour
        if DeployZonesData[deploySelected].name ~= "None" then
            local deployZoneLayout = DeployZonesData[deploySelected].draw[1]
            playerSides = "long"

            -- check if deployment has short sides as Player Sides
            if deployZoneLayout["type"] == "line" and deployZoneLayout["position"] == "x" then
                playerSides = "short"
            elseif deployZoneLayout["type"] == "triangle" then
                playerSides = "short"
            end
        end

        local mat = getObjectFromGUID(mat_GUID)
        local lineScale = {x = 0, y = deployLineHeight, z = 0.02}
        local mapBase = mat.getScale().z * sizeMulti -- short edge
        local mapHeight = mat.getScale().x * sizeMulti -- long edge

        -- Strategic reserves lines
        --(linePos, lineRot, lineScale, color, orientation, type)
        lineScale.x = mapHeight

        if playerSides == "long" then
            spawnLine({0, deployLineHeight, (mapBase / 2) - 6}, {0, 0, 0}, lineScale, "Red", "stratreserves")
            spawnLine({0, deployLineHeight, -((mapBase / 2) - 6)}, {0, 0, 0}, lineScale, "Teal", "stratreserves")
        else
            spawnLine({0, deployLineHeight, (mapBase / 2) - 6}, {0, 0, 0}, lineScale, "White", "stratreserves")
            spawnLine({0, deployLineHeight, -((mapBase / 2) - 6)}, {0, 0, 0}, lineScale, "White", "stratreserves")
        end
        lineScale.x = mapBase

        if playerSides == "short" then
            spawnLine({(mapHeight / 2) - 6, deployLineHeight, 0}, {0, 90, 0}, lineScale, "Red", "stratreserves")
            spawnLine({-((mapHeight / 2) - 6), deployLineHeight, 0}, {0, 90, 0}, lineScale, "Teal", "stratreserves")
        else
            spawnLine({(mapHeight / 2) - 6, deployLineHeight, 0}, {0, 90, 0}, lineScale, "White", "stratreserves")
            spawnLine({-((mapHeight / 2) - 6), deployLineHeight, 0}, {0, 90, 0}, lineScale, "White", "stratreserves")
        end

        stratreservesPlaced = true
    else
        stratreservesBtn.label = stratreservesLblClosed

        for i, obj in ipairs(getAllObjects()) do
            if obj.getGMNotes() == "stratreserves" then
                obj.destroy()
            end
        end
        stratreservesPlaced = false
    end

    writeMenus()
end

function showHideInvestigateSignals()
    if not investigatePlaced then
        investigateBtn.label = investigateLblOpen
        drawCornerQuarterCircles(9, "investigate")
        investigatePlaced = true
    else
        investigateBtn.label = investigateLblClosed

        for i, obj in ipairs(getAllObjects()) do
            if obj.getGMNotes() == "investigate" then
                obj.destroy()
            end
        end
        investigatePlaced = false
    end

    writeMenus()
end

function showHideContainment()
    if not containmentPlaced then
        containmentBtn.label = containmentLblOpen

        local mat = getObjectFromGUID(mat_GUID)
        local mapBase = mat.getScale().z * sizeMulti -- short edge
        local mapHeight = mat.getScale().x * sizeMulti -- long edge
        local lineScale = {x = mapHeight, y = deployLineHeight, z = 0.02}

        spawnLine({0, deployLineHeight, (mapBase / 2) - 9}, {0, 0, 0}, lineScale, "White", "containment")
        spawnLine({0, deployLineHeight, -((mapBase / 2) - 9)}, {0, 0, 0}, lineScale, "White", "containment")
        lineScale.x = mapBase
        spawnLine({(mapHeight / 2) - 9, deployLineHeight, 0}, {0, 90, 0}, lineScale, "White", "containment")
        spawnLine({-((mapHeight / 2) - 9), deployLineHeight, 0}, {0, 90, 0}, lineScale, "White", "containment")

        containmentPlaced = true
    else
        containmentBtn.label = containmentLblClosed

        for i, obj in ipairs(getAllObjects()) do
            if obj.getGMNotes() == "containment" then
                obj.destroy()
            end
        end
        containmentPlaced = false
    end

    writeMenus()
end

function recallAll()
    destroyAllObjectives()
    destroyDeployZones()
end

function none()
end