import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/cart/providers/cart_provider.dart';
import 'package:login_app_test/features/cart/view/cart_screen.dart';
import 'package:login_app_test/features/favorites/view/favorites_screen.dart';

// لازم تضيف الصفحات دي
// import 'package:login_app_test/features/favourite/view/favourite_screen.dart';
// import 'package:login_app_test/features/cart/view/cart_page.dart';

class CustomButtonBar extends ConsumerWidget {
  const CustomButtonBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartItemCountProvider);

    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 16, 78, 129),
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'favourite',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart),
              if (cartCount > 0)
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          label: 'Cart',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FavoritesPage()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartPage()),
          );
        }
      },
    );
  }
}

