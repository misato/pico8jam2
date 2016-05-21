cat head >cave.p8
cat source.lua >>cave.p8
cat gfx_sfx.p8 | awk '/__gfx__/ {seen= 1 }
seen {print}' >>cave.p8

