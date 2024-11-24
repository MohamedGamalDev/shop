import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'product.dart';
import 'product_data.dart';
import 'SettingsProvider.dart';
import 'settings.dart';
import 'order.dart';
import 'cart_page.dart';
import 'package:provider/provider.dart';

class Page1 extends StatefulWidget {
  static const String route = 'Page1';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Page1> {
  late List<Product> filteredProducts;
  late List<OrderItem> selectedItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    selectedItems = [];
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products
          .where((product) => product.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _addToCart(Product product, int quantity) {
    if (quantity > 0) {
      setState(() {
        selectedItems.add(OrderItem(productName: product.name, quantity: quantity, price: product.price));
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/palestine2.jpg',
                height: 40,
                width: 50,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 5),
            Text(
              'Ghazawi Shop',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsPage.route);
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, CartPage.route, arguments: selectedItems);
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                provider.isDark ? AppTheme.white : AppTheme.darkPrimary,
                provider.isDark ? AppTheme.gray : AppTheme.lightPrimary.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: AppTheme.darkPrimary),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              provider.isDark ? AppTheme.white : AppTheme.lightPrimary,
              provider.isDark ? AppTheme.gray : AppTheme.darkPrimary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Products',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 3,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final TextEditingController quantityController = TextEditingController();

                  return GridTile(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/${product.image}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          product.name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.black),
                        ),
                        Text(
                          'Price: \$${product.price}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: quantityController,
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                  labelStyle: TextStyle(color: AppTheme.darkPrimary),
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(1, 2, 1, 2),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent.withOpacity(0.2),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                                ),
                                onPressed: () {
                                  int quantity = int.tryParse(quantityController.text) ?? 0;
                                  _addToCart(product, quantity);
                                },
                                child: Text('Add to Cart', style: TextStyle(fontSize: 16)),
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
