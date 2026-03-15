local Stage = {
    -- 演员表
    actors = {}
}

Stage.onStart = function()
    print("演员上台")
    local player = _F.Player(0);
    local enemyPlayer = _F.Player(1);
    local hero = _F.CreateUnit(player, char2id("A000"), 0, 0, 270)
    _F.SetHeroLevel(hero, 2, false)
    local enemy1 = _F.CreateUnit(enemyPlayer, char2id("ogru"), 280, 0, 180)
    local enemy2 = _F.CreateUnit(enemyPlayer, char2id("ogru"), 360, 120, 180)
    local enemy3 = _F.CreateUnit(enemyPlayer, char2id("ogru"), 360, -120, 180)

    Stage.actors["hero"] = hero
    Stage.actors["enemy1"] = enemy1
    Stage.actors["enemy2"] = enemy2
    Stage.actors["enemy3"] = enemy3

    _F.ClearSelection()
    _F.SelectUnit(hero, true)
end

Stage.onStop = function()
    print("演员下台")

    for _, unit in pairs(Stage.actors) do
        if unit ~= nil then
            _F.RemoveUnit(unit)
        end
    end

    Stage.actors = {}
end

return Stage
