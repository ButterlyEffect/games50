--[[
    PauseState Class
]]

PauseState = Class{__includes = BaseState}


--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function PauseState:enter(params)
    -- pause music
    scrolling = false
    sounds['pause']:play()
    sounds['music']:setLooping(false)
    sounds['music']:pause()
end

function PauseState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('p')then
        -- kick off music
        sounds['music']:setLooping(true)
        sounds['music']:play()
        gStateMachine:stateUnPause('pause')
    end
end

function PauseState:render()
    -- simply render the score to the middle of the screen
    love.graphics.draw(love.graphics.newImage('pause.png'), VIRTUAL_WIDTH / 2 - 25, VIRTUAL_HEIGHT / 2 - 25)
end