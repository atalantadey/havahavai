import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/presentation/providers/product_provider.dart';
import 'package:havahavai/features/cart/presentation/screens/catalog_screen.dart';


class MockProductListProvider {
  Future<List<Product>> call() {
    return Future.value([]);
  }
}

void main() {
  testWidgets('CatalogScreen displays products and allows navigation to cart', (
    WidgetTester tester,
  ) async {
    // Arrange: Mock the productListProvider to return test data
    final mockProducts = [
      Product(
        id: 1,
        title: "Essence Mascara Lash Princess",
        price: 9.99,
        discountPercentage: 7.17,
        thumbnail: "https://example.com/thumbnail.png",
      ),
      Product(
        id: 2,
        title: "iPhone 9",
        price: 549.0,
        discountPercentage: 12.96,
        thumbnail: "https://example.com/thumbnail2.png",
      ),
    ];

    // Override the productListProvider to return the mock products
    final container = ProviderContainer(
      overrides: [
        productListProvider(
          1,
        ).overrideWith((ref) => Future.value(mockProducts)),
        topDiscountedProductsProvider.overrideWith(
          (ref) => Future.value(mockProducts),
        ),
      ],
    );

    // Act: Build the CatalogScreen widget within a ProviderScope
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: CatalogScreen()),
      ),
    );

    // Wait for the widget to settle (since we're dealing with async data)
    await tester.pumpAndSettle();

    // Assert: Verify that the product titles are displayed
    expect(find.text("Essence Mascara Lash Princess"), findsOneWidget);
    expect(find.text("iPhone 9"), findsOneWidget);

    // Assert: Verify that the cart icon is present
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);

    // Act: Tap the cart icon to navigate to the CartScreen
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    // Assert: Verify that we navigated to the CartScreen
    expect(find.text("Cart"), findsOneWidget);
  });
}
