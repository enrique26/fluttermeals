import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.selectPage});

  final void Function(String idetifier) selectPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white54, Colors.blueGrey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Row(
            children: [
              Icon(Icons.fastfood,
                  size: 48, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 18),
              const Text('meal nav')
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.restaurant),
          title: Text('Meals',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface)),
          onTap: () {
            selectPage('meals');
          },
        ),
        ListTile(
          leading: const Icon(Icons.filter),
          title: Text('Filters',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface)),
          onTap: () {
            selectPage('filters');
          },
        ),
      ]),
    );
  }
}
