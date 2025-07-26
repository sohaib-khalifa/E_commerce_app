


import 'dart:ui';

// import 'package:ecommerce/model/model.dart';
// import 'package:ecommerce/services/cart_service.dart';
// import 'package:ecommerce/services/favourite_service.dart';
// import 'package:ecommerce/services/product_dio.dart';
// import 'package:ecommerce/view/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:login_app_test/core/services/cart_service.dart';
import 'package:login_app_test/core/services/dio_service.dart';
import 'package:login_app_test/core/services/favorite_service.dart';
import 'package:login_app_test/features/products/models/product_model.dart';
import 'package:login_app_test/features/products/view/details_screen.dart';

class CategoryProductsPage extends StatefulWidget {
  final String categoryName;

  const CategoryProductsPage({super.key, required this.categoryName});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
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
        errorMessage = 'Failed to load products: \$e';
        isLoading = false;
      });
    }
  }

  void addToCart(Product product) {
  CartService.addToCart(product);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('${product.title} added to cart')),
  );
}

void addToFavorite(Product product) {
  setState(() {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      FavoriteService.addToFavorites(product);
    } else {
      FavoriteService.removeFromFavorites(product);
    }
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        product.isFavorite
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: filterProducts,
                      ),
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(
                          scrollbars: false,
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: displayedProducts.length,
                        itemBuilder: (context, index) {
                      final product = displayedProducts[index];

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
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
  icon: Icon(
    product.isFavorite ? Icons.favorite : Icons.favorite_border,
    color: product.isFavorite ? Colors.red : null,
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
}
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
