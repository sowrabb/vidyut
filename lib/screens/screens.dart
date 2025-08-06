import 'package:flutter/material.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String selectedState = 'Maharashtra';
  String selectedCity = 'Mumbai';
  
  final Map<String, List<String>> statesAndCities = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Thane', 'Nashik'],
    'Delhi': ['New Delhi', 'Delhi Cantonment', 'Dwarka'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli', 'Mangalore'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai', 'Salem'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi', 'Agra'],
    'West Bengal': ['Kolkata', 'Howrah', 'Durgapur', 'Siliguri'],
    'Telangana': ['Hyderabad', 'Warangal', 'Karimnagar', 'Nizamabad'],
  };

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Location'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // State dropdown
              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
                items: statesAndCities.keys.map((state) {
                  return DropdownMenuItem(value: state, child: Text(state));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedState = value!;
                    selectedCity = statesAndCities[value]!.first;
                  });
                },
              ),
              const SizedBox(height: 16),
              // City dropdown
              DropdownButtonFormField<String>(
                value: selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                items: statesAndCities[selectedState]!.map((city) {
                  return DropdownMenuItem(value: city, child: Text(city));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value!;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showLocationDialog,
      child: Row(
        children: [
          const Icon(Icons.house_rounded, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Home',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold)),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                  ],
                ),
                Text(
                  '$selectedCity, $selectedState',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          toolbarHeight: 0, // hide default toolbar; we build custom header below
          backgroundColor: colorScheme.surface,
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App name
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  'Mahanidhi Vidyut',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              // Address & avatar row
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    const Expanded(child: LocationSelector()),
                    CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer,
                      child: const Icon(Icons.person_outline),
                    ),
                  ],
                ),
              ),
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for bulbs, wires, …',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: colorScheme.surfaceVariant,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // Horizontal category tabs
              SizedBox(
                height: 96,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: kCategories.length,
                  itemBuilder: (context, i) {
                    final cat = kCategories[i];
                    return _HorizontalCategory(
                      icon: cat.icon,
                      label: cat.label,
                      active: i == 0,
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Promotional banner carousel
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final List<String> promotions = [
                      'Summer Essentials Sale!',
                      'Big Electric Discount',
                      'Premium Tools Collection'
                    ];
                    final List<IconData> icons = [
                      Icons.flash_on,
                      Icons.electric_bolt,
                      Icons.handyman
                    ];
                    final List<Color> colors = [
                      Colors.amber.shade200,
                      colorScheme.primaryContainer,
                      Colors.blue.shade100,
                    ];
                    
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: Icon(icons[index], size: 64, color: Colors.white.withOpacity(0.3)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  promotions[index],
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Up to 40% off on selected items',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                FilledButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.shopping_cart),
                                  label: const Text('Shop Now'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: colorScheme.primary.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        // Category grid
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid.count(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              for (final cat in kCategories)
                _CategoryTile(icon: cat.icon, label: cat.label),
            ],
          ),
        ),
      ],
      ),
    );
  }
}

