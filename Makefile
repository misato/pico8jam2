# Cave Makefile
# Keeping it simple!

LUASOURCE=source.lua
P8OUT=cave.p8
GFXSFX=gfx_sfx.p8
PARSEOPTIONS=

cave: parse.py head $(LUASOURCE) $(GFXSFX)
	cat head >$(P8OUT)
	./parse.py $(LUASOURCE) $(PARSEOPTIONS) >>$(P8OUT)
	cat $(GFXSFX) | awk '/__gfx__/ {seen= 1 } seen {print}' >>$(P8OUT)

clean:
	$(RM) $(P8OUT)
