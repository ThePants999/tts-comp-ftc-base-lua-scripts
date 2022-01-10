-- FTC-GUID: 8b7aa6
keepForTerrainEditor = true

btnHeight=1200
btnWidth=btnHeight*2
btnX=-42
btnZ=168
Yoffset=-2
armyPlaced=false
scaleBtn={5,5,5}

allowChangeMat=true
grayArmyMat="https://steamuserimages-a.akamaihd.net/ugc/961990768472081339/7E16C361F995197F4EC82D0F907A6B4303ED9F63/"
redArmyMat="https://steamuserimages-a.akamaihd.net/ugc/961990768472083953/C1D522D6DC97A3B3D0072F99EA6B7AC77E2F44B5/"
blueArmyMat="https://steamuserimages-a.akamaihd.net/ugc/961990768472085230/0056C98888BE7FE9EFDDD6E6F47319A8254CABB2/"

redBtn={
    index=1, label="Place for\nRED", click_function="click_Red", function_owner=self,
    position={btnX,-Yoffset,btnZ}, rotation={0,0,0}, height=btnHeight, width=btnWidth, scale=scaleBtn,
    font_size=btnHeight*0.4, color={0.8,0,0}, font_color={0,0,0}
}

blueBtn={
    index=1, label="Place for\nBLUE", click_function="click_Blue", function_owner=self,
    position={-btnX,-Yoffset,btnZ}, rotation={0,0,0}, height=btnHeight, width=btnWidth, scale=scaleBtn,
    font_size=btnHeight*0.4, color={0,0.2,0.8}, font_color={1,1,1}
}

deleteBtn={
    index=1, label="Delete\nARMY", click_function="click_Delete", function_owner=self,
    position={0,-Yoffset,btnZ+33}, rotation={0,0,0}, height=btnHeight, width=btnWidth, scale=scaleBtn,
    font_size=btnHeight*0.4, color={0.5,0.5,0.5}, font_color={0.8,0,0}
}

armyZoneData={
        type = "ScriptingTrigger",
        position          = {x=-78, y=0, z=0},
        rotation          = {x=0, y=0, z=0},
        scale             = {x=48, y=80, z=53.5},
        sound             = false,
        snap_to_grid      = false,
    }

destinationZoneData={
        type = "ScriptingTrigger",
        position          = {x=-78, y=0, z=0},
        rotation          = {x=0, y=0, z=0},
        scale             = {x=48, y=80, z=53.5},
        sound             = false,
        snap_to_grid      = false,
    }




function onLoad(saved_data)
    --self.setPosition({83.00, 0.00, 0.00})
    --self.setPosition({77.00, Yoffset, 0.00})
    --self.interactable=false
    --writeMenu()
end

function armyLoaded()
    writeMenu()
end

function writeMenu()
    self.createButton(redBtn)
    self.createButton(blueBtn)
    self.createButton(deleteBtn)
end

function click_Red(obj, color, alt)
    if color ~= "Red" then
        return
    end
    --armyZoneData.callback_function="placeToRed"
    armyZone=spawnObject(armyZoneData)
    Wait.frames(placeToRed, 3)
end

function click_Blue(obj, color, alt)
    if color ~= "Blue" then
        return
    end
    armyZone=spawnObject(armyZoneData)
    Wait.frames(placeToBlue, 3)
end

function placeToRed()
    local newCenterCoord={0,0,74.25}
    placeTo(newCenterCoord, 90, redArmyMat)
end

function placeToBlue()
    local newCenterCoord={0,0,-74.25}
    placeTo(newCenterCoord, -90, blueArmyMat)
end

function placeTo(newCenter, rot, newImg )
    destinationZoneData.position=newCenter
    destinationZoneData.rotation.y=rot
    local destinationZone=spawnObject(destinationZoneData)
    local mat=nil
    local armyMinis=armyZone.getObjects()
    local newRot={}
    local relPos={}
    for i, mini in ipairs(armyMinis) do
        relPos=armyZone.positionToLocal(mini.getPosition())
        mini.setPosition(destinationZone.positionToWorld(relPos))
        --print(destinationZone.positionToWorld(relPos).x.." "..destinationZone.positionToWorld(relPos).y.." "..destinationZone.positionToWorld(relPos).z)
        mini.setLock(false)
        mini.measure_movement=true
        if mini.getVar("BCBtype") == "armyMat" then
            mat=mini
            mini.setLock(true)
        end
    end
    for i, mini in ipairs(armyMinis) do
            newRot={mini.getRotation().x, mini.getRotation().y+rot, mini.getRotation().z}
            mini.setRotation(newRot)
    end
    armyZone.destroy()
    destinationZone.destroy()
    if mat ~= nil and allowChangeMat then
        local custom= mat.getCustomObject()
        if custom.image == grayArmyMat then
            custom.image=newImg
            mat.setCustomObject(custom)
            mat.reload()
        end
    end
    self.clearButtons()
end




function placeToBlueOLD()
    local mat=nil
    local newImg=blueArmyMat
    local armyMinis=armyZone.getObjects()
    local newPos={}
    for i, mini in ipairs(armyMinis) do
            newPos={-mini.getPosition().z, mini.getPosition().y, mini.getPosition().x}
            mini.setPosition(newPos)
			mini.setLock(false)

            if mini.getVar("BCBtype") == "armyMat" then
                mat=mini
                mini.setLock(true)
            end
    end
    for i, mini in ipairs(armyMinis) do
            newRot={mini.getRotation().x, mini.getRotation().y-90, mini.getRotation().z}
            mini.setRotation(newRot)
    end
    armyZone.destroy()
    if mat ~= nil and allowChangeMat then
        local custom= mat.getCustomObject()
        custom.image=newImg
        mat.setCustomObject(custom)
        mat.reload()
    end

    self.clearButtons()
end

function click_Delete()
    armyZone=spawnObject(armyZoneData)
    Wait.frames(deleteArmy, 3)
end

function deleteArmy()
    local armyMinis=armyZone.getObjects()
    for i, mini in ipairs(armyMinis) do
            mini.destroy()
    end
    armyZone.destroy()
    self.clearButtons()
end