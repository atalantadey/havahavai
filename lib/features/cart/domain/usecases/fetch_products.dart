import 'package:dartz/dartz.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/domain/repositories/product_repositories.dart';

class FetchProducts {
  final ProductRepository repository;
  FetchProducts(this.repository);
  Future<Either<Exception, List<Product>>> call(int skip, int limit) async {
    return await repository.fetchProducts(skip, limit);
  }
}