import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/products/models/product_model.dart';

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]); 

  void addToCart(Product product) {
    state = [...state, product]; 
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.id != product.id).toList(); // Filter out product by ID [B]
  }

  void clearCart() {
    state = []; 
  }

  double get totalCost {
    return state.fold(0, (sum, item) => sum + item.price); 
  }

  int get itemCount {
    return state.length; 
  }

  bool get isEmpty {
    return state.isEmpty; 
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier(); 
});

final cartTotalProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider); 
  return cartItems.fold(0, (sum, item) => sum + item.price); 
});

final cartItemCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider); 
  return cartItems.length; 
});
