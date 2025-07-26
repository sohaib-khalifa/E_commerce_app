import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/products/models/product_model.dart';

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  // Add product to favorites [B]
  void addToFavorites(Product product) {
    if (!state.any((item) => item.id == product.id)) { 
      state = [...state, product]; 
    }
  }

  void removeFromFavorites(Product product) {
    state = state.where((item) => item.id != product.id).toList(); // Filter out product by ID [B]
  }

  void clearFavorites() {
    state = []; 
  }

  bool isFavorite(Product product) {
    return state.any((item) => item.id == product.id); 
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) { 
      removeFromFavorites(product);
    } else { 
      addToFavorites(product);
    }
  }

  int get favoritesCount {
    return state.length; 
  }

  bool get isEmpty {
    return state.isEmpty; 
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier(); 
});

final favoritesCountProvider = Provider<int>((ref) {
  final favorites = ref.watch(favoritesProvider); 
  return favorites.length; 
});

final isFavoriteProvider = Provider.family<bool, Product>((ref, product) {
  final favorites = ref.watch(favoritesProvider); 
  return favorites.any((item) => item.id == product.id); 
});
