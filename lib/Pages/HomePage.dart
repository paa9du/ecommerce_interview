import 'package:ecommerce_interview/Sizes.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../DataModel.dart';
import 'CartPage.dart';
import 'HomePageContent.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The selected product variable
  Product? _selectedProduct;

  // Method to add a product to the cart
  void _addToCart(Product product) {
    setState(() {
      _selectedProduct = product;
    });
  }

  // Dropdown
  String selectedSortOption = 'Sort By';

  List<String> sortingOptions = [
    'Sort By',
    'Alphabetical',
    'Price: Low to High',
    'Price: High to Low',
  ];

  //bottom Navigation Bar
  int _currentIndex = 0;

  late List<Product> products = []; // Declare a list to store fetched products

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Call the method to fetch products when the widget initializes
  }

  Future<void> _fetchProducts() async {
    try {
      List<Product> fetchedProducts = await ApiProvider.fetchProducts();
      setState(() {
        products = fetchedProducts; // Update the products list
      });
    } catch (error) {
      // Handle error
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            const Text(
              'Xpress Shopping',
              style: TextStyle(
                fontSize: 22.0,
                color: Color.fromARGB(255, 112, 51, 233),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 30,
            ),
            child: Row(
              children: [
                const Text(
                  'Our Products',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20(context),
                ),
                DropdownButton<String>(
                  value: selectedSortOption,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.blue,
                  ),
                  iconSize: 24,
                  elevation: 10,
                  style: TextStyle(color: Colors.black),
                  isDense: false,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSortOption = newValue!;
                    });
                  },
                  items: sortingOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Container(
              height: 45,
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryItem('Sneekers'),
                    CategoryItem('Watches'),
                    CategoryItem('Jackets'),
                    CategoryItem('Shirts'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: HomePageContent(
                products: products, // Pass the fetched products
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
          if (index == 2 && _selectedProduct != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(
                  product: _selectedProduct!,
                ), // Replace YourCartPage with the actual page you want to navigate to
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.payment,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
