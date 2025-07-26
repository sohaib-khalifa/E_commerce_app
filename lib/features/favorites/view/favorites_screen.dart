

// import 'package:ecommerce/services/favourite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/favorites/providers/favorites_provider.dart';

// Favorites screen using Riverpod for state management [B]
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch favorites items from provider [B]
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet')) // Show message when empty [B]
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.network(product.thumbnail, width: 50),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red), // Show filled heart [B]
                    onPressed: () {
                      // Remove from favorites on tap [B]
                      ref.read(favoritesProvider.notifier).removeFromFavorites(product);
                    },
                  ),
                );
              },
            ),
    );
  }
}