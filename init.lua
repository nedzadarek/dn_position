local idx, idy, idz, iddir = nil
local posx = 1
local posy = 0
local offsetx = -50
local offsety = 20
local offset_multiplier = 20
local hud_scale = {x = 100, y = 100}

local color = 0xff0000

minetest.register_globalstep(
	function(dtime)
		for _,player in ipairs(minetest.get_connected_players()) do
			
      if idx then
        player:hud_change(idx, "text", "X: " .. math.ceil(player:getpos().x) )
        player:hud_change(idy, "text", "Y: " .. math.ceil(player:getpos().y) )
        player:hud_change(idz, "text", "Z: " .. math.ceil(player:getpos().z) )

        -- player:hud_change(iddir, "text", "Direction: " .. player:get_look_dir().z) -- x, y, z
        -- from -1 to 1, -1 & 1 at opposite directions, 0 & 0 at opposite directions.. meh

        -- player:hud_change(iddir, "text", "Direction: " .. player:get_look_dir().x) -- x, y, z
        -- 90C clockwise rotation
				local rotx = player:get_look_dir().x
				local rotz = player:get_look_dir().z

				-- symbols: North, South, East, West
				local symbol = ""
				if rotz < -0.50 then
					symbol = " E"
				elseif rotz > 0.5 then
					symbol = " W"
				elseif rotx < -0.5 then
					symbol = " N"
				elseif rotx > 0.5 then
					symbol = " S"
				end


				-- sometimes it goes upto ~357 & ~3 why?
				local c = 2 / 180
				local rotation = 0 -- 360 = 0
				if rotx < 0 then
					rotation = 180 + (rotz + 1) / c
				else
					rotation = math.abs(rotz - 1) / c
				end
				player:hud_change(iddir, "text", "Direction: " .. math.floor(rotation) .. symbol)
				-- for debug only
				-- print("rotation in C: " .. rotation .. rotz .. rotx)

      else
  			idx = player:hud_add({
           hud_elem_type = "text",
           position = {x = posx, y = posy},
           offset = {x= offsetx, y = offsety},
           scale = hud_scale,
           number = color,
           text = "My Text"
  			})
        idy = player:hud_add({
           hud_elem_type = "text",
           position = {x = posx, y = posy},
           offset = {x= offsetx, y = offsety + offset_multiplier},
           scale = hud_scale,
           number = color,
           text = "My Text"
  			})
        idz = player:hud_add({
           hud_elem_type = "text",
           position = {x = posx, y = posy},
           offset = {x= offsetx, y = offsety + (offset_multiplier * 2)},
           scale = hud_scale,
           number = color,
           text = "My Text"
  			})
        iddir = player:hud_add({
          hud_elem_type = "text",
          position = {x = posx, y = posy},
          offset = {x = offsetx, y = offsety + (offset_multiplier * 3)},
          scale = hud_scale,
          number = color,
          text = "My text"
        })
      end

		end
	end
)
