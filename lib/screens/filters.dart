import 'package:flutter/material.dart';
// import 'package:mealsnav/screens/tabs.dart';
// import 'package:mealsnav/widgets/main_drawer.dart';

enum FilterOptions {
  gluttenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<FilterOptions, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _gluttenFilter = false;
  var _lactosefreeFilter = false;
  var _veganFilter = false;
  var _vegetarianFilter = false;

  @override
  void initState() {
    super.initState();
    _gluttenFilter = widget.currentFilters[FilterOptions.gluttenFree]!;
    _lactosefreeFilter = widget.currentFilters[FilterOptions.lactoseFree]!;
    _veganFilter = widget.currentFilters[FilterOptions.vegan]!;
    _vegetarianFilter = widget.currentFilters[FilterOptions.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      // drawer: MainDrawer(selectPage: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //   }
      // }),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop({
            FilterOptions.gluttenFree: _gluttenFilter,
            FilterOptions.lactoseFree: _lactosefreeFilter,
            FilterOptions.vegan: _veganFilter,
            FilterOptions.vegetarian: _vegetarianFilter,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _gluttenFilter,
              onChanged: (checked) {
                setState(() {
                  _gluttenFilter = checked;
                });
              },
              title: const Text(
                'Glutter-free',
                style: TextStyle(color: Colors.blueAccent),
              ),
              subtitle: const Text('Only include gluten-free meals'),
              activeColor: Colors.deepOrange,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactosefreeFilter,
              onChanged: (checked) {
                setState(() {
                  _lactosefreeFilter = checked;
                });
              },
              title: const Text(
                'lactose-free',
                style: TextStyle(color: Colors.blueAccent),
              ),
              subtitle: const Text('Only include lactose-free meals'),
              activeColor: Colors.deepOrange,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganFilter,
              onChanged: (checked) {
                setState(() {
                  _veganFilter = checked;
                });
              },
              title: const Text(
                'vegan-free',
                style: TextStyle(color: Colors.blueAccent),
              ),
              subtitle: const Text('Only include vegan-free meals'),
              activeColor: Colors.deepOrange,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilter,
              onChanged: (checked) {
                setState(() {
                  _vegetarianFilter = checked;
                });
              },
              title: const Text(
                'vegetarian',
                style: TextStyle(color: Colors.blueAccent),
              ),
              subtitle: const Text('Only include vegetarian-free meals'),
              activeColor: Colors.deepOrange,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            )
          ],
        ),
      ),
    );
  }
}
