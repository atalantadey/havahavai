import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/core/constants/app_colours.dart';
import 'package:havahavai/core/constants/app_styles.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/presentation/providers/cart_provider.dart';
import 'package:havahavai/features/cart/presentation/screens/product_description_screen.dart';

class ProductListItem extends ConsumerStatefulWidget {
  final Product product;

  const ProductListItem({required this.product, super.key});

  @override
  ConsumerState<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends ConsumerState<ProductListItem> {
  bool _isAdding = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDescriptionScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 2,
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: AppStyles.titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (product.brand != null) ...[
                    const SizedBox(height: 4),
                    Text(product.brand!, style: AppStyles.subtitleStyle),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹${product.price.toStringAsFixed(2)}',
                            style: AppStyles.strikethroughPriceStyle,
                          ),
                          Text(
                            '₹${product.discountedPrice.toStringAsFixed(2)}',
                            style: AppStyles.priceStyle,
                          ),
                        ],
                      ),
                      Text(
                        '${product.discountPercentage}% OFF',
                        style: AppStyles.discountStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AnimatedOpacity(
                    opacity: _isAdding ? 0.5 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isAdding = true;
                        });
                        final manageCart = ref.read(manageCartProvider);
                        ref.read(cartProvider.notifier).state = manageCart
                            .addToCart(ref.read(cartProvider), product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        Future.delayed(const Duration(milliseconds: 300), () {
                          setState(() {
                            _isAdding = false;
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        minimumSize: const Size(double.infinity, 36),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
