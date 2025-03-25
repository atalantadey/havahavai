import 'package:dartz/dartz.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';


abstract class ProductRepository {
  Future<Either<Exception, List<Product>>> fetchProducts(int skip, int limit);
}
