# Search by country

list_of_countries = ['Afghanistan', 'Albania', 'Algeria', 'Belarus', 'Belgium']

get_new_tree_of_countries = (string, tree, count_country) ->
    letter = string[0].toLowerCase()
    if not (letter of tree[0])
        tree[0][letter] = [{},[]]
    tree[1].push count_country
    if string.length == 1
        tree[0][letter][1].push count_country
        return tree
    tree[0][letter] = get_new_tree_of_countries string[1..], tree[0][letter], count_country
    return tree

init_tree_of_countries = (countries) ->
    tree = [{},[]]
    for country, count in countries
        tree = get_new_tree_of_countries country, tree, count
    return tree

add_country = (country, tree) ->
    count = list_of_countries.length
    list_of_countries.push country
    return get_new_tree_of_countries country, tree, count
    
get_id_list_of_countries = (string, tree) ->
    letter = string[0].toLowerCase()
    if not (letter of tree[0])
        return []
    if string.length == 1
        return tree[0][letter][1]
    return get_id_list_of_countries string[1..], tree[0][letter]

search_countries = (string) ->
    result_list = []
    for country_id in get_id_list_of_countries string, tree_of_countries
        result_list.push list_of_countries[country_id]
    return result_list

arrayEqual = (a, b) ->
  a.length is b.length and a.every (elem, i) -> elem is b[i]

tree_of_countries = init_tree_of_countries list_of_countries

# Test 1
if not arrayEqual search_countries('al'), ['Albania', 'Algeria']
    console.log "Test 1 is failed"

tree_of_countries = add_country 'all', tree_of_countries

# Test 2
if not arrayEqual search_countries('al'), ['Albania', 'Algeria', 'all']
    console.log "Test 2 is failed"

# Test 3
if not arrayEqual search_countries('ab'), []
    console.log "Test 3 is failed"