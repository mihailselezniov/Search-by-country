<?php
// Search by country

$list_of_countries = array('Afghanistan', 'Albania', 'Algeria', 'Belarus', 'Belgium');

function get_new_tree_of_countries($string, $tree, $count_country)
{
    $letter = mb_strtolower($string[0]);
    if (in_array($letter, $tree[0])) {
        $tree[0][$letter] = array(array(), array());
    }
    $tree[1][] = $count_country;
    if (strlen($string) == 1) {
        $tree[0][$letter][1][] = $count_country;
        return $tree;
    }
    $tree[0][$letter] = get_new_tree_of_countries(substr($string, 1), $tree[0][$letter], $count_country);
    return $tree;
}

function init_tree_of_countries($countries)
{
    $tree = array(array(), array());
    $count = count($countries);
    for ($i = 0; $i < $count; $i++) {
        $tree = get_new_tree_of_countries($countries[$i], $tree, $i);
    }
    return $tree;
}

function add_country($country, $tree)
{
    global $list_of_countries;
    $count = count($list_of_countries);
    $list_of_countries[] = $country;
    return get_new_tree_of_countries($country, $tree, $count);
}

function get_id_list_of_countries($string, $tree)
{
    $letter = mb_strtolower($string[0]);
    if (in_array($letter, $tree[0])) {
        return array();
    }
    if (strlen($string) == 1) {
       return $tree[0][$letter][1];
    }
    return get_id_list_of_countries(substr($string, 1), $tree[0][$letter]);
}

function search_countries($string)
{
    $result_list = array();
    global $tree_of_countries, $list_of_countries;
    $countries = get_id_list_of_countries($string, $tree_of_countries);
    $count = count($countries);
    for ($i = 0; $i < $count; $i++) {
        $result_list[] = $list_of_countries[$countries[$i]];
    }
    return $result_list;
}

$tree_of_countries = init_tree_of_countries($list_of_countries);

// Test 1
if (search_countries('al') != array('Albania', 'Algeria'))
{
    echo "<p>Test 1 is failed</p>";
}

$tree_of_countries = add_country('all', $tree_of_countries);

// Test 2
if (search_countries('al') != array('Albania', 'Algeria', 'all'))
{
    echo "<p>Test 2 is failed</p>";
}

// Test 3
if (search_countries('ab') != array())
{
    echo "<p>Test 3 is failed</p>";
}
?>