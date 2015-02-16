# Search by country

$list_of_countries = ['Afghanistan', 'Albania', 'Algeria', 'Belarus', 'Belgium']

def get_new_tree_of_countries(string, tree, count_country)
    letter = string[0].downcase
    if !tree[0].key?(letter)
        tree[0][letter] = [{},[]]
    end
    tree[1].push(count_country)
    if string.length == 1
        tree[0][letter][1].push(count_country)
        return tree
    end
    tree[0][letter] = get_new_tree_of_countries(string[1..-1], tree[0][letter], count_country)
    return tree
end

def init_tree_of_countries(countries)
    tree = [{},[]]
    for count in 0 ... countries.size
        tree = get_new_tree_of_countries(countries[count], tree, count)
    end
    return tree
end

def add_country(country, tree)
    count = $list_of_countries.size
    $list_of_countries.push(country)
    return get_new_tree_of_countries(country, tree, count)
end
    
def get_id_list_of_countries(string, tree)
    letter = string[0].downcase
    if !tree[0].key?(letter)
        return []
    end
    if string.length == 1
        return tree[0][letter][1]
    end
    return get_id_list_of_countries(string[1..-1], tree[0][letter])
end

def search_countries(string)
    result_list = []
    for country_id in get_id_list_of_countries(string, $tree_of_countries)
        result_list.push($list_of_countries[country_id])
    end
    return result_list
end

$tree_of_countries = init_tree_of_countries($list_of_countries)

# Test 1
if search_countries('al') != ['Albania', 'Algeria']
    puts "Test 1 is failed"
end

$tree_of_countries = add_country('all', $tree_of_countries)

# Test 2
if search_countries('al') != ['Albania', 'Algeria', 'all']
    puts "Test 2 is failed"
end

# Test 3
if search_countries('ab') != []
    puts "Test 3 is failed"
end