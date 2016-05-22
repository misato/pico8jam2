# Cave Makefile
# Keeping it simple!

cave: head source.lua gfx_sfx.p8
	cat head >cave.p8
	cat source.lua >>cave.p8
	cat gfx_sfx.p8 | awk '/__gfx__/ {seen= 1 } seen {print}' >>cave.p8

clean:
	-rm cave.p8

