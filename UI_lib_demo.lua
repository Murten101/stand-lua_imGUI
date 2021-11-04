require("natives-1627063482") -- da natives
require("lua_imGUI V3")

myUI = UI.new()

local icon_self = directx.create_texture(filesystem.scripts_dir() .. "\\resources\\" .. "imGUI_self.png")
local icon_world = directx.create_texture(filesystem.scripts_dir() .. "\\resources\\" .. "imGUI_world.png")
local icons = {
    self = icon_self,
    world = icon_world
}

menu.toggle(menu.my_root(), "UI demo", {"UIdemo"}, "epic UI demo",
    function(state)
        UItoggle = state


        while UItoggle do
            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())

            local playerpos = ENTITY.GET_ENTITY_COORDS(player)

            if PAD.IS_CONTROL_JUST_PRESSED(2, 29) then
                myUI.toggle_cursor_mode()
            end
-- [[#region window 1
            myUI.begin("demo window",0.05, 0.1, "qwertyuiop")
            myUI.subhead("Player pos:")
            myUI.start_horizontal()
            myUI.label("X: ", math.floor(playerpos.x))
            myUI.divider()
            myUI.label("Y: ", math.floor(playerpos.y))
            myUI.divider()
            myUI.label("Z: ", math.floor(playerpos.z))
            myUI.end_horizontal()

            myUI.divider()

            myUI.subhead("player stats:")
            myUI.label("Health: ", ENTITY.GET_ENTITY_HEALTH(player))
            myUI.label("armor: ", PED.GET_PED_ARMOUR(player))
            myUI.label("is in vehicle: ", PED.IS_PED_IN_ANY_VEHICLE(player, true))
            myUI.text(ENTITY.GET_ENTITY_ATTACHED_TO(PLAYER.PLAYER_PED_ID()))
            myUI.finish()
-- #endregion

--#region tabbed window
            local tabs = {
                [1] = { 
                    data = {
                        title = "self",
                        icon = icons.self
                    },
                    content = function ()
                    myUI.subhead("Player pos:")
                    myUI.start_horizontal()
                    myUI.label("X: ", math.floor(playerpos.x))
                    myUI.divider()
                    myUI.label("Y: ", math.floor(playerpos.y))
                    myUI.divider()
                    myUI.label("Z: ", math.floor(playerpos.z))
                    myUI.end_horizontal()
        
                    myUI.divider()
        
                    myUI.subhead("player stats:")
                    myUI.label("Health: ", ENTITY.GET_ENTITY_HEALTH(player))
                    myUI.label("armor: ", PED.GET_PED_ARMOUR(player))
                    myUI.label("is in vehicle: ", PED.IS_PED_IN_ANY_VEHICLE(player, true))
        
                    myUI.divider()
                    myUI.start_horizontal()
        
                    god_mode = myUI.toggle("god mode", god_mode, nil, function (state)
                        if state then
                            menu.trigger_commands("god on")
                        else
                            menu.trigger_commands("god off")
                        end
                    end)
                    rapid_fire = myUI.toggle("rapid fire", rapid_fire, nil, function (state)
                        if state then
                            menu.trigger_commands("rapidfire on")
                        else
                            menu.trigger_commands("rapidfire off")
                        end
                    end)
        
                    myUI.end_horizontal()
                    myUI.divider()
        
                    myUI.start_horizontal()
                    if myUI.button("example button 1") then
                        util.toast("2horny")
                    end
                    if myUI.button("example button 2") then
                        util.toast("2stand")
                    end
                    myUI.end_horizontal()
                    
                end},
                [2] = {
                    data = {
                        title = "world",
                        icon = icons.world
                    },
                    content = function ()
                    myUI.subhead("session stats:")
                    myUI.label("host", PLAYER.GET_PLAYER_NAME(players.get_host()), {
                        ["r"] = 0.2,
                        ["g"] = 0.9,
                        ["b"] = 0.9,
                        ["a"] = 1
                    })
                    myUI.label("script host", PLAYER.GET_PLAYER_NAME(players.get_script_host()), {
                        ["r"] = 0.9,
                        ["g"] = 0.9,
                        ["b"] = 0.2,
                        ["a"] = 1
                    })
        
                    if NETWORK.NETWORK_IS_SESSION_STARTED() then
                        myUI.divider()
                        myUI.text("player stats")
                        myUI.label("RP: ", players.get_rp(players.user()))
                        myUI.label("Money: ", players.get_money(players.user()))
                        myUI.start_horizontal()
                        myUI.label("bank", players.get_bank(players.user()))
                        myUI.label("wallet", players.get_wallet(players.user()))
                        myUI.end_horizontal()
                    end
        
                end},
                [3] = {
                    data = {
                        title = "protections",
                        icon = icons.self
                    },
                    content = function ()
                    myUI.subhead("just play singleplayer lol")
                end}
        }
            myUI.start_tab_container("EPIC MOD MENU", 0.4, 0.3, tabs, "asidghufiopuas")
-- #endregion


            myUI.begin("players", 0.05, 0.05, "kpjbgkzjsdbg")
            local player_table = players.list()
            for i, pid in pairs(player_table) do
                myUI.start_horizontal()
                myUI.label(PLAYER.GET_PLAYER_NAME(pid).." ", players.get_rank(pid))
                myUI.divider()
                myUI.label("is modder ",players.is_marked_as_modder(pid))
                myUI.divider()
                if myUI.button("kick") then
                    menu.trigger_commands("kick "..PLAYER.GET_PLAYER_NAME(pid))
                end
                if myUI.button("crash") then
                    menu.trigger_commands("crash "..PLAYER.GET_PLAYER_NAME(pid))
                end
                myUI.end_horizontal()
            end
            myUI.finish()

--#region window 3
            myUI.begin("another window",0.8, 0.1, "asdfghjkl")
            myUI.subhead("session stats:")
            myUI.label("host", PLAYER.GET_PLAYER_NAME(players.get_host()), {
                ["r"] = 0.2,
                ["g"] = 0.9,
                ["b"] = 0.9,
                ["a"] = 1
            })
            myUI.label("script host", PLAYER.GET_PLAYER_NAME(players.get_script_host()), {
                ["r"] = 0.9,
                ["g"] = 0.9,
                ["b"] = 0.2,
                ["a"] = 1
            })

            if NETWORK.NETWORK_IS_SESSION_STARTED() then
                myUI.divider()
                myUI.text("player stats")
                myUI.label("RP: ", players.get_rp(players.user()))
                myUI.label("Money: ", players.get_money(players.user()))
                myUI.start_horizontal()
                myUI.label("bank", players.get_bank(players.user()))
                myUI.label("wallet", players.get_wallet(players.user()))
                myUI.end_horizontal()
            end

            myUI.finish()
-- #endregion


            util.yield()
        end
    end
)

while true do
    util.yield() -- keeps the script running at all times.
end
