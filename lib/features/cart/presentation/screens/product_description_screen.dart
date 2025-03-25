import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/core/constants/app_colours.dart';
import 'package:havahavai/core/constants/app_styles.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/presentation/providers/cart_provider.dart';

class ProductDescriptionScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDescriptionScreen({required this.product, super.key});

  @override
  ConsumerState<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState
    extends ConsumerState<ProductDescriptionScreen> {
  String _selectedSize = '42';

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Image.network(product.thumbnail, fit: BoxFit.contain),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Brand
                  Text(
                    product.title,
                    style: AppStyles.titleStyle.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Brand: ${product.brand ?? 'Unknown'}',
                    style: AppStyles.subtitleStyle,
                  ),
                  const SizedBox(height: 8),
                  // Price and Discount
                  Row(
                    children: [
                      Text(
                        '₹${product.discountedPrice.toStringAsFixed(2)}',
                        style: AppStyles.priceStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹${product.price.toStringAsFixed(2)}',
                        style: AppStyles.strikethroughPriceStyle,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${product.discountPercentage}% OFF',
                        style: AppStyles.discountStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Select Size
                  Text('Select Size', style: AppStyles.titleStyle),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSizeOption('42'),
                      const SizedBox(width: 8),
                      _buildSizeOption('44'),
                      const SizedBox(width: 8),
                      _buildSizeOption('46'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text('Description', style: AppStyles.titleStyle),
                  const SizedBox(height: 8),
                  Text(
                    product.description ??
                        'No description available for this product.',
                    style: AppStyles.subtitleStyle,
                  ),
                  const SizedBox(height: 16),
                  // Additional Info
                  Text('Additional Information', style: AppStyles.titleStyle),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Warranty',
                    product.warrantyInformation ?? 'N/A',
                  ),
                  _buildInfoRow(
                    'Shipping',
                    product.shippingInformation ?? 'N/A',
                  ),
                  _buildInfoRow(
                    'Availability',
                    product.availabilityStatus ?? 'N/A',
                  ),
                  _buildInfoRow('Return Policy', product.returnPolicy ?? 'N/A'),
                  const SizedBox(height: 16),
                  // Add to Cart Button
                  ElevatedButton(
                    onPressed: () {
                      final manageCart = ref.read(manageCartProvider);
                      ref.read(cartProvider.notifier).state = manageCart
                          .addToCart(ref.read(cartProvider), product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.title} added to cart!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppStyles.subtitleStyle),
          Text(value, style: AppStyles.subtitleStyle),
        ],
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = size;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedSize == size ? AppColors.accent : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          size,
          style: AppStyles.subtitleStyle.copyWith(
            color: _selectedSize == size ? AppColors.accent : Colors.black,
          ),
        ),
      ),
    );
  }
}
