import 'package:havahavai/features/cart/data/models/product_model.dart';
import 'package:havahavai/features/cart/domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({required ProductModel super.product, super.quantity});
}
