--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}


--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    medal = ''
    imagefile = ''
    if self.score < 3 and self.score >= 1 then
        medal = 'Ruby'
        imagefile = 'medals/3rd.png'
    elseif self.score >= 3 and self.score < 7 then
        medal = 'Emerald'
        imagefile = 'medals/2nd.png'
    elseif self.score >= 7 then
        medal = 'Diamond'
        imagefile = 'medals/1st.png'
    else
        medal = ''
        imagefile = ''
    end

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    if medal ~= '' then
        love.graphics.printf("You've recieved a " .. medal, 0, 100, VIRTUAL_WIDTH, 'center')
    end
    love.graphics.printf("Score: " .. tostring(self.score), 0, 115, VIRTUAL_WIDTH, 'center')

    if medal ~= '' then
        love.graphics.draw(love.graphics.newImage(imagefile), VIRTUAL_WIDTH / 2 - 8, VIRTUAL_HEIGHT / 2 - 8)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

    love.graphics.draw(love.graphics.newImage('medals/3rd.png'), VIRTUAL_WIDTH / 2 + 58, VIRTUAL_HEIGHT / 2 + 40)
    love.graphics.draw(love.graphics.newImage('medals/2nd.png'), VIRTUAL_WIDTH / 2 - 8, VIRTUAL_HEIGHT / 2 + 40)

    love.graphics.draw(love.graphics.newImage('medals/1st.png'), VIRTUAL_WIDTH / 2 - 72, VIRTUAL_HEIGHT / 2 + 40)

    love.graphics.setFont(smallFont)
    love.graphics.printf('Diamond: > 7 points', 0, 220, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Emerald: 3 - 7 points', 0, 235, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Ruby: > 1 point', 0, 250, VIRTUAL_WIDTH, 'center')
end