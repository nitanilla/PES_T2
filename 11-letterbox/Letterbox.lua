-- Letterbox style in Lua
-- Author: Nino Fabrizio Tiriticco Lizardo
-- Version:		Date:			Assignment:
-- 		1		23/04/2017		-Implemented class DataStorageManager
--		2		25/04/2017		-Implemented class StopWordManager
--								-Fixed methods in StopWordManager
--		3		26/04/2017		-Fixed methods in DataStorageManager
--								-Implemented class WordFrequencyManager
--								-Implemented class WordFrequencyController
--								-Implemented block of main execution


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

-- Method which opens file, reads it and filters the content
DataStorageManager._init = function(self, path_to_file)

	local f = io.open(path_to_file, "rb")
	self._data = f:read "*a"
	pattern = '([%W_]+)'
	self._data = self._data:gsub(pattern, " ")
	self._data = self._data:lower()
	f:close()
end

-- Method which returns a table with the words collected
DataStorageManager._words = function(self)

	local data_str = "" .. self._data
	local table = {}
    
    for word in string.gmatch(data_str, "([%w]+)") do
        table[#table + 1] = word
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



-- Class WordFrequencyManager
-- Keeps the word frequency data
local WordFrequencyManager = {}

-- Attribute with the frequency of each word
WordFrequencyManager["_word_freqs"] = {}

-- Method which calls the respective method of this object for action asked
WordFrequencyManager.dispatch = function(self, message)

	if message[1] == "increment_count" then
		return self:_increment_count(message[2])
	elseif message[1] == "sorted" then
		return self:_sorted()
	else
		print("Message not understood ", message[1])
		os.exit()
	end
end

-- Method which increase frequency number of given word inside table
WordFrequencyManager._increment_count = function(self, word)

	if self._word_freqs[word] ~= nil then
		self._word_freqs[word] = self._word_freqs[word] + 1
	else
		self._word_freqs[word] = 1
	end
end

-- Method which sorts the table by frequency in descending order
WordFrequencyManager._sorted = function(self)

	local keys = {}
	for key in pairs(self._word_freqs) do
    	table.insert(keys, key)
    end

    sortFunction = function(a, b) return a > b end
    table.sort(keys, function(a, b) return sortFunction(self._word_freqs[a], self._word_freqs[b]) end)

    local sorted = {}
    for w, key in ipairs(keys) do
  		sorted[#sorted+1] = {key, self._word_freqs[key]}
	end

    return sorted
end
-- End of class WordFrequencyManager



-- Class WordFrequencyController
-- Manages the other classes
local WordFrequencyController = {}

-- Method which calls the respective method of this object for action asked
WordFrequencyController.dispatch = function(self, message)

	if message[1] == "init" then
		return self:_init(message[2])
	elseif message[1] == "run" then
		return self:_run()
	else
		print("Message not understood ", message[1])
		os.exit()
	end
end

-- Method which "initiates" objects from the other classes
WordFrequencyController._init = function(self, path_to_file)

	self._storage_manager = DataStorageManager
	self._stop_word_manager = StopWordManager
	self._word_freq_manager = WordFrequencyManager
	self._storage_manager:dispatch({"init", path_to_file})
	self._stop_word_manager:dispatch({"init"})
end

-- Method which initites the execution of the other objects
WordFrequencyController._run = function(self)
	
	for _, word in pairs(self._storage_manager:dispatch({"words"})) do
		if not self._stop_word_manager:dispatch({"is_stop_word", word}) then
			self._word_freq_manager:dispatch({"increment_count", word})
		end
	end

	word_freqs = self._word_freq_manager:dispatch({"sorted"})
	for _, word in ipairs({unpack(word_freqs, 1, 25)}) do
  		print(word[1], " - ", word[2])
	end
end
-- End of class WordFrequencyController



-- Main execution
wfcontroller = WordFrequencyController
wfcontroller:dispatch({"init", arg[1]})
wfcontroller:dispatch({"run"})