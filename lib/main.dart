import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bag',
      home: MyBagPage(),
    );
  }
}

// Stateful widget to handle dynamic data
class MyBagPage extends StatefulWidget {
  @override
  _MyBagPageState createState() => _MyBagPageState();
}

class _MyBagPageState extends State<MyBagPage> {
  // Sample list of products
  List<Product> products = [
    Product(
        title: 'Product 1',
        color: 'Red',
        size: 'XL',
        price: 15.0,
        quantity: 1,
        imageUrl: 'https://via.placeholder.com/80'),
    Product(
        title: 'Product 2',
        color: 'Blue',
        size: 'L',
        price: 20.0,
        quantity: 1,
        imageUrl: 'https://via.placeholder.com/80'),
    Product(
        title: 'Product 3',
        color: 'Green',
        size: 'M',
        price: 25.0,
        quantity: 1,
        imageUrl: 'https://via.placeholder.com/80'),
  ];

  // Calculate total amount
  double get totalAmount {
    return products.fold(
        0.0, (sum, item) => sum + item.price * item.quantity);
  }

  // Increase product quantity
  void _increaseQuantity(int index) {
    setState(() {
      products[index].quantity++;
    });
  }

  // Decrease product quantity
  void _decreaseQuantity(int index) {
    setState(() {
      if (products[index].quantity > 1) {
        products[index].quantity--;
      }
    });
  }

  // Display snackbar on checkout
  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Congratulations on your purchase!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: Column(
        children: [
          // Product list
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductRow(index);
              },
            ),
          ),
          // Total amount and checkout button
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18)),
                ElevatedButton(
                  onPressed: _checkout,
                  child: Text('CHECK OUT'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build each product row
  Widget _buildProductRow(int index) {
    Product product = products[index];
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          // First column: Product image
          Image.network(product.imageUrl, width: 80, height: 80),
          SizedBox(width: 8),
          // Second column: Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product title
                Text(product.title,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                // Color and size
                Row(
                  children: [
                    Text('Color: ${product.color}',
                        style: TextStyle(fontSize: 14)),
                    SizedBox(width: 16),
                    Text('Size: ${product.size}',
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(height: 4),
                // Quantity controls
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _decreaseQuantity(index),
                    ),
                    Text('${product.quantity}',
                        style: TextStyle(fontSize: 16)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _increaseQuantity(index),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Third column: More options and price
          Column(
            children: [
              Icon(Icons.more_vert),
              SizedBox(height: 16),
              Text('\$${product.price}',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

// Product model
class Product {
  String title;
  String color;
  String size;
  double price;
  int quantity;
  String imageUrl;

  Product({
    required this.title,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}