
-- The shared mutable data
data = {}
words = {}
word_freqs = {}


-- The procedures

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function read_file(path_to_file)
    
    --    Takes a path to a file and assigns the entire
    --    contents of the file to the global variable data
       
        data = io.read("*all", path_to_file)
end

local function filter_chars_and_normalize()
    
    -- Replaces all nonalphanumeric chars in data with white space
      
    for i in range(len(data)) do
        if not data[i].isalnum() then
            data[i] = ' '
        else
            data[i] = data[i].lower()
		end
	end
end

local function scan()

    -- Scans data for words, filling the global variable words

    data_str = data..""
    words = words + data_str.split()
end

local function remove_stop_words()
	stop_words = io.read("*all","../stop_words.txt").split(',')

    -- add single-letter words

    stop_words.extend(list(string.ascii_lowercase))
    indexes = {}
    for i in range(len(words)) do
        if has_value(stop_words,words[i]) then
            indexes.append(i)
		end
	end
    for i in reversed(indexes) do
        words.pop(i)
	end
end

local function frequencies()

    -- Creates a list of pairs associating
    -- words with frequencies

    for w in words do 
        keys = [wd[0] for wd in word_freqs] do
        if has_value(keys,w) then
            word_freqs[keys.index(w)][1] += 1
        else:
            word_freqs.append([w, 1])
		end
	end
end

local function sort()

    --    Sorts word_freqs by frequency

--    global word_freqs
--word_freqs.sort(lambda x, y: cmp(y[1], x[1]))
end

-- The main function

read_file(sys.argv[1])
filter_chars_and_normalize()
scan()
remove_stop_words()
frequencies()
sort()

i = 0
for tf in word_freqs do
    print (tf[0], ' - ', tf[1])
	i = i + 1
	if (i == 25) then
		break
	end
end
