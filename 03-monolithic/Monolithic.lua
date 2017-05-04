-- Monolithic style in Lua
-- Author: Nino Fabrizio Tiriticco Lizardo
-- Version:		Date:			Assignment:
-- 		1		27/04/2017		-Implemented stop words block
--		2		28/04/2017		-Implemented structure build block
--								-Implemented results show block
--		3		29/04/2017		-Fixed iteration through read line
--		4		02/05/2017		-Made code more readable



-- The global table with {word, frequency} pairs sorted by frequency
local sorted_word_freqs = {}

-- Building the stop word structure
local _stop_words = {}
file = io.open("../stop_words.txt", "rb")
file_content = file:read "*all"
for word in string.gmatch(file_content, "([^,%s]+)") do
    _stop_words[word] = true
end
for ascii = 97, 122 do -- Writting alphabet in ASCII
	_stop_words[string.char(ascii)] = true
end
file:close()

-- Iterating through file one line at a time
for line in io.lines(arg[1]) do
	start_char = nil
	line_index = 1

	for jIndex = 1, #line + 1 do -- Iterating through line one character at a time
		character = line:sub(line_index, line_index) -- This let's me get "end of line" character 
		if start_char == nil then
			if string.find(character, "%w") then
				-- Found the start of a word
				start_char = line_index
			end
		else
			if not string.find(character, "%w") then
				-- Found the end of a word. Process it
				found = false
				word = line:sub(start_char, line_index - 1)
				word = word:lower()

				-- Ignore stop words
				if _stop_words[word] == nil then
					word_frequency_index = 1

					-- Checking if it's in main table
					for position, word_frequency in pairs(sorted_word_freqs) do
						if word == word_frequency[1] then
							word_frequency[2] = word_frequency[2] + 1
							found = true
							break
						end
						word_frequency_index = word_frequency_index + 1
					end
					if not found then
						sorted_word_freqs[#sorted_word_freqs + 1] = {word, 1}
					elseif #sorted_word_freqs > 1 then

						-- Might need to reorder global table
						for word_below_index = word_frequency_index, 1, -1 do
							if sorted_word_freqs[word_frequency_index][2] > sorted_word_freqs[word_below_index][2] then
								-- Swapping
								temp_word = sorted_word_freqs[word_below_index][1]
								temp_freq = sorted_word_freqs[word_below_index][2]
								sorted_word_freqs[word_below_index][1] = sorted_word_freqs[word_frequency_index][1]
								sorted_word_freqs[word_below_index][2] = sorted_word_freqs[word_frequency_index][2]
								sorted_word_freqs[word_frequency_index][1] = temp_word
								sorted_word_freqs[word_frequency_index][2] = temp_freq
								word_frequency_index = word_below_index
							end
						end
					end
				end
				-- Resetting word indexer to get next word
				start_char = nil
			end
		end
		line_index = line_index + 1
	end
end

-- Printing results
for _, word_frequency in ipairs({unpack(sorted_word_freqs, 1, 25)}) do
  	print(word_frequency[1], " - ", word_frequency[2])
end