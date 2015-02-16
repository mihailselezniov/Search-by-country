#-*- coding:utf-8 -*-
# Search by country

list_of_countries = ['Afghanistan', 'Albania', 'Algeria', 'Belarus', 'Belgium']

def get_new_tree_of_countries(string, tree, count_country):
    letter = string[0].lower()
    if not letter in tree[0]:
        tree[0][letter] = [{},[]]
    tree[1].append(count_country)
    if len(string) == 1:
        tree[0][letter][1].append(count_country)
        return tree
    tree[0][letter] = get_new_tree_of_countries(string[1:], tree[0][letter], count_country)
    return tree

def init_tree_of_countries(countries):
    tree = [{},[]]
    for count, country in enumerate(countries):
        tree = get_new_tree_of_countries(country, tree, count)
    return tree

def add_country(country, tree):
    count = len(list_of_countries)
    list_of_countries.append(country)
    return get_new_tree_of_countries(country, tree, count)
    
def get_id_list_of_countries(string, tree):
    letter = string[0].lower()
    if not letter in tree[0]:
        return []
    if len(string) == 1:
        return tree[0][letter][1]
    return get_id_list_of_countries(string[1:], tree[0][letter])

def search_countries(string):
    result_list = []
    for country_id in get_id_list_of_countries(string, tree_of_countries):
        result_list.append(list_of_countries[country_id])
    return result_list

tree_of_countries = init_tree_of_countries(list_of_countries)

# Test 1
if search_countries('al') != ['Albania', 'Algeria']:
    print "Test 1 is failed"

tree_of_countries = add_country('all', tree_of_countries)

# Test 2
if search_countries('al') != ['Albania', 'Algeria', 'all']:
    print "Test 2 is failed"

# Test 3
if search_countries('ab') != []:
    print "Test 3 is failed"
