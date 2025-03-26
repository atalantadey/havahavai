import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/core/constants/app_theme.dart';
import 'package:havahavai/features/cart/presentation/providers/cart_provider.dart';
import 'package:havahavai/features/cart/presentation/screens/cart_item_widget.dart';
import 'package:havahavai/features/cart/presentation/widgets/custom_checkout_button.dart';


class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(totalPriceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      backgroundColor: AppTheme.backgroundColor,
      body:
          cartItems.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: AppTheme.secondaryTextColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: AppTheme.headingStyle.copyWith(
                        color: AppTheme.secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add some products to get started!',
                      style: AppTheme.bodyStyle.copyWith(
                        color: AppTheme.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return CartItemWidget(item: item);
                      },
                    ),
                  ),
                  // Total Price and Checkout Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.1),
                          AppTheme.accentColor.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:', style: AppTheme.headingStyle),
                            Text(
                              '\$${totalPrice.toStringAsFixed(2)}',
                              style: AppTheme.headingStyle.copyWith(
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomCheckoutButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text('Checkout'),
                                    content: const Text(
                                      'Are you sure you want to checkout?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
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
                                            ),
                                          );
                                        },
                                        child: const Text('Confirm'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
