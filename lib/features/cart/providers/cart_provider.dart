import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/products/models/product_model.dart';

// State notifier class to manage cart state and operations [B]
class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]); // Initialize with empty cart [B]

  // Add product to cart [B]
  void addToCart(Product product) {
    state = [...state, product]; // Create new list with added product [B]
  }

  // Remove product from cart [B]
  void removeFromCart(Product product) {
    state = state.where((item) => item.id != product.id).toList(); // Filter out product by ID [B]
  }

  // Clear entire cart [B]
  void clearCart() {
    state = []; // Reset to empty list [B]
  }

  // Calculate total cost of all items in cart [B]
  double get totalCost {
    return state.fold(0, (sum, item) => sum + item.price); // Sum all product prices [B]
  }

  // Get cart items count [B]
  int get itemCount {
    return state.length; // Return number of items [B]
  }

  // Check if cart is empty [B]
  bool get isEmpty {
    return state.isEmpty; // Return true if no items [B]
  }
}

// Provider instance for cart state management [B]
final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier(); // Create and return cart notifier instance [B]
});

// Provider for cart total cost [B]
final cartTotalProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider); // Watch cart items changes [B]
  return cartItems.fold(0, (sum, item) => sum + item.price); // Calculate total [B]
});

// Provider for cart items count [B]
final cartItemCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider); // Watch cart items changes [B]
  return cartItems.length; // Return count [B]
});
