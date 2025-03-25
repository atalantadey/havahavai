import 'package:havahavai/features/cart/domain/entities/cart_item.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';

class ManageCart {
  List<CartItem> addToCart(List<CartItem> cart, Product product) {
    final existingItemIndex = cart.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingItemIndex != -1) {
      final updatedItem = CartItem(
        product: cart[existingItemIndex].product,
        quantity: cart[existingItemIndex].quantity + 1,
      );
      return [
        ...cart.sublist(0, existingItemIndex),
        updatedItem,
        ...cart.sublist(existingItemIndex + 1),
      ];
    } else {
      return [...cart, CartItem(product: product)];
    }
  }

  List<CartItem> updateQuantity(
    List<CartItem> cart,
    Product product,
    int quantity,
  ) {
    final itemIndex = cart.indexWhere((item) => item.product.id == product.id);
    if (itemIndex != -1) {
      if (quantity <= 0) {
        return [...cart.sublist(0, itemIndex), ...cart.sublist(itemIndex + 1)];
      }
      final updatedItem = CartItem(product: product, quantity: quantity);
      return [
        ...cart.sublist(0, itemIndex),
        updatedItem,
        ...cart.sublist(itemIndex + 1),
      ];
    }
    return cart;
  }
}
