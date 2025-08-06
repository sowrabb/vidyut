import 'package:flutter/material.dart';
import 'screens/screens.dart';

void main() => runApp(const VidyutApp());

/// Root widget configuring Material 3, seed colors and adaptive visual density.
class VidyutApp extends StatelessWidget {
  const VidyutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidyut Marketplace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AdaptiveScaffold(),
    );
  }
}

/// Five primary destinations required by PRD.
class _Destination {
  const _Destination(this.label, this.icon, this.iconSelected, this.page);
  final String label;
  final IconData icon;
  final IconData iconSelected;
  final Widget page;
}

const List<_Destination> _destinations = [
  _Destination('Home', Icons.home_outlined, Icons.home, HomeScreen()),
  _Destination('Search', Icons.search_outlined, Icons.search, SearchScreen()),
  _Destination('Sell', Icons.sell_outlined, Icons.sell, SellScreen()),
  _Destination('Orders', Icons.list_alt_outlined, Icons.list_alt, OrdersScreen()),
  _Destination('Profile', Icons.person_outline, Icons.person, ProfileScreen()),
];

/// Scaffold that adapts navigation pattern to screen size.
class AdaptiveScaffold extends StatefulWidget {
  const AdaptiveScaffold({super.key});

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useRail = constraints.maxWidth >= 600;
        final body = _destinations[_selectedIndex].page;

        if (useRail) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (i) => setState(() => _selectedIndex = i),
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final d in _destinations)
                      NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.iconSelected),
                        label: Text(d.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            ),
          );
        }

        return Scaffold(
          body: body,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (i) => setState(() => _selectedIndex = i),
            destinations: [
              for (final d in _destinations)
                NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.iconSelected),
                  label: d.label,
                ),
            ],
          ),
        );
      },
    );
  }
}
