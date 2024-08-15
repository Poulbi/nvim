.PHONY: check 

LUA_FILES := $(shell find . -type f -name "*.lua")

check:
	luacheck --no-color --globals=vim -- $(LUA_FILES)
	stylua $(LUA_FILES)
