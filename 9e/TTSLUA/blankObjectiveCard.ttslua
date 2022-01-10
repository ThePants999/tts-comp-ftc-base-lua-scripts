-- FTC-GUID: d618cb

menuX = 0
menuY = 0.25
menuZ = 0
textColor = "White"
rowOffset = 1.7

function onload()
    if self.getPosition().y > 0 then
        writeMenu()
    end
end

function writeMenu()
    self.clearButtons()
    local selfScaleX= self.getScale().x
    local selfScaleY= self.getScale().y
    local selfScaleZ= self.getScale().z
    local titleBtn = {
        label="", click_function="none", function_owner=self,
        position={(menuX)/selfScaleX, (menuY)/selfScaleY , (menuZ-rowOffset)/selfScaleZ}, rotation={0,0,0}, height=0, width=0, scale={1/selfScaleX,1/selfScaleY,1/selfScaleZ},
        font_size=160, color={0,0,0}, font_color=textColor
    }

    local descBtn = {
        label="", click_function="none", function_owner=self,
        position={(menuX)/selfScaleX, (menuY)/selfScaleY , (menuZ)/selfScaleZ}, rotation={0,0,0}, height=0, width=0,  scale={1/selfScaleX,1/selfScaleY,1/selfScaleZ},
        font_size=70, color={0,0,0}, font_color=textColor
    }

    local idBtn ={
        label="", click_function = "none", function_owner=self,
        position={(menuX)/selfScaleX, (menuY)/selfScaleY , (menuZ+rowOffset+0.15)/selfScaleZ}, rotation={0,0,0}, height=0, width=0,  scale={1/selfScaleX,1/selfScaleY,1/selfScaleZ},
        font_size=60, color={0,0,0}, font_color=textColor
    }

    titleBtn.label=self.getName()
    self.createButton(titleBtn)
    descBtn.label = splittedDesc(self.getDescription(), 90)
    self.createButton(descBtn)
    idBtn.label="ID "..self.getGMNotes().."   "
    self.createButton(idBtn)
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function splittedDesc(desc, lineLenght)
    local newDesc=""
    local subTitle=" "
    local body=" "
    local lines={}
    local first = true
    for line in string.gmatch(desc, "[^\n]+") do

        if first then
            subTitle = line
            first = false
        else
            body=body.."\n"..line
        end
    end
    local tableDesc = {}
    for i=1, math.ceil(string.len(body)/lineLenght) do
        tableDesc[i]=string.sub(body, (i-1)*lineLenght, (i*lineLenght)-1)
    end
    newDesc=subTitle.."\n\n"
    for j, line in ipairs(tableDesc) do
        --print(line)
        if j ~= #tableDesc then
            newDesc=newDesc..line.."\n"
        else
            newDesc=newDesc..line
        end
    end
    return newDesc
end

function none()
end