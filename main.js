// Generated by CoffeeScript 1.9.0
(function() {
  var add_country, arrayEqual, get_id_list_of_countries, get_new_tree_of_countries, init_tree_of_countries, list_of_countries, search_countries, tree_of_countries;

  list_of_countries = ['Afghanistan', 'Albania', 'Algeria', 'Belarus', 'Belgium'];

  get_new_tree_of_countries = function(string, tree, count_country) {
    var letter;
    letter = string[0].toLowerCase();
    if (!(letter in tree[0])) {
      tree[0][letter] = [{}, []];
    }
    tree[1].push(count_country);
    if (string.length === 1) {
      tree[0][letter][1].push(count_country);
      return tree;
    }
    tree[0][letter] = get_new_tree_of_countries(string.slice(1), tree[0][letter], count_country);
    return tree;
  };

  init_tree_of_countries = function(countries) {
    var count, country, tree, _i, _len;
    tree = [{}, []];
    for (count = _i = 0, _len = countries.length; _i < _len; count = ++_i) {
      country = countries[count];
      tree = get_new_tree_of_countries(country, tree, count);
    }
    return tree;
  };

  add_country = function(country, tree) {
    var count;
    count = list_of_countries.length;
    list_of_countries.push(country);
    return get_new_tree_of_countries(country, tree, count);
  };

  get_id_list_of_countries = function(string, tree) {
    var letter;
    letter = string[0].toLowerCase();
    if (!(letter in tree[0])) {
      return [];
    }
    if (string.length === 1) {
      return tree[0][letter][1];
    }
    return get_id_list_of_countries(string.slice(1), tree[0][letter]);
  };

  search_countries = function(string) {
    var country_id, result_list, _i, _len, _ref;
    result_list = [];
    _ref = get_id_list_of_countries(string, tree_of_countries);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      country_id = _ref[_i];
      result_list.push(list_of_countries[country_id]);
    }
    return result_list;
  };

  arrayEqual = function(a, b) {
    return a.length === b.length && a.every(function(elem, i) {
      return elem === b[i];
    });
  };

  tree_of_countries = init_tree_of_countries(list_of_countries);

  if (!arrayEqual(search_countries('al'), ['Albania', 'Algeria'])) {
    console.log("Test 1 is failed");
  }

  tree_of_countries = add_country('all', tree_of_countries);

  if (!arrayEqual(search_countries('al'), ['Albania', 'Algeria', 'all'])) {
    console.log("Test 2 is failed");
  }

  if (!arrayEqual(search_countries('ab'), [])) {
    console.log("Test 3 is failed");
  }

}).call(this);
