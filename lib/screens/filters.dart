import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsnav/provider/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[FilterOptions.gluttenFree]!,
            onChanged: (checked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.gluttenFree, checked);
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
            value: activeFilters[FilterOptions.lactoseFree]!,
            onChanged: (checked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.lactoseFree, checked);
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
            value: activeFilters[FilterOptions.vegan]!,
            onChanged: (checked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.vegan, checked);
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
            value: activeFilters[FilterOptions.vegetarian]!,
            onChanged: (checked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.vegetarian, checked);
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
    );
  }
}
