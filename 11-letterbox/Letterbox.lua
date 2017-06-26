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
--		4		01/05/2017		-Documentation is more explanatory
--								-Made code more readable


-- Class DataStorageManager
-- Models the data inside main file read
local DataStorageManager = {}

-- Attribute with the content read
-- String containing the filtered content of the file
DataStorageManager["_fileData"] = ""


-- Method which calls the respective method of this object for action asked
-- Calls the respective method the message asks for, if the command inside message is known.
-- Then passes a second information inside message to method being called, if it's needed.
-- Stops program execution if message received is unidentified by this method
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
--		-"message": Table containing id for method to call and a second information, or not
-- Returns:
--		-Table containing inside each key a filtered word from file read
DataStorageManager.dispatchMessage = function(thisObject, message)

	if message[1] == "read_file" then
		thisObject:_getFileContent(message[2])
	elseif message[1] == "get_words" then
		return thisObject:_getWords()
	else
		print("Message not understood: ", message[1])
		os.exit()
	end
end


-- Method which opens file, reads it and filters the content inside class's attribute
-- The filter consists in exchanging character combinations equaling to pattern specified
-- for a blank space inside the attribute ans passing all letters to lower case.
-- The pattern consists in a combination with at least 1 character of all non-alphanumeric
-- characters, including underline
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
--		-"path_to_file": String with path to reach file
DataStorageManager._getFileContent = function(thisObject, path_to_file)

	local file = io.open(path_to_file, "rb")
	thisObject._fileData = file:read "*all" -- Get whole data from file and store it
	thisObject._fileData = thisObject._fileData:gsub("([%W_]+)", " ")
	thisObject._fileData = thisObject._fileData:lower()
	file:close()
end


