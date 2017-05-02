-- The shared mutable data
data = {}
words = {}
word_freqs = {}

--
-- The procedures
--
function read_file(path_to_file)
    
    --Takes a path to a file and assigns the entire
    --contents of the file to the global variable data
    
    local file = io.open(path_to_file,"rb")
	data = file:read("*all")
	file:close()
end

function filter_chars_and_normalize()
    
    --Replaces all nonalphanumeric chars in data with white space
    
    for i in range(len(data)):
        if not data[i].isalnum():
            data[i] = ' '
        else:
            data[i] = data[i].lower()
end

function scan()
    
    --Scans data for words, filling the global variable words

    data_str = ""..data
    words = words + data_str.split()
end

function remove_stop_words()

    local file = io.open('../stop_words.txt',)
	local file_content = file:read("*all")
	local stop_words = string.gmatch(file_content, "%S+")
	
    -- add single-letter words
	
    stop_words.extend(list(string.ascii_lowercase))
    indexes = []
    for i in range(len(words)):
        if words[i] in stop_words:
            indexes.append(i)
    for i in reversed(indexes):
        words.pop(i)
end

function frequencies()

    --Creates a list of pairs associating
    --words with frequencies 
    
    global words
    global word_freqs
    for w in words:
        keys = [wd[0] for wd in word_freqs]
        if w in keys:
            word_freqs[keys.index(w)][1] += 1
        else:
            word_freqs.append([w, 1])
end

function sort()
    
    --Sorts word_freqs by frequency
    
    global word_freqs
    word_freqs.sort(lambda x, y: cmp(y[1], x[1]))
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

for tf in word_freqs[0:25]:
    print tf[0], ' - ', tf[1]
