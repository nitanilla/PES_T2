-- Pipeline style in Lua
-- Author: Eduardo Tiomno Tolmasquim
-- Version:		Date:			Assignment:
-- 		1		02/05/2017		-Made almost all translation to Lua
--		2		03/05/2017		-Made sort function


-- The procedures

function read_file(path_to_file)
    
    --Takes a path to a file and assigns the entire
    --contents of the file to the global variable data
    
    local file = io.open(path_to_file,"rb")
	data = file:read("*all")
	file:close()
	return data
end

function filter_chars_and_normalize(data)
    
    --Replaces all nonalphanumeric chars in data with white space
	data = data:gsub('%W',' ')
	data = data:lower()
	return data

end

function scan(data)
    
    --Scans data for words, filling the global variable words
	local words = {}
   for word in data:gmatch("%w+") do table.insert(words, word) end
	return words
end

function remove_stop_words(words)

    local file = io.open('../stop_words.txt','r')
	local file_content = file:read("*all")
	local stop_words = {}
	for word in file_content:gmatch("%w+") do
		table.insert(stop_words, word) 
	end
	
    -- add single-letter words
	
	for ascii = 97, 122 do
		table.insert(stop_words, string.char(ascii))
	end

	local number_of_words  = 0
	for k, v in pairs(words) do 
   		number_of_words = number_of_words + 1
	end

    indexes = {}
    for i = 1,number_of_words do

		local has_value = false
		for _, value in ipairs(stop_words) do
    	    if value == words[i] then
        	    has_value = true
        	end
	    end

        if has_value then
            table.insert(indexes,i)
		end
	end

    for k,v in pairs(indexes) do
        words[v] = nil
	end
 
	return words
end

function frequencies(words)

    --Creates a list of pairs associating
    --words with frequencies 
    local word_freqs = {}
	
    for k,w in pairs(words) do
		if (word_freqs[w] == nil) then
			word_freqs[w] = 1
		else
        	word_freqs[w] = word_freqs[w] + 1
		end
	end

	return word_freqs

end

function sort(word_freqs)
	
	-- Sort words by frequency

	local ordered_words = {}	

	for word, freq in pairs(word_freqs) do
		table.insert(ordered_words, { ["key"] = word, ["value"] = freq })
	end

	table.sort(ordered_words, function(a, b) return a["value"] > b["value"] end)

	return ordered_words
end

function print_words(ordered_words)

	-- Print result on screen

	local maxNumberOfWords = 0
	for k, v in pairs(ordered_words) do
		print(v["key"],'-',v["value"])
		maxNumberOfWords = maxNumberOfWords + 1
		if maxNumberOfWords >= 25 then break end
	end
end

--
-- The main function
--
print_words(sort(frequencies(remove_stop_words(scan(filter_chars_and_normalize(read_file(arg[1])))))))
-- ver comentarios no pull-request (Roxana)
