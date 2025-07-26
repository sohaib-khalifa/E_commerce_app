
import 'package:flutter/material.dart';
import 'package:login_app_test/core/services/cart_service.dart';
import 'package:login_app_test/features/products/models/product_model.dart';
// import 'package:ecommerce/services/cart_service.dart';
// import 'package:ecommerce/model/model.dart';



 List<Product> cartItems = [];

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
 

  @override
  void initState() {
    super.initState();
    cartItems = CartService.getCartItems();
  }

  double get totalCost {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  void checkout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Checkout Complete'),
        content: Text('You have purchased ${cartItems.length} items for \$${totalCost.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () {
              CartService.clearCart();
              Navigator.pop(context); // Close dialog
              setState(() {
                cartItems = [];
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void removeItem(Product product) {
    setState(() {
      CartService.removeFromCart(product);
      cartItems = CartService.getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return ListTile(
                        leading: Image.network(product.thumbnail, width: 50),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => removeItem(product),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${totalCost.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: checkout,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        ),
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),  
    );
  }
}