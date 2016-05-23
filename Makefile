# Cave Makefile
# Keeping it simple!

LUASOURCE=source.lua
P8OUT=cave.p8

cave: head source.lua gfx_sfx.p8
	cat head >$(P8OUT)
	./parse $(LUASOURCE) >>$(P8OUT)
	cat gfx_sfx.p8 | awk '/__gfx__/ {seen= 1 } seen {print}' >>$(P8OUT)

clean:
	-rm cave.p8