class _HorizontalCategory extends StatelessWidget {
  const _HorizontalCategory({required this.icon, required this.label, this.active = false});
  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color bg = active
        ? colorScheme.primary
        : colorScheme.surfaceVariant;
    final Color iconColor = active ? colorScheme.onPrimary : colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: bg,
            radius: 28,
            child: Icon(icon, size: 32, color: iconColor),
          ),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceVariant,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryScreen(
                title: label,
                subcategories: const ['Popular', 'New Arrivals', 'Best Deals', 'Premium'],
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: colorScheme.primary),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({required this.title, required this.subcategories, super.key});
  final String title;
  final List<String> subcategories;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selected = 0;

  // Dummy product data for each category
  static const Map<String, List<Map<String, dynamic>>> categoryProducts = {
    'Bulbs': [
      {'name': 'Philips LED Bulb 9W', 'price': 120},
      {'name': 'Syska Smart Bulb', 'price': 299},
      {'name': 'Wipro Garnet Bulb', 'price': 150},
      {'name': 'Havells B22 Bulb', 'price': 110},
      {'name': 'Eveready LED Bulb', 'price': 99},
      {'name': 'Bajaj LED Bulb', 'price': 130},
    ],
    'Wires': [
      {'name': 'Finolex Copper Wire 90m', 'price': 1450},
      {'name': 'Polycab House Wire', 'price': 1200},
      {'name': 'Havells LifeLine Wire', 'price': 1350},
      {'name': 'RR Kabel Wire', 'price': 1250},
      {'name': 'KEI Home Wire', 'price': 1400},
      {'name': 'Anchor Advance Wire', 'price': 1380},
    ],
    'Switches': [
      {'name': 'Anchor Roma Switch', 'price': 45},
      {'name': 'GM Modular Switch', 'price': 55},
      {'name': 'Legrand Myrius Switch', 'price': 60},
      {'name': 'Havells Fabio Switch', 'price': 50},
      {'name': 'Schneider Opale Switch', 'price': 65},
      {'name': 'Goldmedal Curve Switch', 'price': 70},
    ],
    'Batteries': [
      {'name': 'Eveready AA Battery (Pack of 4)', 'price': 80},
      {'name': 'Duracell AAA Battery (Pack of 2)', 'price': 60},
      {'name': 'Panasonic 9V Battery', 'price': 45},
      {'name': 'Varta D Size Battery', 'price': 120},
      {'name': 'Energizer C Battery', 'price': 100},
      {'name': 'Nippo Gold Battery', 'price': 70},
    ],
    'Tools': [
      {'name': 'Stanley Screwdriver Set', 'price': 350},
      {'name': 'Taparia Pliers', 'price': 220},
      {'name': 'Bosch Drill Machine', 'price': 1999},
      {'name': 'Black+Decker Hammer', 'price': 499},
      {'name': 'Visko Wire Stripper', 'price': 180},
      {'name': 'Taparia Spanner Set', 'price': 420},
    ],
    'Meters': [
      {'name': 'HPL Digital Meter', 'price': 1200},
      {'name': 'Schneider Energy Meter', 'price': 1450},
      {'name': 'L&T kWh Meter', 'price': 1350},
      {'name': 'Secure Premier Meter', 'price': 1600},
      {'name': 'Genus Power Meter', 'price': 1550},
      {'name': 'Elmeasure Digital Meter', 'price': 1490},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final products = categoryProducts[widget.title] ?? List.generate(8, (i) => {'name': 'Product ${i + 1}', 'price': (i + 1) * 100});
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          // side category list
          Container(
            width: 100,
            color: colorScheme.surfaceVariant,
            child: ListView.builder(
              itemCount: widget.subcategories.length,
              itemBuilder: (context, i) {
                final selected = i == _selected;
                return InkWell(
                  onTap: () => setState(() => _selected = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    color: selected ? colorScheme.primaryContainer : Colors.transparent,
                    child: Column(
                      children: [
                        Icon(Icons.circle, color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant, size: 24),
                        const SizedBox(height: 4),
                        Text(
                          widget.subcategories[i],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: selected ? colorScheme.onPrimaryContainer : null,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const VerticalDivider(width: 1),
          // products grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: products.length,
              itemBuilder: (context, i) {
                return _ProductCard(
                  index: i,
                  name: products[i]['name'] as String,
                  price: products[i]['price'] as int,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.index, required this.name, required this.price});
  final int index;
  final String name;
  final int price;

  static const List<IconData> productIcons = [
    Icons.lightbulb, // Bulb
    Icons.cable, // Wire
    Icons.toggle_on, // Switch
    Icons.battery_full, // Battery
    Icons.build, // Tool
    Icons.speed, // Meter
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceVariant,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductDetail(index: index)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      productIcons[index % productIcons.length],
                      size: 48,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(name, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text('₹$price', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 
  final List<String> _recentSearches = [
    'LED Bulbs',
    'Power Cables',
    'Switch Plates',
    'Circuit Breakers',
  ];

  final List<Map<String, dynamic>> _dummyResults = List.generate(
    8,
    (i) => {
      'name': 'Item ${i + 1}',
      'price': (i + 1) * 20,
      'rating': 4.0 + (i % 10) / 10,
    },
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Search')),
      endDrawer: _buildFilterDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search field
            TextField(
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            
            // Recent searches
            const SizedBox(height: 16),
            const Text('Recent Searches'),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _recentSearches.map((term) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(term),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _recentSearches.remove(term);
                      });
                    },
                  ),
                )).toList(),
              ),
            ),
            
            // Results
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _dummyResults.length,
                itemBuilder: (context, index) {
                  final item = _dummyResults[index];
                  return _buildSearchResultCard(item, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFilterDrawer() {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              
              // Price Range
              const Text('Price Range', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              RangeSlider(
                values: const RangeValues(20, 80),
                min: 0,
                max: 100,
                divisions: 10,
                labels: RangeLabels('₹20', '₹80'),
                onChanged: null,
              ),
              
              const Divider(),
              
              // Brand Filter
              const Text('Brand', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: const [
                  FilterChip(label: Text('Phillips'), selected: true, onSelected: null),
                  FilterChip(label: Text('Havells'), selected: false, onSelected: null),
                  FilterChip(label: Text('Crompton'), selected: false, onSelected: null),
                  FilterChip(label: Text('Schneider'), selected: false, onSelected: null),
                ],
              ),
              
              const Divider(),
              
              // Rating Filter
              const Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: const [
                  FilterChip(label: Text('4★ & above'), selected: true, onSelected: null),
                  FilterChip(label: Text('3★ & above'), selected: false, onSelected: null),
                  FilterChip(label: Text('2★ & above'), selected: false, onSelected: null),
                ],
              ),
              
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSearchResultCard(Map<String, dynamic> item, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetail(index: index)),
        );
      },
      child: Card(
        elevation: 0,
        color: colorScheme.surfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: const Center(child: Icon(Icons.electric_bolt, size: 48)),
                ),
              ),
              
              // Product details
              const SizedBox(height: 12),
              Text(item['name'], style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('₹${item['price']}', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(' ${item['rating']}', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.add), text: 'List Item'),
            Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListItemTab(),
          _buildDashboardTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  Widget _buildListItemTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('List New Product', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.inventory),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price (₹)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.currency_rupee),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: kCategories.map((cat) => DropdownMenuItem(
                    value: cat.label,
                    child: Text(cat.label),
                  )).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Stock Quantity',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.inventory_2),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
          onPressed: () {},
                    icon: const Icon(Icons.upload),
                    label: const Text('Upload Photos'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.publish),
                    label: const Text('Publish Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Sales Overview
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sales Overview', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('Total Sales', '₹45,230', Icons.trending_up, Colors.green),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('Products', '12', Icons.inventory, Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('Orders', '28', Icons.shopping_cart, Colors.orange),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('Rating', '4.5★', Icons.star, Colors.amber),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Recent Activity
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildActivityItem('New order received', 'Order #1234', '2 min ago', Icons.shopping_cart),
                _buildActivityItem('Product published', 'LED Bulb', '1 hour ago', Icons.check_circle),
                _buildActivityItem('Review received', '5★ rating', '3 hours ago', Icons.star),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Analytics', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildAnalyticsItem('Views', '1,234', '+12%', Icons.visibility),
                _buildAnalyticsItem('Clicks', '567', '+8%', Icons.touch_app),
                _buildAnalyticsItem('Conversions', '89', '+15%', Icons.trending_up),
                _buildAnalyticsItem('Revenue', '₹12,345', '+23%', Icons.currency_rupee),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsItem(String title, String value, String change, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Text(change, style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = List.generate(5, (i) => {
      'orderNo': '#${i + 1}',
      'status': 'Delivered',
      'date': '2024-06-0${i + 1}',
      'products': [
        {
          'name': 'Superb Bulb',
          'icon': Icons.lightbulb,
          'qty': 2,
          'price': 199,
        },
        {
          'name': 'Premium Wire',
          'icon': Icons.cable,
          'qty': 1,
          'price': 299,
        },
      ],
      'buyer': 'Sourab S.',
      'address': '12, Electric Avenue, Vidyut Nagar, Mumbai',
      'phone': '+91 98765 43210',
      'payment': 'Credit Card',
      'tracking': 'IN123456789',
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final order = orders[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OrderDetailPage(order: order)),
            ),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[50],
                          child: Text(order['orderNo'] as String, style: const TextStyle(color: Colors.blue)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order ${order['orderNo']}', style: Theme.of(context).textTheme.titleMedium),
                              Text('Status: ${order['status']}', style: Theme.of(context).textTheme.bodySmall),
                              Text('Date: ${order['date']}', style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(order['products'][0]['icon'] as IconData, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text('${order['products'][0]['name']} x${order['products'][0]['qty']}'),
                        const Spacer(),
                        Text('₹${order['products'][0]['price']}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order ${order['orderNo']}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Details', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('Order No: ${order['orderNo']}'),
                  Text('Status: ${order['status']}'),
                  Text('Date: ${order['date']}'),
                  Text('Payment: ${order['payment']}'),
                  Text('Tracking: ${order['tracking']}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Products', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...List.generate(order['products'].length, (i) {
                    final p = order['products'][i] as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(p['icon'] as IconData, color: Colors.blue),
                          const SizedBox(width: 8),
                          Expanded(child: Text('${p['name']} x${p['qty']}')),
                          Text('₹${p['price']}'),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shipping Info', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('Buyer: ${order['buyer']}'),
                  Text('Phone: ${order['phone']}'),
                  Text('Address: ${order['address']}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48)),
            const SizedBox(height: 16),
                  Text('Sourab S.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('sourab@email.com', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text('+91 98765 43210', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text('12, Electric Avenue, Vidyut Nagar, Mumbai', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Stats
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('5', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue)),
                      const Text('Orders'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('3', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                      const Text('Wishlist'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('2', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.amber)),
                      const Text('Reviews'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Recent Orders
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Orders', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.lightbulb, color: Colors.blue),
                    title: const Text('Superb Bulb x2'),
                    subtitle: const Text('Delivered'),
                    trailing: const Text('₹199'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.cable, color: Colors.blue),
                    title: const Text('Premium Wire x1'),
                    subtitle: const Text('Delivered'),
                    trailing: const Text('₹299'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
              onPressed: () {},
                  icon: const Icon(Icons.list_alt),
                  label: const Text('View All Orders'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  label: const Text('Wishlist'),
                ),
            ),
          ],
        ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                  label: const Text('Settings'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SellerProfilePage extends StatelessWidget {
  const SellerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.store, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text('ElectricMart', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star_half, color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Text('4.5 (1,234 ratings)', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Trusted Electrical Goods Supplier', 
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.primary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Statistics Section
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Business Statistics', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('2,500+', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary)),
                            const Text('Products Sold'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('98%', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                            const Text('Positive Feedback'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('5+', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary)),
                            const Text('Years Experience'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // About Section
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About ElectricMart', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('We are a leading supplier of electrical goods, serving customers across India since 2010. Our commitment to quality, reliability, and customer satisfaction has made us a trusted name in the electrical industry.'),
                  const SizedBox(height: 12),
                  const Text('• Premium quality electrical products'),
                  const Text('• Fast and reliable delivery'),
                  const Text('• 24/7 customer support'),
                  const Text('• 2-year warranty on all products'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Contact Information
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Information', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.email, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      const Expanded(child: Text('electricmart@email.com')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      const Expanded(child: Text('+91 98765 43210')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      const Expanded(child: Text('Mumbai, Maharashtra')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      const Expanded(child: Text('Mon-Sat: 9:00 AM - 8:00 PM')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Recent Reviews
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Reviews', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildReview('Rahul S.', 'Excellent quality products and fast delivery!', 5),
                  const Divider(),
                  _buildReview('Priya M.', 'Great customer service and reliable products.', 5),
                  const Divider(),
                  _buildReview('Amit K.', 'Best electrical supplier I have found.', 4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                  label: const Text('Contact Seller'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.store),
                  label: const Text('View Store'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildReview(String name, String comment, int rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Row(
                children: List.generate(5, (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                )),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(comment, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  const ProductDetail({required this.index, super.key});
  final int index;

  static const List<IconData> productIcons = [
    Icons.lightbulb, // Bulb
    Icons.cable, // Wire
    Icons.toggle_on, // Switch
    Icons.battery_full, // Battery
    Icons.build, // Tool
    Icons.speed, // Meter
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Product image/icon
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Icon(
                  productIcons[index % productIcons.length],
                  size: 100,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Title, price, rating
          Text('Superb ${kCategories[index % kCategories.length].label}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('₹${(index + 1) * 199}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: colorScheme.primary)),
              const SizedBox(width: 16),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star_half, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text('4.5', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('In Stock', style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // Seller info
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerProfilePage())),
            child: Card(
              color: colorScheme.surfaceVariant,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.store)),
                    const SizedBox(width: 12),
                    Expanded(child: Text('Sold by ElectricMart', style: Theme.of(context).textTheme.bodyMedium)),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Description
          Text('High quality ${kCategories[index % kCategories.length].label.toLowerCase()} for all your electrical needs. Reliable, safe, and energy efficient.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          // Specifications
          Card(
            color: colorScheme.surfaceVariant,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Specifications', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('• Voltage: 220V'),
                  Text('• Power: 20W'),
                  Text('• Warranty: 2 years'),
                  Text('• Brand: ElectricMart'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Add to cart button
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to cart'),
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String label;
  final IconData icon;
  Category(this.label, this.icon);
}

List<Category> kCategories = [
  Category('Bulbs', Icons.lightbulb),
  Category('Wires', Icons.cable),
  Category('Switches', Icons.toggle_on),
  Category('Batteries', Icons.battery_full),
  Category('Tools', Icons.build),
  Category('Meters', Icons.speed),
];