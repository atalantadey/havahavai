import 'package:dartz/dartz.dart';
import 'package:havahavai/features/cart/data/datasources/product_remote_datasource.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/domain/repositories/product_repositories.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, List<Product>>> fetchProducts(
    int skip,
    int limit,
  ) async {
    try {
      final products = await remoteDataSource.fetchProducts(skip, limit);
      return Right(products);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
