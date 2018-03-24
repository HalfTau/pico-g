pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
player = {}
actors = {}
platforms = {}
player.x = 0
player.y = 0
player.dy = 1 -- gravity
player.sprite = 0
player.speed = 1
player.jumping = false
player.moveright = true
-- init camera position
cam_x = 0
cam_y = 0


function _init()
	genplatforms()
end


-- if a sprite is tagged with
-- 1, it's solid. return true.
function solid(x, y)
	val = mget(x,y)
	return	fget(val, 1)
end


-- is the actor on a platform right now?
function platform(x, y)
	yes = false
	for i = 8, 0, -1 do
		if not yes then
			yes = solid(flr((x + i) / 8), flr((y / 8)) + 1)
		end
	end
	return(yes)
end
-- update the player's sprite
-- every frame
function playermove(moving)
	player.moving = moving
	if moving then
 	player.sprite += 1
 	if(player.sprite > 3) player.sprite = 0
 else
 	player.sprite += 1
 	if(player.sprite > 37) player.sprite = 32
 end
end

function controls()
	-- controls
	if btn(0) then
		player.x -= player.speed
		player.moveright = false
		playermove(true)
	elseif btn(1) then
		player.x += player.speed
		player.moveright = true
		playermove(true)
	elseif btn(2) then 
		player.y -= player.speed
		player.sprite = 032
		player.moveright = true
		playermove(true)
	else
		playermove(false)
	end
end

function cameraupdate()
	-- does the camera
	-- need to update?
	if player.x % 128 == 0 then
		cam_x = player.x
	end
	if (player.y % 128 == 0)	cam_y = player.y
	if (player.x < 128) cam_x = 0
	if (player.y < 128)	cam_y = 0
end

function _update()
	player.moving = false
		-- apply gravity
	--if not platform(player.x, player.y) then
		--player.y += player.dy
	--end
	controls()
	cameraupdate()
	
	-- idle state
	if(not player.moving) player.sprite = 049

end

function _draw()
		cls()
		color(12)
	--	print('hello', player.x + 7, player.y - 7)
  camera(cam_x, cam_y)
  map(0, 0, 0, 0, 128, 32)
  --for i in all(platforms) do
  	--spr(i.sprite, i.x*8, i.y) 
 -- end
  spr(player.sprite, player.x, player.y,1, 1, not player.moveright, false) 
end

-->8
function genplatforms()
	for i = 0, 15 do
		temp = {}
		temp.x = i
		temp.y = 14
		temp.s = 22
		if i % 2 ==0 then
			temp.s = 021
		end
		mset(temp.x, temp.y,temp.s)
		add(platforms,temp)
	end
end
__gfx__
000cc000000cc000000cc000000cc000000cc00000111100000dd000000000000000000000000000000000000000000000000000000000000000000000000000
000c7000000c7000000c7000000c7000000c70000018810000d77d00000000000000000000000000000000000000000000000000000000000000000000000000
000cc000000cc000000cc000000cc000000cc0000011110000d88d00000000000000000000000000000000000000000000000000000000000000000000000000
00cccc0000cccc0000cccc0000cccc0000cccc000001100000d77d00000000000000000000000000000000000000000000000000000000000000000000000000
0c0cc0c00c0cc0c00c0cc0c00c0cc0c00c0cc0c00112211000dddd00000000000000000000000000000000000000000000000000000000000000000000000000
00cccc0000cccc0000cccc0000cccc0000cccc00010110100dddddd0000000000000000000000000000000000000000000000000000000000000000000000000
0cccccc00cccccc00cccccc00cccccc00cccccc0001111000d0dd0d0000000000000000000000000000000000000000000000000000000000000000000000000
c0c00c0cc0c00c00c0000c0c00c0000cc0c00c0c0010010000dddd00000000000000000000000000000000000000000000000000000000000000000000000000
000cc000000cc000000cc000000cc000000cc0007777777777777777000000000000000000000000000000000000000000000000000000000000000000000000
00077000000770000007700000077000000770007000000070000000000000000000000000000000000000000000000000000000000000000000000000000000
000cc000000cc000000cc000000cc000000cc0000007000700000700000000000000000000000000000000000000000000000000000000000000000000000000
00cccc0000cccc0000cccc0000cccc0000cccc000000070000070007000000000000000000000000000000000000000000000000000000000000000000000000
0c0cc0c00c0cc0c00c0cc0c00c0cc0c00c0cc0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00cccc0000cccc0000cccc0000cccc0000cccc007777777777777777000000000000000000000000000000000000000000000000000000000000000000000000
0cccccc00cccccc00cccccc00cccccc00cccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c0c00c0cc0c00c00c0000c0c00c0000cc0c00c0c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000cc000000cc000000cc000000cc000000cc000000000000000000000000000555555d55d555555600060000000000000000000000000000000000000000000
000cc000000cc000000cc000000cc000000cc000000000000000000000000000555d55555555d555006000600000000000000000000000000000000000000000
000cc000000cc000000cc000000cc000000cc0000000000000000000000000005d555666666556d6000000000000000000000000000000000000000000000000
00cccc0000cccc0000cccc0000cccc0000cccc000000000000000000000000005555d6d66d66d6d6000000060000000000000000000000000000000000000000
0c0cc0c00c0cc0c00c0cc0c00c0cc0c00c0cc0c0000000000000000000000000556d6565556d6665000060000000000000000000000000000000000000000000
00cccc0000cccc0000cccc0000cccc0000cccc000000000000000000000000005d5655555d565665006000000000000000000000000000000000000000000000
0cccccc00cccccc00cccccc00cccccc00cccccc00000000000000000000000006555d5556555d556000000600000000000000000000000000000000000000000
c0c00c0cc0c00c00c0000c0c00c0000cc0c00c0c0000000000000000000000005555555555555555600000000000000000000000000000000000000000000000
000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c7000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000cc000000c70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00cccc00000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0cc0c000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00cccc000c0cc0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0cccccc00cccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c0c00c0cc0c00c0c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007000000000000060606660600060000660000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000007000700000060606000600060006060000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070000000066606600600060006060000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000060606000600060006060000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007700000700000060606660666066606600000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000cccc000001111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000770000001881000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000cc0000001111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000cccc000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000cccc000011221100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000c0cc0c00010110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000cc0000001111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000cccccc00001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777700000000000000000000000000000000000000000000000000000000
70000000700000007000000070000000700000007000000070000000700000007000000000000000000000000000000000000000000000000000000000000000
00070007000007000007000700000700000700070000070000070007000007000007000700000000000000000000000000000000000000000000000000000000
00000700000700070000070000070007000007000007000700000700000700070000070000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77000007700000077700000770000007770000077000000777000007700000077700000700000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0000000000000000000000000000000000000000000202000000000000000000000000000000000002020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0707070707070917070707070707090a00000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070707070707191a070707070707191a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000800080800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070506070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707090707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07373f0707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f07070707073f07070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
