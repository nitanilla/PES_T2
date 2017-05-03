
--
-- The procedures
--
function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function tableSize(T)
	local lengthNum = 0

	for k, v in pairs(T) do 
   		lengthNum = lengthNum + 1
	end

	return lengthNum
end

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
		stop_words[string.char(ascii)] = true
	end
    indexes = {}
    for i = 1,tableSize(words) do
        if has_value(stop_words, words[i]) then
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

-- function from [1]
function sort(word_freqs)

	local temp_word_freqs = {}


	for word, freq in pairs(word_freqs) do
		table.insert(temp_word_freqs, { ["word"] = word, ["freq"] = freq })
	end

	table.sort(temp_word_freqs, function(a, b) return a.freq > b.freq end)

	word_freqs = temp_word_freqs
	return word_freqs
end

function printResult(word_freqs)
	local maxNumberOfWords = 0
	for k, v in pairs(word_freqs) do
		print(v['word'],'-',v['freq'])
		maxNumberOfWords = maxNumberOfWords + 1
		if maxNumberOfWords >= 25 then break end
	end
end

--
-- The main function
--
printResult(sort(frequencies(remove_stop_words(scan(filter_chars_and_normalize(read_file(arg[1])))))))

--[1],Mauricio De Castro Lana e Douglas Mandarino, https://github.com/maumau27/PUC-Rio-INF1629-Trabalho_2/blob/master/CookBook/cookbook.lua
