


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/core/services/dio_service.dart';
import 'package:login_app_test/features/cart/providers/cart_provider.dart';
import 'package:login_app_test/features/favorites/providers/favorites_provider.dart';
import 'package:login_app_test/features/products/models/product_model.dart';
import 'package:login_app_test/features/products/view/details_screen.dart';

class CategoryProductsPage extends ConsumerStatefulWidget {
  final String categoryName;

  const CategoryProductsPage({super.key, required this.categoryName});

  @override
  ConsumerState<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends ConsumerState<CategoryProductsPage> {
  List<Product> allProducts = [];
  List<Product> displayedProducts = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadProductsByCategory();
  }

  Future<void> loadProductsByCategory() async {
    try {
      final response = await DioService.get(
        'https://dummyjson.com/products/category/${widget.categoryName}',
      );
      final List<dynamic> data = response.data['products'];

      setState(() {
        allProducts = data.map((json) => Product.fromJson(json)).toList();
        displayedProducts = allProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load products: $e';
        isLoading = false;
      });
    }
  }

  void addToCart(Product product) {
    ref.read(cartProvider.notifier).addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title} added to cart')),
    );
  }

  void addToFavorite(Product product) {
    ref.read(favoritesProvider.notifier).toggleFavorite(product);
    final isFavorite = ref.read(favoritesProvider.notifier).isFavorite(product);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? '${product.title} added to favorites'
              : '${product.title} removed from favorites',
        ),
      ),
    );
  }

  void filterProducts(String query) {
    setState(() {
      displayedProducts = allProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterProducts,
              decoration: const InputDecoration(
                labelText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : displayedProducts.isEmpty
                        ? const Center(child: Text('No products found'))
                        : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: displayedProducts.length,
                            itemBuilder: (context, index) {
                              final product = displayedProducts[index];
                              final isFavorite = favorites.any((p) => p.id == product.id);
                              
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Details(product: product),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          product.thumbnail,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          product.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Text('\$${product.price.toStringAsFixed(2)}'),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              isFavorite ? Icons.favorite : Icons.favorite_border,
                                              color: isFavorite ? Colors.red : null,
                                            ),
                                            onPressed: () => addToFavorite(product),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.shopping_cart_outlined),
                                            onPressed: () => addToCart(product),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
