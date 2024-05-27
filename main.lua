push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 480
VIRTUAL_HEIGHT = 270

love.window.setTitle("Legend of CS50")

function love.load()

    -- #[Resolution]
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    -- #[Fonts]
    -- Ballons font
    smallFont = love.graphics.newFont('font.ttf', 8)
    nameFont = love.graphics.newFont('font.ttf', 11)
    love.graphics.setFont(smallFont)
    -- Screens font
    screenFont = love.graphics.newFont('font.ttf', 15)
    -- Battle HUD Font
    battleFont = love.graphics.newFont('font.ttf', 13)
    --NAMES font
    hudNameFont = love.graphics.newFont('font.ttf', 16)

    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- DART SPRITES
    dartSprite1 = love.graphics.newImage("sprites/DART1.png")
    dartSprite1e2 = love.graphics.newImage("sprites/DART1-2.png")
    dartSprite2 = love.graphics.newImage("sprites/DART2.png")
    dartSprite2e2 = love.graphics.newImage("sprites/DART2-2.png")
    dartSprite3 = love.graphics.newImage("sprites/DART3.png")
    dartSprite4 = love.graphics.newImage("sprites/DART4.png")
    dartSprite5 = love.graphics.newImage("sprites/DART5.png")
    dartSprite6 = love.graphics.newImage("sprites/DART6.png")
    
    -- DAVID SPRITE
    davidSprite = love.graphics.newImage("sprites/DAVID1.png")

    -- DUCK SPRITES
    duckSprite1 = love.graphics.newImage("sprites/DUCK1.png")
    duckSprite2 = love.graphics.newImage("sprites/DUCK2.png")
    duckSprite3 = love.graphics.newImage("sprites/DUCK3.png")

    -- DOOR SPRITE
    doorSprite = love.graphics.newImage("sprites/DOOR.png")

    -- HOUSE SPRITE
    houseSprite = love.graphics.newImage("sprites/HOUSE.png")
    
    -- MOON SPRITE
    moonSprite = love.graphics.newImage("sprites/MOON.png")
    
    -- STARS SPRITE
    starsSprite = love.graphics.newImage("sprites/STAR.png")

    -- TEXT BALLOON SPRITE
    balloonSprite = love.graphics.newImage("sprites/BALLOON.png")

    -- FLOOR (+ TREE) SPRITE
    floorSprite = love.graphics.newImage("sprites/FLOOR.png")

    -- #[SOUND EFFECT]

    -- *Background Music
    -- First screen
    backgroundMusic = love.audio.newSource("sounds/beginsong.wav", "static")
    backgroundMusic:setLooping(true)
    backgroundMusic:setVolume(0.6)

    -- Transition and battle
    battleMusic = love.audio.newSource("sounds/fightsong.wav", "static")
    battleMusic:setLooping(true)
    battleMusic:setVolume(0.5)

    -- Door sound
    doorSound = love.audio.newSource("sounds/doorsound.wav", "static")

    -- Jump sound
    jumpSound = love.audio.newSource("sounds/jumpsound.wav", "static")

    -- Dart attack sound
    attackSound = love.audio.newSource("sounds/swordhit.wav", "static")
    attackSound:setVolume(0.7)

    -- Dart defense sound
    defenseSound = love.audio.newSource("sounds/swordshield.wav", "static")

    -- Duck attack sound
    duckSound = love.audio.newSource("sounds/duckhit.wav", "static")

    -- Winner sound
    winnerSound = love.audio.newSource("sounds/winnersound.wav", "static")
    
    -- Game over sound
    gameOver = love.audio.newSource("sounds/gameover.wav", "static")
    
    -- #[In-Battle]
    -- Battlestate
    battleState = {
        currentTurn = "player",
        playerActions = {"Attack", "Defense"},
        selectedAction = "1",
    }
    -- Current HP
    currentHP = {
        dart = 125,
        duck = 500
    }
      
    -- *[BATTLE GUI]
    -- HUD
    hud1 = {
        height = 25,
        width = 150,
        x = 20,
        y = 10
    }
    hud2 = {
        height = 25,
        width = 150,
        x = VIRTUAL_WIDTH / 2 + 70,
        y = 10
    }
    
    -- Menu
    hpMenu = {
        height = 70,
        width = 160,
        x = VIRTUAL_WIDTH / 2 - 35,
        y = VIRTUAL_HEIGHT - 80
    }

    menu = {
        height = 70,
        width = 80,
        x = VIRTUAL_WIDTH / 2 - 120,
        y = VIRTUAL_HEIGHT - 80
    }

    -- Menu options
    attackHud = {
        height = 25,
        width = 70,
        x = VIRTUAL_WIDTH / 2 - 115,
        y = VIRTUAL_HEIGHT - 75
    }
    
    defenseHud = {
        height = 25,
        width = 70,
        x = VIRTUAL_WIDTH / 2 - 115,
        y = VIRTUAL_HEIGHT - 40
    }
    
    hp1 = {
        height = 25,
        width = 150,
        x = VIRTUAL_WIDTH / 2 - 30,
        y = VIRTUAL_HEIGHT - 75
    }
    hp2 = {
        height = 25,
        width = 150,
        x = VIRTUAL_WIDTH / 2 - 30,
        y = VIRTUAL_HEIGHT - 40
    }
    selection = {
        height = 25,
        width = 70,
        x = VIRTUAL_WIDTH / 2 - 115,
        y = VIRTUAL_HEIGHT - 75
    }
    -- #[Characters]
    -- Dart (main character)
    dart = {}
    dart.height = 55
    dart.width = 25
    dart.x = 0
    dart.y = VIRTUAL_HEIGHT - dart.height
    dart.vx = 0
    dart.vy = 0
    dart.jumpForce = -175
    dart.gravity = 500
    dart.isGrounded = false
    dart.direction = 'right'
    dart.currentSprite = dartSprite1

    -- Dart (in-battle)
    inbDart = {}
    inbDart.height = 55
    inbDart.width = 25
    inbDart.x = VIRTUAL_WIDTH / 2 - 125
    inbDart.y = VIRTUAL_HEIGHT / 2 - 40
    inbDart.attack = 75
    inbDart.defense = 20
    inbDart.health = 125
    inbDart.currentDef = 20
    inbDart.currentSprite = dartSprite3
    inbDart.isBattling= false
    -- *[BOSS]
    -- CS50 Duck
    duck = {}
    duck.height = 80
    duck.width = 60
    duck.x = VIRTUAL_WIDTH / 2 + 25
    duck.y = VIRTUAL_HEIGHT / 2 - 100
    duck.attack = 35
    duck.defense = 20
    duck.health = 500
    duck.currentSprite = duckSprite1
    duck.isBattling = false
    
    -- *[NPC]
    -- David
    david = {}
    david.height = 60
    david.width = 30
    david.x = 230
    david.y = VIRTUAL_HEIGHT - david.height * 2 + 15
    -- Davids text balloon
    davidTextBalloon = {
        x = david.x / 2 - 15,
        y = david.y / 2 - 50,
        charName = "David:",
        text = "Hey, Dart. Let's see what's behind this door? Maybe there's something underneath the hood.",
        isVisible = false
    }

    -- #[Stage]
    -- Background
    backgroundColor = {love.math.colorFromBytes(2, 1, 28)}
    -- Floor
    floor = {}
    floor.width = VIRTUAL_WIDTH
    floor.height = 30
    floor.x = 0
    floor.y = -200
    -- Moon
    moon = {}
    moon.size = 25
    moon.x = 0
    moon.y = -10
    -- Stars
    stars = {}
    numStars = 30
    -- Door
    door = {}
    door.width = 50
    door.height = 70
    door.x = VIRTUAL_WIDTH / 2 + 100
    door.y = VIRTUAL_HEIGHT / 2 + 18
    -- House
    house = {}
    house.width = 140
    house.height = 120
    house.x = VIRTUAL_WIDTH / 2 - 10
    house.y = VIRTUAL_HEIGHT / 2 - 130

    local function randomFloat(min, max)
        return min + (max - min) * love.math.random()
    end

    for i = 1, numStars do
        
        local x = love.math.random(0, VIRTUAL_WIDTH)
        local y = love.math.random(0, VIRTUAL_HEIGHT - floor.height - 40)
        local radius = randomFloat(0.2, 1)

        stars[i] = {x = x, y = y, radius = radius}
        
    end
   
    -- INITIALIZATING OBJECTS
    objects = {   
        -- ##Characters graphics
        -- Dart graphics
        {z = 3, draw = function()
        end},
        
        -- *NPCs graphics (David, Carter and Doug)
        -- David
        {z = 2, draw = function()
        love.graphics.draw(davidSprite, david.x, david.y)
        end},

        -- ##Stage graphics
        -- Floor
        {z = 0, draw = function()
        love.graphics.draw(floorSprite, floor.x, floor.y)
        end},
        -- Moon
        {z = 0, draw = function()
        love.graphics.draw(moonSprite, moon.x, moon.y)
        end},
        -- Door
        {z = 2, draw = function()
        love.graphics.draw(doorSprite, door.x, door.y)
        end}, 
        -- House
        {z = 1, draw = function()
        love.graphics.draw(houseSprite, house.x, house.y)
        end}
    }
    
    battleObjects = {
        
        -- Menu Bar
        {z = 1, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", menu.x, menu.y, menu.width, menu.height)
        end},
        
        -- Menu Bar
        {z = 1, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", hpMenu.x, hpMenu.y, hpMenu.width, hpMenu.height)
        end},
        
        -- Menu options
        -- Dart HP HUD
        {z = 2, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", hp1.x, hp1.y, hp1.width, hp1.height)
        end},

        -- Duck HP HUD
        {z = 2, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", hp2.x, hp2.y, hp2.width, hp2.height)
        end},
        
        -- Attack HUD
        {z = 2, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", attackHud.x, attackHud.y, attackHud.width, attackHud.height)
        end},

        -- Defense HUD
        {z = 2, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", defenseHud.x, defenseHud.y, defenseHud.width, defenseHud.height)
        end},

        -- Selection HUD
        {z = 2, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", selection.x, selection.y, selection.width, selection.height)
        end},
        
        -- UPPER HUD

        {z = 3, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", hud1.x, hud1.y, hud1.width, hud1.height)
        end},                       
        
        {z = 3, draw = function()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", hud2.x, hud2.y, hud2.width, hud2.height)
        end}, 
        
        -- In battle Objects 
        -- Dart
        {z = 1, draw = function()
        love.graphics.draw(inbDart.currentSprite, inbDart.x, inbDart.y)
        end},                       
        
        -- Duck
        {z = 1, draw = function()
        love.graphics.draw(duck.currentSprite, duck.x, duck.y)
        end},   
   }
    
    -- Main screen
    currentScreen = "main"
    winnerScreen = "winnerScreen"
    loserScreen = "loserScreen"

    -- Transition Timer
    transitionTimer = 0
    transitionDuration = 2
