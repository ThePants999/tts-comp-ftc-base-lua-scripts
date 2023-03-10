-- FTC-GUID: a84ed2,c57d70
function none()
end
Yoffset=0.1

clearAllDiceBtn={
    label="Clear mat\n(right click)", click_function="clearDiceAll", function_owner=self,
    position={-4.6, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=400,
    font_size=60, color={0,0,0}, font_color={1,1,1}
}

rollAllLabel = "Roll all dice"
rollAllTooltip = "Left-click to roll all dice. Right-click to switch to selecting dice."
selectAllLabel = "Select all dice"
selectAllTooltip = "Left-click to select all dice. Right-click to switch to rolling dice."
rollOrSelectAllBtn={
    label=rollAllLabel, tooltip=rollAllTooltip, click_function="RollOrSelectDice", function_owner=self,
    position={-3.5, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=520,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}

orderedRollLabel = "Ordered roll"
orderedRollTooltip = "Roll all dice, and display them in the order they're rolled in rather than by results."
orderedRollBtn={
    label=orderedRollLabel, tooltip=orderedRollTooltip, click_function="RollDiceOrdered", function_owner=self,
    position={-2.4, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=520,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}
orderedRollGroup2Label = "In 2s"
orderedRollGroup2Tooltip = "Roll all dice, and display them in the order they're rolled in rather than by results, grouped into 2s."
orderedRollGroup2Btn={
    label=orderedRollGroup2Label, tooltip=orderedRollGroup2Tooltip, click_function="RollDiceOrderedGroup2", function_owner=self,
    position={-1.6, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=250,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}
orderedRollGroup3Label = "In 3s"
orderedRollGroup3Tooltip = "Roll all dice, and display them in the order they're rolled in rather than by results, grouped into 3s."
orderedRollGroup3Btn={
    label=orderedRollGroup3Label, tooltip=orderedRollGroup3Tooltip, click_function="RollDiceOrderedGroup3", function_owner=self,
    position={-1.1, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=250,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}

add1d6Btn={
    label="+ 1d6", click_function="spawnDice1", function_owner=self,
    position={-0.5, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=250,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}
add2d6Btn={
    label="+ 2d6", click_function="spawnDice2", function_owner=self,
    position={0.0, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=250,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}
add5d6Btn={
    label="+ 5d6", click_function="spawnDice5", function_owner=self,
    position={0.5, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=250,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}
add10d6Btn={
    label="+ 10d6", click_function="spawnDice10", function_owner=self,
    position={1.0, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=250,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}
add25d6Btn={
    label="+ 25d6", click_function="spawnDice25", function_owner=self,
    position={1.5, Yoffset ,-0.87}, rotation={0,0,0}, height=50, width=250,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}

colorBtnDimension=150
colorBtnOffset=2.0
color1Btn={
    label="", click_function="modifyMenu1", function_owner=self,
    position={colorBtnOffset, Yoffset ,-0.87}, rotation={0,0,0}, height=colorBtnDimension, width=colorBtnDimension,
    font_size=60, color="Red", font_color={0,0,0}
}
color2Btn={
    label="", click_function="modifyMenu2", function_owner=self,
    position={colorBtnOffset+0.35, Yoffset ,-0.87}, rotation={0,0,0}, height=colorBtnDimension, width=colorBtnDimension,
    font_size=60, color="Blue", font_color={0,0,0}
}
color3Btn={
    label="", click_function="modifyMenu3", function_owner=self,
    position={colorBtnOffset+0.35*2, Yoffset ,-0.87}, rotation={0,0,0}, height=colorBtnDimension, width=colorBtnDimension,
    font_size=60, color="Black", font_color={0,0,0}
}
color4Btn={
    label="", click_function="modifyMenu4", function_owner=self,
    position={colorBtnOffset+0.35*3, Yoffset ,-0.87}, rotation={0,0,0}, height=colorBtnDimension, width=colorBtnDimension,
    font_size=60, color="Green", font_color={0,0,0}
}
pipColorBtn=
{
  index=17, label="White", click_function="swapPipColor", function_owner=self,
  position={colorBtnOffset + 0.35 * 4 + 0.1, Yoffset, -0.87}, rotation={0, 0, 0}, height=50, width=250,
  font_size=60, color="White", font_color="Black"
}
customDiceBtn={
    label="Custom Dice", click_function="customDice", function_owner=self,
    position={colorBtnOffset+0.35*9, Yoffset ,-0.85}, rotation={0,0,0}, height=50, width=420,
    font_size=60, color={1,1,1}, font_color={0,0,0}
}

clearDiceBtnIncrement=0.28
clearDiceBtnLabel="Del\n"
clearDiceBtntooltip="LMB Delete this row\nRMB Delete this row and lowers/uppers"
clearDiceBtn={
    label=clearDiceBtnLabel, tooltip=clearDiceBtntooltip, click_function="filledInLater", function_owner=self,
    position={-5.8, Yoffset ,-0.85}, rotation={0,0,0}, height=1000, width=1300, scale={0.1,0.1,0.1},
    font_size=350, color="Black", font_color="Red"
}

rollOrSelectDiceBtn={
    label="filled in later", tooltip="filled in later", click_function="filledInLater", function_owner=self,
    position={-5.45, Yoffset ,-0.85}, rotation={0,0,0}, height=1000, width=1300, scale={0.1,0.1,0.1},
    font_size=350, color="White", font_color={0,0,0}
}

lowerUpper=true
oneTimeUpper=true
lowerSign=" (-)"
upperSign=" (+)"
lowerUpperBtn={
    label="RMB\n- / +", tooltip="Changes to upper for the next click", click_function="toggleLowerUpper", function_owner=self,
    position={-5.62, Yoffset ,1.1}, rotation={0,0,0}, height=1000, width=2800, scale={0.1,0.1,0.1},
    font_size=500, color="White", font_color={0,0,0}
}

warningLbl="NO FAST REPETITIONS"
warningLbl=""
warningBtn={
    label=warningLbl, click_function="modifyMenu4", function_owner=self,
    position={-1.75, Yoffset ,-0.67}, rotation={0,0,0}, height=0, width=0,
    font_size=50, color="White", font_color="Red"
}

rollMode = true
selectedColor = "White"
diceType = "Die_6_Rounded"
customDiceImage = nil

rollerGUID = Global.getVar("redDiceRoller_GUID")
if self.guid == Global.getVar("blueDiceMat_GUID") then
    rollerGUID = Global.getVar("blueDiceRoller_GUID")
end
roller = getObjectFromGUID(rollerGUID)

function getDice()
    local dice={}
    local ownPos = self.getPosition()
    local ownRotation = self.getRotation()['x']
    local ownScale = self.getScale()['x']
    local BoundsNormalized = self.getBounds()
    local Rotation = self.getRotation()
    local leftBound = BoundsNormalized.center.x-(BoundsNormalized.size.x/2)
    local rightBound = BoundsNormalized.center.x+(BoundsNormalized.size.x/2)
    local upperBound = BoundsNormalized.center.z+(BoundsNormalized.size.z/2)
    local lowerBound = BoundsNormalized.center.z-(BoundsNormalized.size.z/2)
    local yupperBound = BoundsNormalized.center.y+(BoundsNormalized.size.y/2)+3
    local ylowerBound =  BoundsNormalized.center.y-(BoundsNormalized.size.y/2)

    for _, obj in pairs(getAllObjects()) do
        -- Fetch resting dices
        if obj != nil and obj.tag == 'Dice' and obj.resting then
            -- Only use objects inside the zone
            local objPos = obj.getPosition()
            if objPos['x'] > leftBound and objPos['x'] < rightBound and objPos['z'] > lowerBound and objPos['z'] < upperBound and objPos['y'] < yupperBound and objPos['y'] > ylowerBound then
                table.insert(dice, #dice+1, obj)
            end
        end
    end
    return dice
end

function customDice(obj, player, alt)
    found = false
    newImage = nil
    newTint = nil

    dice = getDice()
    for _, die in ipairs(dice) do
        local image = die.getCustomObject()["image"]
        if image ~= nil then
            found = true
            newTint = die.getColorTint()
            newImage = image
            printToColor("You have set a custom die!", player, "Yellow")
            break
        else
            -- We've found *a* die, but we should keep going looking for a truly
            -- custom one, and use this only if we don't find any better ones.
            found = true
            newTint = die.getColorTint()
            printToColor("You have set a custom colour!", player, "Yellow")
        end
    end

    if found then
        customDiceImage = newImage
        selectedColor = newTint
        setDiceType()
    end
end

function toggleLowerUpper()
    setLowerUpper(not lowerUpper)
end

function setLowerUpper( value )
    lowerUpper= value
    modifyBtns()
end

function modifyBtns()
    local sign=""
    for i=1, 6 do
        if lowerUpper then sign = lowerSign else sign = upperSign end
        self.editButton({ index = (16+i*2), label = clearDiceBtnLabel .. i .. sign })

        local selOrRollLabel = "Roll\n"
        if not rollMode then
            selOrRollLabel = "Sel\n"
        end
        self.editButton({ index = (17+i*2), label = selOrRollLabel .. i .. sign })
    end
end

function RollOrSelectDice(obj, player, alt)
    if not alt then
        Player[player].clearSelectedObjects()
        if rollMode then
            moveDiceToRoller( player, getDice() )
        else
            for i, die in ipairs(getDice()) do
                die.addToPlayerSelection(player)
            end
        end
    else
        rollMode = not rollMode

        if rollMode then
            self.editButton({index=3, label=rollAllLabel, tooltip=rollAllTooltip})
        else
            self.editButton({index=3, label=selectAllLabel, tooltip=selectAllTooltip})
        end
        modifyBtns()
    end
end

function RollDiceOrdered(_, player, _)
    Player[player].clearSelectedObjects()
    roller.setVar("orderedOnNextRoll", true)
    moveDiceToRoller(player, getDice())
end

function RollDiceOrderedGroup2(obj, player, alt)
    roller.setVar("groupSizeOnNextRoll", 2)
    RollDiceOrdered(obj, player, alt)
end

function RollDiceOrderedGroup3(obj, player, alt)
    roller.setVar("groupSizeOnNextRoll", 3)
    RollDiceOrdered(obj, player, alt)
end

function RollOrSelectDeleteDice1(obj, color, alt)
    SelectDeleteDiceX("Sel", 1, alt, lowerUpper, color) -- action, n, selectOthers, upLow, color
end
function RollOrSelectDeleteDice2(obj, color, alt)
    SelectDeleteDiceX("Sel", 2, alt, lowerUpper, color)
end
function RollOrSelectDeleteDice3(obj, color, alt)
    SelectDeleteDiceX("Sel", 3, alt, lowerUpper, color)
end
function RollOrSelectDeleteDice4(obj, color, alt)
    SelectDeleteDiceX("Sel", 4, alt, lowerUpper, color)
end
function RollOrSelectDeleteDice5(obj, color, alt)
    SelectDeleteDiceX("Sel", 5, alt, lowerUpper, color)
end
function RollOrSelectDeleteDice6(obj, color, alt)
    SelectDeleteDiceX("Sel", 6, alt, lowerUpper, color)
end

function SelectDeleteDiceX(action, n, selectOthers, lowUp, color)
    Player[color].clearSelectedObjects()
    selDel = true
    if action == "Del" then selDel = false end
    local counter = {0,0,0,0,0,0}
    local numberName = {"ones", "twos", "threes", "fours", "fives", "sixes"}
    local text = Player[color].steam_name .. " deleted "
    local somethingToPrint = false

    for i, die in ipairs(getDice()) do
        if die.getValue() == n or (selectOthers and lowUp and die.getValue()< n)  or (selectOthers and not lowUp and die.getValue()> n) then
            if selDel then
                die.addToPlayerSelection(color)
            else
                die.destroy()
                counter[die.getValue()]=counter[die.getValue()]+1
            end

        end
    end

    for i, val in ipairs(counter) do
        if val > 0 then
            text = text.." \u{00B7} " .. counter[i] .. " " .. numberName[i]
            somethingToPrint = true
        end
    end
    if somethingToPrint then printToAll(text , "Yellow") end
    if oneTimeUpper then setLowerUpper( true ) end

    if selDel and rollMode then
        moveDiceToRoller(color, Player[color].getSelectedObjects())
    end
end

function moveDiceToRoller(color, dice)
    roller.call("setPlayerColor", {color=color})

    for _, die in ipairs(dice) do
        roller.call("setLastHolder", {obj=die, color=color})
        roller.putObject(die)
    end
end

function clearDiceAll(obj, color, alt)
    if not alt then printToColor("Use right click!", color, "Orange") return end
    clearDiceX(6, true, color)
end

function clearDice1(obj, color, alt)
    SelectDeleteDiceX("Del", 1, alt, lowerUpper, color) -- action, n, selectOthers, upLow, color
end
function clearDice2(obj, color, alt)
    SelectDeleteDiceX("Del", 2, alt, lowerUpper, color)
end
function clearDice3(obj, color, alt)
    SelectDeleteDiceX("Del", 3, alt, lowerUpper, color)
end
function clearDice4(obj, color, alt)
    SelectDeleteDiceX("Del", 4, alt, lowerUpper, color)
end
function clearDice5(obj, color, alt)
    SelectDeleteDiceX("Del", 5, alt, lowerUpper, color)
end
function clearDice6(obj, color, alt)
    SelectDeleteDiceX("Del", 6, alt, lowerUpper, color)
end


function clearDiceX(n, deleteLower, color)
    local counter={0,0,0,0,0,0}
    local numberName={"ones", "twos", "threes", "fours", "fives", "sixes"}
    local text = Player[color].steam_name .. " deleted "
    local somethingToPrint=false
    for i, die in ipairs(getDice()) do
        if die.getValue() == n or (deleteLower and die.getValue()< n) then
            die.destroy()
            counter[die.getValue()]=counter[die.getValue()]+1
        end
    end
    for i, val in ipairs(counter) do
        if val > 0 then
            text=text.." \u{00B7} "..counter[i].." "..numberName[i]
            somethingToPrint=true
        end
    end
    if somethingToPrint then printToAll(text , "Yellow") end
end

function spawnDice1(obj, player, alt)
    spawnDice(1,player)
end
function spawnDice2(obj, player, alt)
    spawnDice(2,player)
end
function spawnDice5(obj, player, alt)
    spawnDice(5,player)
end
function spawnDice10(obj, player, alt)
    spawnDice(10,player)
end
function spawnDice25(obj, player, alt)
    spawnDice(25,player)
end

function spawnDice(n,player)
    local currentTime = os.time()
    local disableTime=0.6
    --if n>9 then disableTime=disableTime+0.3 end
    if currentTime-lastClick<disableTime then
        printToColor("Wait a bit!", player, "Yellow")
        return
    end
    lastClick=currentTime
    local offset=#getDice()
    if offset+n>128 then printToColor("Dice limit reached!", player, "Orange")  end
    local grid=0
    local row=0
    local col=0
    for i=1, offset do
        col=col+1
        if col>4 then
            col=0
            row= row+1
            if row > 4 then
                row=0
                grid=grid+1
            end
        end
    end

    if offset+n>128 then n=128-offset end
    for i=1, n do
    local die=spawnObject({
        type              = diceType,
        position          = self.positionToWorld({4-grid*1.5-col*0.25,0.5,-0.3+row*0.25}),
        rotation          = self.getRotation() + Vector(0.0, 180.0, 0.0),
        })
        col=col+1
        if col>4 then
            col=0
            row= row+1
            if row > 4 then
                row=0
                grid=grid+1
            end
        end

        if customDiceImage ~= nil then
            die.setCustomObject({
                image = customDiceImage,
                type = 1
            })
        end

        if selectedColor ~= nil then
            die.setColorTint(selectedColor)
        end
    end
end

function onload()
    lastClick=os.time()
    defaultFontSize=500
    fontSize=defaultFontSize
    lineCount=0
    --defaultDivisionLabel="|\n|\n|\n|\n|\n|\n|"
    defaultDivisionLabel="|\n|"
    --defaultDivisionLabel="|"
    self.createButton({
        label="---", click_function="none", function_owner=Global,
        position={-6.4,0.11,0.01}, rotation={0,0,0}, height=0, width=0, font_size=fontSize,
        font_color={1, 1, 1},
        scale={0.25, 0.25, 0.25},
		alignment=2
    })
    self.createButton({
        label="", click_function="none", function_owner=Global,
        position={0.75,0.11,0.01}, rotation={0,0,0}, height=0, width=0, font_size=500,
        font_color={1, 1, 1},
        --scale={0.25, 0.25, 0.25},
        scale={0.25,2,1},
		alignment=2
    })

	if self.getDescription() == '' then
		setDefaultState()
	end

    emptyText = ' '
	data2 = JSON.decode(self.getDescription())
	Wait.time(checkDice, data2.Update_Frequency*1,-1)

    self.createButton(clearAllDiceBtn)
    self.createButton(rollOrSelectAllBtn)
    self.createButton(orderedRollBtn)
    self.createButton(orderedRollGroup2Btn)
    self.createButton(orderedRollGroup3Btn)
    self.createButton(add1d6Btn)
    self.createButton(add2d6Btn)
    self.createButton(add5d6Btn)
    self.createButton(add10d6Btn)
    self.createButton(add25d6Btn)
    self.createButton(color1Btn)
    self.createButton(color2Btn)
    self.createButton(color3Btn)
    self.createButton(color4Btn)
    self.createButton(warningBtn)
    self.createButton(pipColorBtn)
    local sign=""
    for i=1, 6 do
        if lowerUpper then sign= lowerSign else sign=upperSign end
        clearDiceBtn.position[3]=clearDiceBtn.position[3]+clearDiceBtnIncrement
        clearDiceBtn.click_function="clearDice"..i
        clearDiceBtn.label=clearDiceBtnLabel..i..sign
        self.createButton(clearDiceBtn)

        rollOrSelectDiceBtn.position[3] = rollOrSelectDiceBtn.position[3] + clearDiceBtnIncrement
        rollOrSelectDiceBtn.label = "Roll\n" .. i .. sign
        rollOrSelectDiceBtn.tooltip = "LMB Re-rolls this row\nRMB Re-rolls this row and lowers/uppers"
        rollOrSelectDiceBtn.click_function = "RollOrSelectDeleteDice" .. i
        self.createButton(rollOrSelectDiceBtn)
    end
    self.createButton(lowerUpperBtn)
    self.createButton(customDiceBtn)
    if self.getPosition().z < 0 then selectedColor="Blue" else selectedColor="Red" end modifyMenu(selectedColor)
end

function modifyMenu1()
    modifyMenu("Red")
end
function modifyMenu2()
    modifyMenu("Blue")
end
function modifyMenu3()
    modifyMenu("Black")
end
function modifyMenu4()
    modifyMenu("Green")
end
function modifyMenu(color)
    customDiceImage = nil
    selectedColor = color
    setDiceType()
    self.editButton({index=7, color=color})
    self.editButton({index=8, color=color})
    self.editButton({index=9, color=color})
    self.editButton({index=10, color=color})
    self.editButton({index=11, color=color})
end

function setDiceType()
    if customDiceImage ~= nil then
        diceType = "Custom_Dice"
    elseif pipColorBtn.color == "White" then
        diceType = "Die_6_Rounded"
    else
        diceType = "Die_6"
    end
end

function setDefaultState()
	self.setDescription(JSON.encode_pretty({
		Cumulative = 'no',Update_Frequency = '0.2'
	}))
end

function checkDice ()
	--Reset description on null
	data = JSON.decode(self.getDescription())
	if data==nil then
		setDefaultState()
		data = JSON.decode(self.getDescription())
		printToAll('Warning - invalid description. Restored default configuration.', {0.8,0.5,0})
	end

    -- If the zone is moving, wait
    if not self.resting then
        return
    end

    local ownPos = self.getPosition()
    local ownRotation = self.getRotation()['x']
    local ownScale = self.getScale()['x']
    local BoundsNormalized = self.getBounds()
    local Rotation = self.getRotation()
    local leftBound = BoundsNormalized.center.x-(BoundsNormalized.size.x/2)
    local rightBound = BoundsNormalized.center.x+(BoundsNormalized.size.x/2)
    local upperBound = BoundsNormalized.center.z+(BoundsNormalized.size.z/2)
    local lowerBound = BoundsNormalized.center.z-(BoundsNormalized.size.z/2)
    local yupperBound = BoundsNormalized.center.y+(BoundsNormalized.size.y/2)+3
    local ylowerBound =  BoundsNormalized.center.y-(BoundsNormalized.size.y/2)

    local valueToCounter = {}
    local valuesToSort = {}
	totaldice=0
    diceSum = 0

    -- Iterate all objects in the zone
    for _, obj in pairs(getAllObjects()) do
        -- Fetch resting dices
        if obj != nil and obj.tag == 'Dice' and obj.resting then
            -- Only use objects inside the zone
            local objPos = obj.getPosition()
            if objPos['x'] > leftBound and objPos['x'] < rightBound and objPos['z'] > lowerBound and objPos['z'] < upperBound and objPos['y'] < yupperBound and objPos['y'] > ylowerBound then
                local value = obj.getValue()
                if value ~= nil then
                    local counter = valueToCounter[value]
                    -- First occurrence of this value
                    if counter == nil then
                        counter = 0
                        valuesToSort[#valuesToSort + 1] = value
                    end
                    -- Increase the occurrence of this value
                    diceSum = diceSum + value
                    counter = counter + 1
                    totaldice=totaldice+1
                    valueToCounter[value] = counter
                end
            end
        end
    end

    -- Process the tracked values, sorted and build the lines to display
	local textLines = {}
    lineCount=0
	if data.Cumulative == 'yes' then
		table.sort(valuesToSort)
		for i=1,12 do
			if valueToCounter[i]==nil then
				valueToCounter[i]=0
			end
		end
		valueToCounter[11]=valueToCounter[12]+valueToCounter[11]
		valueToCounter[10]=valueToCounter[11]+valueToCounter[10]
		valueToCounter[9]=valueToCounter[10]+valueToCounter[9]
		valueToCounter[8]=valueToCounter[9]+valueToCounter[8]
		valueToCounter[7]=valueToCounter[8]+valueToCounter[7]
		valueToCounter[6]=valueToCounter[7]+valueToCounter[6]
		valueToCounter[5]=valueToCounter[6]+valueToCounter[5]
		valueToCounter[4]=valueToCounter[5]+valueToCounter[4]
		valueToCounter[3]=valueToCounter[4]+valueToCounter[3]
		valueToCounter[2]=valueToCounter[3]+valueToCounter[2]
		for index, value in ipairs(valuesToSort) do
			local counter = valueToCounter[value]
			local xxx = ''
			if value == 1 then
				xxx = "'s: "
			else
				xxx = "+: "
			end
			local line = value .. xxx .. counter
			textLines[#textLines + 1] = line
            lineCount=lineCount+1
		end
	else
		table.sort(valuesToSort)
		for index, value in ipairs(valuesToSort) do
			local counter = valueToCounter[value]
			local line = '#' .. value .. ': ' .. counter
			textLines[#textLines + 1] = line
            lineCount=lineCount+1
		end
	end
    if lineCount < 6 then
        for i = lineCount+1, 6 do
            textLines[#textLines + 1] = " "
        end
    end
    -- Display the text
    local text = table.concat(textLines, '\n')
    if text == '' then
        -- Suppress the default text 'Type Here'
        text = emptyText
    end
    if totaldice==0
    then
        totaltext = ' '
    else
        totaltext='\n' .. totaldice .. " \u{2211} " .. diceSum

    end
    if lineCount>6 then
        fontSize=defaultFontSize-((lineCount-6)*37)
        divisionLabel=defaultDivisionLabel

    else
        fontSize=defaultFontSize
        divisionLabel=""
    end
    self.editButton({index=0, label=text..totaltext, font_size=fontSize})
    self.editButton({index=1, label=divisionLabel})
end

function swapPipColor()
    customDiceImage = nil
    if pipColorBtn.color == "Black" then
        pipColorBtn.label = "White"
        pipColorBtn.color = "White"
        pipColorBtn.font_color = "Black"
    else
        pipColorBtn.label = "Black"
        pipColorBtn.color = "Black"
        pipColorBtn.font_color = "White"
    end

    setDiceType()

    self.editButton(pipColorBtn)
end