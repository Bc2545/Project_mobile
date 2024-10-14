import 'package:flutter/material.dart';
import 'product.dart'; // Import the Product class
import 'login.dart';

class ProductViewPage extends StatefulWidget {
  final VoidCallback logoutCallback;

  ProductViewPage({required this.logoutCallback});

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  final List<Product> products = [
    Product(
      name: 'iPhone 14',
      price: '\$999',
      imageUrl: 'https://example.com/iphone14.jpg',
    ),
    Product(
      name: 'Samsung Galaxy S21',
      price: '\$799',
      imageUrl: 'https://example.com/s21.jpg',
    ),
    Product(
      name: 'Google Pixel 6',
      price: '\$599',
      imageUrl: 'https://example.com/pixel6.jpg',
    ),
    // Add more products as needed
  ];

  List<Product> filteredProducts = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = products; // Initially, display all products
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = products
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(loginCallback: () {})),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              widget.logoutCallback();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage(loginCallback: () {})),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                labelText: 'Search Products',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(2.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return filteredProducts[index].buildProductCard(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
