

// import 'package:ecommerce/services/favourite_service.dart';
import 'package:flutter/material.dart';
import 'package:login_app_test/core/services/favorite_service.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteService.getFavoriteItems();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];
          return ListTile(
            leading: Image.network(product.thumbnail, width: 50),
            title: Text(product.title),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}