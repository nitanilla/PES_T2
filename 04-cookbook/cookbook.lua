-- Cookbook style in Lua
-- Author: Eduardo Tiomno Tolmasquim
-- Version:		Date:			Assignment:
-- 		1		02/05/2017		-Made almost all translation to Lua
--		2		03/05/2017		-Made sort and print_words functions

-- The shared mutable data
data = {}
words = {}
word_freqs = {}
ordered_words = {}

-- The procedures

function read_file(path_to_file)
    
    --Takes a path to a file and assigns the entire
    --contents of the file to the global variable data
    
    local file = io.open(path_to_file,"rb")
	data = file:read("*all")
	file:close()
end

function filter_chars_and_normalize()
    
    --Replaces all nonalphanumeric chars in data with white space
	data = data:gsub('%W',' ')
	data = data:lower()
 end

function scan()
    
    --Scans data for words, filling the global variable words

   for word in data:gmatch("%w+") do table.insert(words, word) end
end

function remove_stop_words()

    local file = io.open('../stop_words.txt','r')
	local file_content = file:read("*all")
	local stop_words = {}
	for word in file_content:gmatch("%w+") do
		table.insert(stop_words, word) 
	end
	
    -- add single-letter words
	
	for ascii = 97, 122 do
		stop_words[string.char(ascii)] = true
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
end

function frequencies()

    --Creates a list of pairs associating
    --words with frequencies 
    
    for k,w in pairs(words) do
		if (word_freqs[w] == nil) then
			word_freqs[w] = 1
		else
        	word_freqs[w] = word_freqs[w] + 1
		end
	end

end

function sort()

	-- sort words by frequency and stores at ordered_words

	for word, freq in pairs(word_freqs) do
		table.insert(ordered_words, { ["key"] = word, ["value"] = freq })
	end

	table.sort(ordered_words, function(a, b) return a["value"] > b["value"] end)

end

function  print_words()

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
read_file(arg[1])
filter_chars_and_normalize()
scan()
remove_stop_words()
frequencies()
sort()
print_words()


