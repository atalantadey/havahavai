import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/features/cart/domain/entities/cart_item.dart';
import 'package:havahavai/features/cart/presentation/providers/cart_provider.dart';


class CartListItem extends ConsumerWidget {
  final CartItem cartItem;

  const CartListItem({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = cartItem.product;
    return ListTile(
      leading: Image.network(product.thumbnail, width: 50, height: 50),
      title: Text(product.title),
      subtitle: Text('₹${product.discountedPrice.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              final manageCart = ref.read(manageCartProvider);
              ref.read(cartProvider.notifier).state = manageCart.updateQuantity(
                ref.read(cartProvider),
                product,
                cartItem.quantity - 1,
              );
            },
            icon: const Icon(Icons.remove),
          ),
          Text('${cartItem.quantity}'),
          IconButton(
            onPressed: () {
              final manageCart = ref.read(manageCartProvider);
              ref.read(cartProvider.notifier).state = manageCart.updateQuantity(
                ref.read(cartProvider),
                product,
                cartItem.quantity + 1,
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
