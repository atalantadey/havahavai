import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:havahavai/features/cart/domain/entities/cart_item.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/presentation/providers/cart_provider.dart';


void main() {
  late ProviderContainer container;

  setUp(() {
    // Create a new ProviderContainer for each test
    container = ProviderContainer();
  });

  tearDown(() {
    // Dispose of the container after each test
    container.dispose();
  });

  final tProduct = Product(
    id: 1,
    title: "Essence Mascara Lash Princess",
    price: 9.99,
    discountPercentage: 7.17,
    thumbnail: "https://example.com/thumbnail.png",
  );

  final tCartItem = CartItem(product: tProduct, quantity: 1);

  group('CartProvider', () {
    test('should add a product to the cart', () {
      // Arrange
      final manageCart = container.read(manageCartProvider);

      // Act
      container.read(cartProvider.notifier).state = manageCart.addToCart(
        container.read(cartProvider),
        tProduct,
      );

      // Assert
      expect(container.read(cartProvider), [tCartItem]);
    });

    test('should update quantity of a product in the cart', () {
      // Arrange
      container.read(cartProvider.notifier).state = [tCartItem];
      final manageCart = container.read(manageCartProvider);

      // Act
      container.read(cartProvider.notifier).state = manageCart.updateQuantity(
        container.read(cartProvider),
        tProduct,
        3,
      );

      // Assert
      expect(container.read(cartProvider), [
        CartItem(product: tProduct, quantity: 3),
      ]);
    });

    test('should calculate the total price correctly', () {
      // Arrange
      container.read(cartProvider.notifier).state = [
        CartItem(
          product: tProduct,
          quantity: 2,
        ), // Discounted price: 9.99 * (1 - 7.17/100) = 9.27
      ];

      // Act
      final totalPrice = container.read(totalPriceProvider);

      // Assert
      final expectedPrice = 9.27 * 2; // 18.54
      expect(totalPrice, closeTo(expectedPrice, 0.01));
    });
  });
}
