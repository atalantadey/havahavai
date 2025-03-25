import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/features/cart/domain/entities/cart_item.dart';
import 'package:havahavai/features/cart/domain/usecases/manage_cart.dart';

final cartProvider = StateProvider<List<CartItem>>((ref) => []);

final manageCartProvider = Provider((ref) => ManageCart());

final totalPriceProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(
    0,
    (sum, item) => sum + item.product.discountedPrice * item.quantity,
  );
});