end

attackPerformed = false
waitingForDuck = false
attackTimer = 0
attackDelay = 1
spriteTimer = 0
spriteDelay = 1.5
textTime = 0

function love.update(dt)
    
    if currentScreen == "main" then
        if not backgroundMusic:isPlaying() then
            backgroundMusic:play()
        end
        
        local speed = 100
        local isMoving = false
        
        -- Dart movement
        if love.keyboard.isDown('right') then
            dart.x = dart.x + speed * dt
            dart.currentSprite = dartSprite2
            dart.direction = 'right'
            isMoving = true
        elseif love.keyboard.isDown('left') then
            dart.x = dart.x - speed * dt
            dart.currentSprite = dartSprite2e2
            dart.direction = 'left'
            isMoving = true
        else
            isMoving = false
        end
        
        if not isMoving then
            dart.vx = 0 
            if dart.direction == 'right' then
                dart.currentSprite = dartSprite1
                isMoving = false
            elseif dart.direction == 'left' then
                dart.currentSprite = dartSprite1e2
                
            end
        end
        -- Jump
        if love.keyboard.isDown('space') and dart.isGrounded then
            dart.vy = dart.jumpForce
            dart.isGrounded = false
            jumpSound:play()
        end
        -- Apply gravity
        dart.vy = dart.vy + dart.gravity * dt
        dart.y = dart.y + dart.vy * dt
        
        -- Border Collision and Ground Check
        if dart.y + dart.height >= (VIRTUAL_HEIGHT - 30) then
            dart.y = (VIRTUAL_HEIGHT - 30) - dart.height
            dart.vy = 0
            dart.isGrounded = true
        end
        
        if dart.x < -38 then
            dart.x = -38
        elseif dart.x + 60 > VIRTUAL_WIDTH then
            dart.x = VIRTUAL_WIDTH - 60
        end

        -- Calculate distance between Dart and David
        local distance = math.sqrt((david.x - dart.x)^2 + (david.y - dart.y)^2)

        -- Define the threshold distance for displaying text balloon
        local thresholdDistance = 50

        -- Check if Dart is close to David
        if distance < thresholdDistance then
            davidTextBalloon.isVisible = true
        else
            davidTextBalloon.isVisible = false
        end
        
        -- When Dart interacts with the door, set the flag
        local doorThresholdDistance = 37
        local distanceToDoor = math.sqrt((door.x - dart.x)^2 + (door.y - dart.y)^2)
        if distanceToDoor < doorThresholdDistance and love.keyboard.isDown('up') then
            currentScreen = "transitionScreen"
            doorSound:play()
            backgroundMusic:stop()
        end
    elseif currentScreen == "transitionScreen" then
        transitionTimer = transitionTimer + dt
        if transitionTimer >= transitionDuration then
            currentScreen = "bossFight"
            battleMusic:play()
        end
    elseif currentScreen == "bossFight" then
        local time = dt

        if love.keyboard.isDown('up') then
            selection.x = VIRTUAL_WIDTH / 2 - 115
            selection.y = VIRTUAL_HEIGHT - 75
        end
        if love.keyboard.isDown('down') then
            selection.x = VIRTUAL_WIDTH / 2 - 115
            selection.y = VIRTUAL_HEIGHT - 40
        end
        
        if inbDart.isBattling == false then
            inbDart.currentSprite = dartSprite3
        end
        if duck.isBattling == false then
            duck.currentSprite = duckSprite1
        end
        
        if inbDart.isBattling == false then
            if waitingForDuck == false then
                if selection.y == VIRTUAL_HEIGHT - 75 and love.keyboard.isDown('x') and attackPerformed == false then
                    inbDart.currentSprite = dartSprite4
                    duck.currentSprite = duckSprite3
                    local damage = inbDart.attack - duck.defense
                    currentHP.duck = currentHP.duck - damage
                    attackPerformed = true
                    waitingForDuck = true
                    attackTimer = 0
                    inbDart.isBattling = true
                    duck.isBattling = true
                    attackSound:play()
                end
                if selection.y == VIRTUAL_HEIGHT - 40 and love.keyboard.isDown('x') and attackPerformed == false then
                    inbDart.currentDef = inbDart.currentDef + inbDart.defense + 5
                    attackPerformed = true
                    waitingForDuck = true
                    attackTimer = 0
                    inbDart.isBattling = true
                    inbDart.currentSprite = dartSprite5
                    defenseSound:play()
                end
            end    
            if waitingForDuck == true then
                attackTimer = attackTimer + time
                if attackTimer >= attackDelay then
                    inbDart.currentSprite = dartSprite6
                    duck.currentSprite = duckSprite2
                    local damage = duck.attack - inbDart.currentDef
                    currentHP.dart = currentHP.dart - damage
                    attackPerformed = false
                    waitingForDuck = false
                    atackTimer = 0
                    inbDart.currentDef = inbDart.defense
                    inbDart.isBattling = true
                    duck.isBattling = true
                    time = 0
                    duckSound:play()
                end
            end  
        end
        spriteTimer = spriteTimer + time
        if spriteTimer >= spriteDelay then
            inbDart.isBattling = false
            duck.isBattling = false 
            spriteTimer = 0
            time = 0
        end

        if currentHP.dart <= 0 then
            if battleMusic:isPlaying() then
                battleMusic:stop()
            end
            currentScreen = loserScreen
            gameOver:play()
        elseif currentHP.duck <= 0 then
            if battleMusic:isPlaying() then
                battleMusic:stop()
            end
            currentScreen = winnerScreen
            winnerSound:play()
        end
        
    end
    if not love.keyboard.isDown('x') then
        attackPerformed = false
    end  
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    if currentScreen == "main" then
        love.graphics.setDefaultFilter('linear', 'linear')
        -- Set background color
        love.graphics.clear(backgroundColor)

        -- Draw stars
        for i, star in ipairs(stars) do
            love.graphics.draw(starsSprite, star.x, star.y)
        end

        -- Sort objects by z-index (lower z-index is drawn first)
        table.sort(objects, function(a, b) return a.z < b.z end)
        for _, obj in ipairs(objects) do
            love.graphics.setColor(1, 1, 1, 1)
            obj.draw()
        end

        love.graphics.draw(dart.currentSprite, dart.x, dart.y)

        if davidTextBalloon.isVisible then
            -- Set filter for text
            love.graphics.setDefaultFilter('nearest', 'nearest')
            
            
            love.graphics.draw(balloonSprite, davidTextBalloon.x, davidTextBalloon.y)
            love.graphics.setColor(0, 0, 0)
            love.graphics.setFont(nameFont)
            love.graphics.printf(davidTextBalloon.charName, davidTextBalloon.x + 75, davidTextBalloon.y + 65, 130, 'center')
            love.graphics.setFont(smallFont)
            love.graphics.printf(davidTextBalloon.text, davidTextBalloon.x + 77, davidTextBalloon.y + 85, 130, 'center')
            
            -- Reset filter after text
            love.graphics.setDefaultFilter('linear', 'linear')
        end

        love.graphics.setFont(screenFont)

    elseif currentScreen == "transitionScreen" then
        -- Set filter for text
        love.graphics.setDefaultFilter('nearest', 'nearest')
        
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Prepare to fight the evil...", 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("DUCK!", 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
        
        -- Reset filter after text
        love.graphics.setDefaultFilter('linear', 'linear')

    elseif currentScreen == "bossFight" then
        -- Sort objects by z-index (lower z-index is drawn first)
        table.sort(battleObjects, function(a, b) return a.z < b.z end)
        for _, batObj in ipairs(battleObjects) do
            batObj.draw()
        end

        -- Set filter for text
        love.graphics.setDefaultFilter('nearest', 'nearest')
        
        love.graphics.setFont(nameFont)
        love.graphics.printf("You're going to pay for it, Duck!", 0, 85, VIRTUAL_WIDTH / 2, 'center')
        love.graphics.setFont(hudNameFont)
        love.graphics.printf("Boss Fight", 0, 5, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Dart", 20, 12, hud1.width, 'center')
        love.graphics.printf("Duck", VIRTUAL_WIDTH / 2 + 70, 12, hud2.width, 'center')

        love.graphics.setFont(battleFont)
        love.graphics.printf("Attack", attackHud.x + 1, VIRTUAL_HEIGHT - 71, attackHud.width, 'center')
        love.graphics.printf("Defense", defenseHud.x + 1, VIRTUAL_HEIGHT - 36, defenseHud.width, 'center')
        love.graphics.printf(string.format("Dart   HP: %d / %d", currentHP.dart, inbDart.health), hp1.x + 1, VIRTUAL_HEIGHT - 71, hp1.width, 'center')
        love.graphics.printf(string.format("Duck   HP: %d / %d", currentHP.duck, duck.health), hp2.x + 1, VIRTUAL_HEIGHT - 36, hp2.width, 'center')
        
        -- Reset filter after text
        love.graphics.setDefaultFilter('linear', 'linear')
    
    elseif currentScreen == winnerScreen then
        love.graphics.setDefaultFilter('nearest', 'nearest')
        love.graphics.printf("Congratulations on defeating the evil Duck!", 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("You won!!!", 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
        -- Reset filter after text
        love.graphics.setDefaultFilter('linear', 'linear')

    elseif currentScreen == loserScreen then
        love.graphics.setDefaultFilter('nearest', 'nearest')
        love.graphics.printf("You lost.", 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Start the game from the beginning.", 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
    end

    push:apply('end')
end