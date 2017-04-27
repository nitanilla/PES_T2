-- Monolithic style in Lua
-- Author: Nino Fabrizio Tiriticco Lizardo
-- Version:		Date:			Assignment:
-- 		1		27/04/2017		-Implemented stop words block



-- The global table with {word, frequency} pairs
local word_freqs = {}

-- Building the stop word structure
_stop_words = {}
f = io.open("../stop_words.txt", "rb")
content = f:read "*a"
for word in string.gmatch(content, '([^,%s]+)') do
    _stop_words[word] = true
end
for ascii = 97, 122 do
	_stop_words[string.char(ascii)] = true
end
f:close()