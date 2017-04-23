-- Letterbox style in Lua
-- Author: Nino Fabrizio Tiriticco Lizardo
-- Version:		Date:			Assignment:
-- 		1		23/04/2017		-Implemented class dataStorageManager and its variable and methods

-- Class dataStorageManager
-- Models the data inside main file read
local dataStorageManager = {}

-- Attribute with the content read
dataStorageManager["_data"] = ""

-- Method which calls the respective method of this object for action asked
dataStorageManager.dispatch = function(self, message)

	if message[0] == "init" then
		return self._init(message[1])
	elseif message[0] == "words" then
		return self.words()
	else
		print("Message not understood ", message[0])
		os.exit()
	end
end

-- Method which opens file, read it and separates words
-- OBS.: Not sure if this is correct
dataStorageManager._init = function(self, path_to_file)

	local f = io.open(path_to_file, "rb")
	self._data = f:read "*a"
	pattern = '[%w_]+'
	self._data:match(pattern)
	self._data:lower()
end

-- Method which returns the words collected
-- OBS.: Not sure if this is correct
dataStorageManager._words = function(self)

	local data_str = table.concat(self._data, " ")
	local table = {}
	local index = 1
    
    for word in string.gmatch(data_str, " ") do
        table[index] = word
        index = index + 1
    end

	return table
end

-- Main execution
local new_file = io.open(arg[1], "rb")
if new_file then new_file:close() end
  print(new_file ~= nil)