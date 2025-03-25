import 'package:equatable/equatable.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.discountedPrice * quantity;

  @override
  List<Object?> get props => [product, quantity];
}
