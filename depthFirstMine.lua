--TODO--
--EVERYTHING WORKS SO FAR EXCEPT FOR THE COAL FUNCTION. I MAY INCRESE THE BLOCKS LEFT TO TRAVEL LIMIT AS 200 IS TOO SHORT. 1000 MAYBE?
-- FIX COAL GETTING FUNCTION--
--CONDUCT EXTENSIVE TESTING--
--REAP THE REWARDS--

local function detectOre()
    -- Check ore in front
    local success, block = turtle.inspect()
    if success then
        local oreList = {"minecraft:deepslate_diamond_ore", "minecraft:deepslate_redstone_ore", "minecraft:deepslate_lapis_ore", "minecraft:deepslate_gold_ore", "minecraft:deepslate_iron_ore", "minecraft:deesplate_emerald_ore", "minecraft:deesplate_coal_ore"}
        for _, ore in ipairs(oreList) do
            if block.name == ore then
                return true
            end
        end
    end
    return false
end

local function detectGrass()
    local success, block = turtle.inspect()
    if success then
            if block.name == "minecraft:grass_block" then
                return true
            end
        end
    return false
end

local function detectOreUp()
    success, block = turtle.inspectUp()
    if success then
        local oreList = {"minecraft:deepslate_diamond_ore", "minecraft:deepslate_redstone_ore", "minecraft:deepslate_lapis_ore", "minecraft:deepslate_gold_ore", "minecraft:deepslate_iron_ore", "minecraft:deesplate_emerald_ore", "minecraft:deesplate_coal_ore"}
        for _, ore in ipairs(oreList) do
            if block.name == ore then
                return true
            end
        end
    end
end

local function detectOreDown()
    success, block = turtle.inspectDown()
    if success then
        local oreList = {"minecraft:deepslate_diamond_ore", "minecraft:deepslate_redstone_ore", "minecraft:deepslate_lapis_ore", "minecraft:deepslate_gold_ore", "minecraft:deepslate_iron_ore", "minecraft:deesplate_emerald_ore", "minecraft:deesplate_coal_ore"}
        for _, ore in ipairs(oreList) do
            if block.name == ore then
                return true
            end
        end
    end
end

local function isdimon(itemDetail)
    if itemDetail.name == "minecraft:diamond" then
        return true
    end
    return false
end
local function goBack()
    for slot = 1, 16 do
        local itemDetail = turtle.getItemDetail(slot)
        if itemDetail and itemDetail.name == "minecraft:diamond" and turtle.getItemCount(slot) == 64 then
            return true
        end
    end
    return false
end


local function mineVein()
    if detectOre() then
      turtle.dig()
      turtle.forward()
      mineVein()
      turtle.back()
    end
    turtle.turnLeft()
    if detectOre() then
        turtle.dig()
        turtle.forward()
        mineVein()
        turtle.back()
    end
    turtle.turnRight()
    turtle.turnRight()
    if detectOre() then
        turtle.dig()
        turtle.forward()
        mineVein()
        turtle.back()
  end
    turtle.turnLeft()
    if detectOreUp() then 
        turtle.digUp()
        turtle.up()
        mineVein()
        turtle.down()
    end
    if detectOreDown() then 
        turtle.digDown()
        turtle.down()
        mineVein()
        turtle.up()
    end

    if goBack() then 
        return true

    end
    return false
end


local function bedrock()
    -- Check ore in front
    local success, block = turtle.inspectDown()
    if success then
        local oreList = {"minecraft:bedrock"}
        for _, ore in ipairs(oreList) do
            if block.name == ore then
                return true
            end
        end
    end
    return false
end

local function digdown()
    while bedrock() == false do
        turtle.digDown()
        turtle.down()
    end
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.dig()
    turtle.forward()
    turtle.dig()
    turtle.forward()
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop()
    end

end

local function detectCoal()
    -- Check ore in front
    local success, block = turtle.inspect()
    if success then
        local oreList = {"minecraft:coal_ore"}
        for _, ore in ipairs(oreList) do
            if block.name == ore then
                return true
            end
        end
    end
    return false
end

local function detectCoalUp()
    success, block = turtle.inspectUp()
    if success then
        local oreList = {"minecraft:coal_ore"}
        for _, ore in ipairs(oreList) do
            if block.name == ore then
                return true
            end
        end
    end
    return false
end
local function mineCoal()
    if detectCoal() then
      turtle.dig()
      turtle.forward()
      mineCoal()
      turtle.back()
    end
    turtle.turnLeft()
    if detectCoal() then
        turtle.dig()
        turtle.forward()
        mineCoal()
        turtle.back()
    end
    turtle.turnRight()
    turtle.turnRight()
    if detectCoal() then
        turtle.dig()
        turtle.forward()
        mineCoal()
        turtle.back()
  end
    turtle.turnLeft()
    if detectCoalUp() then 
        turtle.digUp()
        turtle.up()
        mineCoal()
        turtle.down()
    end
    for i=1, 16 do
        turtle.select(i)
        if turtle.refuel(0) then
            local count = turtle.getItemCount(i)
            turtle.refuel(count)
        end

    end

end
local goodies = {"minecraft:diamond", "minecraft:redstone", "minecraft:dye", "minecraft:raw_gold", "minecraft:raw_iron", "minecraft:emerald", "minecraft:coal"}

-- Function to check if an item is an ore
local function isOre(itemDetail)
    for _, oreItem in ipairs(goodies) do
        if itemDetail.name == oreItem then
            return true
        end
    end
    return false
end


-- Function to drop non-ore items
local function dropNonOres()
    for slot = 1, 16 do -- Assuming the turtle has 16 slots
        local itemDetail = turtle.getItemDetail(slot)
        if itemDetail then
            if not isOre(itemDetail) then
                turtle.select(slot)
                turtle.drop()
            end
        end
    end
end
local blocks = 0
local function mine()
blocks = blocks + 1
turtle.dig()
turtle.forward()
if detectOre() or detectOreUp() == true then
    turtle.select(1)
    dropNonOres()
    mineVein()
    
end
if turtle.getFuelLevel() < 200 then
    print("WEE WOO WEE WOO")
    for i=1, 100 do
        turtle.digUp()
        turtle.up()
    end
    while detectCoal() or detectCoalUp() == false do
        turtle.dig()
        turtle.forward()
    end
    mineCoal()
    for i=1, 100 do
        turtle.digDown()
        turtle.down()
    end
    end


end
function Main()
    digdown()
    while mineVein() == false do 
    mine()
    end
    turtle.turnRight()
    turtle.turnRight()
    for i= 0, blocks do 
        turtle.forward()
    end
    turtle.forward()
    while detectGrass() == false do
        turtle.up()
    end
    turtle.up()
end

Main()
