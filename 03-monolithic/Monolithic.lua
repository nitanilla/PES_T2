-- Monolithic style in Lua
-- Author: Nino Fabrizio Tiriticco Lizardo
-- Version:		Date:			Assignment:
-- 		1		27/04/2017		-Implemented stop words block
--		2		28/04/2017		-Implemented structure build block
--								-Implemented results show block
--		3		29/04/2017		-Fixed iteration through read line



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

-- Iterating through file one line at a time
for line in io.lines(arg[1]) do
	start_char = nil
	i = 1

	for j = 1, #line + 1 do -- Needed this to include skip-line character
		c = line:sub(i,i)
		if start_char == nil then
			if string.find(c, "%w") then
				-- Found the start of a word
				start_char = i
			end
		else
			if not string.find(c, "%w") then
				-- Found the end of a word. Process it
				found = false
				word = line:sub(start_char, i - 1)
				word = word:lower()

				-- Ignore stop words
				if _stop_words[word] == nil then
					pair_index = 1

					-- Checking if it's in main table
					for key, value in pairs(word_freqs) do
						if word == value[1] then
							value[2] = value[2] + 1
							found = true
							found_at = pair_index -- This is never used!!!
							break
						end
						pair_index = pair_index + 1
					end
					if not found then
						word_freqs[#word_freqs + 1] = {word, 1}
					elseif #word_freqs > 1 then

						-- Might need to reorder global table
						for n = pair_index, 1, -1 do
							if word_freqs[pair_index][2] > word_freqs[n][2] then
								-- Swapping
								tempWord = word_freqs[n][1]
								tempFreq = word_freqs[n][2]
								word_freqs[n][1] = word_freqs[pair_index][1]
								word_freqs[n][2] = word_freqs[pair_index][2]
								word_freqs[pair_index][1] = tempWord
								word_freqs[pair_index][2] = tempFreq
								pair_index = n
							end
						end
					end
				end
				-- Resetting word indexer
				start_char = nil
			end
		end
		i = i + 1
	end
end

-- Printing results
for _, word in ipairs({unpack(word_freqs, 1, 25)}) do
  	print(word[1], " - ", word[2])
end