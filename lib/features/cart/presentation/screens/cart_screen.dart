import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/core/constants/app_colours.dart';
import 'package:havahavai/core/constants/app_styles.dart';
import 'package:havahavai/features/cart/presentation/providers/cart_provider.dart';
import 'package:havahavai/features/cart/presentation/widgets/cart_list_item.dart';


class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(totalPriceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Expanded(
            child:
                cartItems.isEmpty
                    ? const Center(child: Text('Your cart is empty'))
                    : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartListItem(cartItem: cartItems[index]);
                      },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price: ₹${totalPrice.toStringAsFixed(2)}',
                  style: AppStyles.titleStyle.copyWith(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed:
                      cartItems.isEmpty
                          ? null
                          : () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text('Confirm Checkout'),
                                    content: Text(
                                      'Are you sure you want to checkout with a total of ₹${totalPrice.toStringAsFixed(2)}?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          ref
                                              .read(cartProvider.notifier)
                                              .state = [];
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Checkout successful!',
                                              ),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.accent,
                                        ),
                                        child: const Text('Confirm'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                  ),
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
