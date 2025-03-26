import 'package:flutter_test/flutter_test.dart';
import 'package:havahavai/features/cart/domain/entities/cart_item.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/domain/usecases/manage_cart.dart';


void main() {
  late ManageCart manageCart;

  setUp(() {
    manageCart = ManageCart();
  });

  final tProduct = Product(
    id: 1,
    title: "Essence Mascara Lash Princess",
    price: 9.99,
    discountPercentage: 7.17,
    thumbnail: "https://example.com/thumbnail.png",
  );

  final tCartItem = CartItem(product: tProduct, quantity: 1);

  group('ManageCart', () {
    test('should add a new product to an empty cart', () {
      // Arrange
      final cart = <CartItem>[];

      // Act
      final result = manageCart.addToCart(cart, tProduct);

      // Assert
      expect(result, [tCartItem]);
    });

    test('should increment quantity if the product is already in the cart', () {
      // Arrange
      final cart = [tCartItem];

      // Act
      final result = manageCart.addToCart(cart, tProduct);

      // Assert
      expect(result, [CartItem(product: tProduct, quantity: 2)]);
    });

    test('should update quantity of a product in the cart', () {
      // Arrange
      final cart = [CartItem(product: tProduct, quantity: 2)];

      // Act
      final result = manageCart.updateQuantity(cart, tProduct, 3);

      // Assert
      expect(result, [CartItem(product: tProduct, quantity: 3)]);
    });

    test('should remove a product from the cart if quantity is set to 0', () {
      // Arrange
      final cart = [tCartItem];

      // Act
      final result = manageCart.updateQuantity(cart, tProduct, 0);

      // Assert
      expect(result, <CartItem>[]);
    });
  });
}
