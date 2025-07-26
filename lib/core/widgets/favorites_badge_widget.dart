import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_app_test/features/favorites/providers/favorites_provider.dart';

// Reusable favorites badge widget with count [B]
class FavoritesBadgeWidget extends ConsumerWidget {
  final Widget child; // The widget to wrap with badge [B]
  final VoidCallback? onTap; // Optional tap callback [B]

  const FavoritesBadgeWidget({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch favorites count for badge [B]
    final favoritesCount = ref.watch(favoritesCountProvider);

    return GestureDetector(
      onTap: onTap, // Handle tap if provided [B]
      child: Stack(
        children: [
          child, // Display the wrapped widget [B]
          // Show badge only if there are favorites [B]
          if (favoritesCount > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$favoritesCount',
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