
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/cart/providers/cart_provider.dart';
import 'package:login_app_test/features/products/models/product_model.dart';

// Cart screen using Riverpod for state management [B]
class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch cart items from provider [B]
    final cartItems = ref.watch(cartProvider);
    // Watch cart total from provider [B]
    final totalCost = ref.watch(cartTotalProvider);

    // Handle checkout process [B]
    void checkout() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Checkout Complete'),
          content: Text('You have purchased ${cartItems.length} items for \$${totalCost.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart(); // Clear cart using provider [B]
                Navigator.pop(context); // Close dialog [B]
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    // Handle item removal [B]
    void removeItem(Product product) {
      ref.read(cartProvider.notifier).removeFromCart(product); // Remove item using provider [B]
    }

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
                          onPressed: () => removeItem(product), // Remove item on tap [B]
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
                        onPressed: checkout, // Handle checkout [B]
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