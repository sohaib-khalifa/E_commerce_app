import 'package:login_app_test/features/products/models/product_model.dart';
import 'package:login_app_test/features/products/models/realm_product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

/// 1. Realm Model
@RealmModel()
class _RealmProduct {
  late int id;
  late String title;
  late double price;
  late String thumbnail;
  late String category;
}

/// 2. Realm Provider
final realmProvider = Provider<Realm>((ref) {
  final config = Configuration.local([RealmProduct.schema]);
  return Realm(config);
});

/// 3. Cart Provider
final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    if (!state.any((p) => p.id == product.id)) {
      state = [...state, product];
    }
  }

  void removeFromCart(int productId) {
    state = state.where((p) => p.id != productId).toList();
  }

  void clearCart() {
    state = [];
  }
}

/// 4. Favorites Provider
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Product product) {
    final isFavorite = state.any((p) => p.id == product.id);
    if (isFavorite) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isFavorite(Product product) {
    return state.any((p) => p.id == product.id);
  }

  void clearFavorites() {
    state = [];
  }
}
