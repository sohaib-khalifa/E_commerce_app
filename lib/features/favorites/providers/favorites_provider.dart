import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/products/models/product_model.dart';

// State notifier class to manage favorites state and operations [B]
class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]); // Initialize with empty favorites list [B]

  // Add product to favorites [B]
  void addToFavorites(Product product) {
    if (!state.any((item) => item.id == product.id)) { // Check if product not already in favorites [B]
      state = [...state, product]; // Add product to favorites list [B]
    }
  }

  // Remove product from favorites [B]
  void removeFromFavorites(Product product) {
    state = state.where((item) => item.id != product.id).toList(); // Filter out product by ID [B]
  }

  // Clear all favorites [B]
  void clearFavorites() {
    state = []; // Reset to empty list [B]
  }

  // Check if product is in favorites [B]
  bool isFavorite(Product product) {
    return state.any((item) => item.id == product.id); // Check if product exists in favorites [B]
  }

  // Toggle favorite status of product [B]
  void toggleFavorite(Product product) {
    if (isFavorite(product)) { // If already favorite, remove it [B]
      removeFromFavorites(product);
    } else { // If not favorite, add it [B]
      addToFavorites(product);
    }
  }

  // Get favorites count [B]
  int get favoritesCount {
    return state.length; // Return number of favorite items [B]
  }

  // Check if favorites list is empty [B]
  bool get isEmpty {
    return state.isEmpty; // Return true if no favorites [B]
  }
}

// Provider instance for favorites state management [B]
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier(); // Create and return favorites notifier instance [B]
});

// Provider for favorites count [B]
final favoritesCountProvider = Provider<int>((ref) {
  final favorites = ref.watch(favoritesProvider); // Watch favorites changes [B]
  return favorites.length; // Return count [B]
});

// Provider to check if a specific product is favorite [B]
final isFavoriteProvider = Provider.family<bool, Product>((ref, product) {
  final favorites = ref.watch(favoritesProvider); // Watch favorites changes [B]
  return favorites.any((item) => item.id == product.id); // Check if product is in favorites [B]
});