-- Method which returns a table with the words collected
-- Each word extracted from "_fileData" equals to a combination with at least 1 character
-- of all alphanumeric characters. When word is identified, it's stored inside a table
-- as a value and the table is returned
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
-- Returns:
--		-"wordsTable": Table with words (String) as values and number (Integer) as keys
DataStorageManager._getWords = function(thisObject)

	local wordsTable = {}
    for word in string.gmatch(thisObject._fileData, "([%w]+)") do
        wordsTable[#wordsTable + 1] = word
    end
	return wordsTable
end
-- End of class DataStorageManager



-- Class StopWordManager
-- Models the stop-words structure to filter the words
local StopWordManager = {}

-- Attribute with the stop-words list
-- Table with stop words (String) as keys and boolean true as values
StopWordManager["_stop_words"] = {}


-- Method which calls the respective method of this object for action asked
-- Calls the respective method the message asks for, if the command inside message is known.
-- Then passes a second information inside message to method being called, if it's needed.
-- Stops program execution if message received is unidentified by this method
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
--		-"message": Table containing id for method to call and a second information, or not
-- Returns:
--		-Boolean value returned by "_is_stop_word" method when called
StopWordManager.dispatchMessage = function(thisObject, message)

	if message[1] == "read_file" then
		thisObject:_getStopWords()
	elseif message[1] == "is_stop_word" then
		return thisObject:_is_stop_word(message[2])
	else
		print("Message not understood: ", message[1])
		os.exit()
	end
end


-- Method which opens stop_words file, reads it and separates words into a list
-- The whole content of the file is firstly written inside a string, then the words
-- are extracted and stored as keys inside main table when they equal to a combination
-- with at least 1 character of all letters except comma. The values of the main table
-- is the boolean value true
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
StopWordManager._getStopWords = function(thisObject)

	local file = io.open("../stop_words.txt", "rb")
	local fileContent = file:read "*all"
	for word in string.gmatch(fileContent, "([^,%s]+)") do
    	thisObject._stop_words[word] = true
	end
	for ascii = 97, 122 do
		thisObject._stop_words[string.char(ascii)] = true
	end
	file:close()
end


-- Method which returns if word parameter is a key in stop_words table
-- The stop words are used as key in main table to facilitate checking if it's there.
-- In the end, it just checks if key exists in table
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
--		-"word": String equal to word being checked as stop word
-- Returns:
--		-True if word is a key with value inside table, False if it isn't
StopWordManager._is_stop_word = function(thisObject, word)
	return thisObject._stop_words[word] ~= nil
end
-- End of class StopWordManager



-- Class WordFrequencyManager
-- Keeps the word frequency data
local WordFrequencyManager = {}

-- Attribute with the frequency of each word
-- Table containing words (String) as keys and their frequency (Integer) as values
WordFrequencyManager["_words_freqs"] = {}


-- Method which calls the respective method of this object for action asked
-- Calls the respective method the message asks for, if the command inside message is known.
-- Then passes a second information inside message to method being called, if it's needed.
-- Stops program execution if message received is unidentified by this method
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
--		-"message": Table containing id for method to call and a second information, or not
-- Returns:
--		-Table returned by "_get_sorted_table" method when called
WordFrequencyManager.dispatchMessage = function(thisObject, message)

	if message[1] == "increment_word_frequency" then
		thisObject:_increment_word_frequency(message[2])
	elseif message[1] == "get_sorted_words_frequencies" then
		return thisObject:_get_sorted_table()
	else
		print("Message not understood: ", message[1])
		os.exit()
	end
end


-- Method which increase frequency number of given word inside table
-- Checks if word is already a key inside main table, then increases its value by one.
-- If it's not in main table, puts the key with frequency value as one
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
--		-"word": String equal to word in which frequency value has to be increased inside table
WordFrequencyManager._increment_word_frequency = function(thisObject, word)

	if thisObject._words_freqs[word] ~= nil then
		thisObject._words_freqs[word] = thisObject._words_freqs[word] + 1
	else
		thisObject._words_freqs[word] = 1
	end
end


-- Method which sorts the table by frequency in descending order
-- Firstly, a table containing the words in main table as values and index number as keys is created.
-- Then, using an auxiliary function that returns if a received value is superior to another given one,
-- the created table is sorted by the result of the comparison of frequency values of each key in main table.
-- Finally, a table is created containing the same keys as previous table and a table with {word, frequency},
-- in which frequency is extracted from main table, as values.
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
-- Returns:
--		-"sortedTable": Table with key being position on how frequent given word is in comparison to the other
--						and with value being a table {word, frequency}
WordFrequencyManager._get_sorted_table = function(thisObject)

	local wordsTable = {}
	for word, _ in pairs(thisObject._words_freqs) do
    	table.insert(wordsTable, word)
    end

    sortFunction = function(valueA, valueB) return valueA > valueB end
    table.sort(wordsTable, function(frequencyA, frequencyB)
    							return sortFunction(thisObject._words_freqs[frequencyA], thisObject._words_freqs[frequencyB])
    					   end)

    local sortedTable = {}
    for position, word in ipairs(wordsTable) do
  		sortedTable[position] = {word, thisObject._words_freqs[word]}
	end
    return sortedTable
end
-- End of class WordFrequencyManager



-- Class WordFrequencyController
-- Manages the other classes
local WordFrequencyController = {}


-- Method which calls the respective method of this object for action asked
-- Calls the respective method the message asks for, if the command inside message is known.
-- Then passes a second information inside message to method being called, if it's needed.
-- Stops program execution if message received is unidentified by this method
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
--		-"message": Table containing id for method to call and a second information, or not
WordFrequencyController.dispatchMessage = function(thisObject, message)

	if message[1] == "initiate_all" then
		thisObject:_initiate_all(message[2])
	elseif message[1] == "execute" then
		thisObject:_execute()
	else
		print("Message not understood: ", message[1])
		os.exit()
	end
end


-- Method which "initiates" objects from the other classes
-- Puts the instance of the other classes as keys inside table representing this class,
-- then calls methods that read files to initiate the attributes that store the needed data
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
--		-"path_to_file": String with path to reach file
WordFrequencyController._initiate_all = function(thisObject, path_to_file)

	thisObject._storage_manager = DataStorageManager
	thisObject._stop_word_manager = StopWordManager
	thisObject._word_freq_manager = WordFrequencyManager
	thisObject._storage_manager:dispatchMessage({"read_file", path_to_file})
	thisObject._stop_word_manager:dispatchMessage({"read_file"})
end


-- Method which initites the execution of the other objects
-- Asks for words read from file and iterates through them. In each iteration, if
-- word isn't stop word, increases it's frequency. All of that calling the respective
-- methods from the other classes. Finally asks for the sorted table and shows
-- the first 25 entries (word and frequency).
-- Receives:
--		-"thisObject": Reference to the own object from this method's class
WordFrequencyController._execute = function(thisObject)
	
	for _, word in pairs(thisObject._storage_manager:dispatchMessage({"get_words"})) do
		if not thisObject._stop_word_manager:dispatchMessage({"is_stop_word", word}) then
			thisObject._word_freq_manager:dispatchMessage({"increment_word_frequency", word})
		end
	end

	sorted_word_freqs = thisObject._word_freq_manager:dispatchMessage({"get_sorted_words_frequencies"})
	for _, word_frequency in ipairs({unpack(sorted_word_freqs, 1, 25)}) do
  		print(word_frequency[1], " - ", word_frequency[2])
	end
end
-- End of class WordFrequencyController


-- Main execution
wfcontroller = WordFrequencyController
wfcontroller:dispatchMessage({"initiate_all", arg[1]})
wfcontroller:dispatchMessage({"execute"})

-- ver comentarios no pull-request (Roxana)
