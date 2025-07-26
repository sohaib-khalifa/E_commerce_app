import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/cart/providers/cart_provider.dart';

// Reusable cart badge widget with item count [B]
class CartBadgeWidget extends ConsumerWidget {
  final Widget child; // The widget to wrap with badge [B]
  final VoidCallback? onTap; // Optional tap callback [B]

  const CartBadgeWidget({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch cart items count for badge [B]
    final cartItemCount = ref.watch(cartItemCountProvider);

    return GestureDetector(
      onTap: onTap, // Handle tap if provided [B]
      child: Stack(
        children: [
          child, // Display the wrapped widget [B]
          // Show badge only if cart has items [B]
          if (cartItemCount > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$cartItemCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
} 