.PHONY: check 

LUA_FILES := $(shell find . -type f -name "*.lua")

check:
	stylua $(LUA_FILES)
	luacheck --no-color --globals=vim -- $(LUA_FILES)
