import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/core/constants/app_theme.dart';
import 'package:havahavai/features/cart/domain/entities/cart_item.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/presentation/providers/cart_provider.dart';


class CartItemWidget extends ConsumerWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 80,
                      color: AppTheme.secondaryTextColor,
                    ),
              ),
            ),
            const SizedBox(width: 16),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.product.discountedPrice.toStringAsFixed(2)}',
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Qty: ${item.quantity}', style: AppTheme.subtitleStyle),
                ],
              ),
            ),
            // Quantity Controls
            Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    ref.read(cartProvider.notifier).state = ref
                        .read(manageCartProvider)
                        .updateQuantity(
                          ref.read(cartProvider),
                          item.product,
                          item.quantity + 1,
                        );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    ref.read(cartProvider.notifier).state = ref
                        .read(manageCartProvider)
                        .updateQuantity(
                          ref.read(cartProvider),
                          item.product,
                          item.quantity - 1,
                        );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension ProductExtension on Product {
  double get discountedPrice {
    return price * (1 - discountPercentage / 100);
  }
}
