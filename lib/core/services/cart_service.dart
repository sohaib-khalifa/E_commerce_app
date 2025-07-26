import 'package:login_app_test/features/products/models/product_model.dart';

class CartService {
  static final List<Product> _cartItems = [];

  static void addToCart(Product product) {
    _cartItems.add(product);
  }

  static void removeFromCart(Product product) {
    _cartItems.remove(product);
  }

  static List<Product> getCartItems() {
    return _cartItems;
  }

  static void clearCart() {
    _cartItems.clear();
  }
}
