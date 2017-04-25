-- Letterbox style in Lua
-- Author: Nino Fabrizio Tiriticco Lizardo
-- Version:		Date:			Assignment:
-- 		1		23/04/2017		-Implemented class DataStorageManager
--		2		25/04/2017		-Implemented class StopWordManager
--								-Tested and corrected methods in classes created



-- Class DataStorageManager
-- Models the data inside main file read
local DataStorageManager = {}

-- Attribute with the content read
DataStorageManager["_data"] = ""

-- Method which calls the respective method of this object for action asked
DataStorageManager.dispatch = function(self, message)

	if message[1] == "init" then
		return self:_init(message[2])
	elseif message[1] == "words" then
		return self:_words()
	else
		print("Message not understood ", message[1])
		os.exit()
	end
end

-- Method which opens file, reads it and separates words
-- OBS.: Not working properly
DataStorageManager._init = function(self, path_to_file)

	local f = io.open(path_to_file, "rb")
	self._data = f:read "*a"
	pattern = '[%w_]+'
	self._data = self._data:match(pattern)
	self._data = self._data:lower()
	f:close()

	print(self._data)
end

-- Method which returns the words collected
-- OBS.: Not sure if this works properly
DataStorageManager._words = function(self)

	local data_str = self._data .. " "
	local table = {}
	local index = 1
    
    for word in string.gmatch(data_str, " ") do
        table[index] = word
        index = index + 1
    end

	return table
end
-- End of class DataStorageManager



-- Class StopWordManager
-- Models the stop-words structure to filter the words
local StopWordManager = {}

-- Attribute with the stop-words list
StopWordManager["_stop_words"] = {}

-- Method which calls the respective method of this object for action asked
StopWordManager.dispatch = function(self, message)

	if message[1] == "init" then
		return self:_init()
	elseif message[1] == "is_stop_word" then
		return self:_is_stop_word(message[2])
	else
		print("Message not understood ", message[1])
		os.exit()
	end
end

-- Method which opens stop_words file, reads it and separates words into a list
StopWordManager._init = function(self)

	local f = io.open("../stop_words.txt", "rb")
	local content = f:read "*a"
	for word in string.gmatch(content, '([^,%s]+)') do
    	self._stop_words[word] = true
	end
	for ascii = 97, 122 do
		self._stop_words[string.char(ascii)] = true
	end
	f:close()
end

-- Method which returns if word parameter is inside stop_words table
StopWordManager._is_stop_word = function(self, word)

	return self._stop_words[word] ~= nil
end
-- End of class StopWordManager



-- Main execution
--[[local new_file = io.open(arg[1], "rb")
if new_file then new_file:close() end
  print(new_file ~= nil)]]

DataStorageManager:dispatch({"init", arg[1]})
--[[for k,v in pairs(DataStorageManager:dispatch({"words"})) do
	print(k,v)
end]]