import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/core/network/network_client.dart';
import 'package:havahavai/features/cart/data/datasources/product_remote_datasource.dart';
import 'package:havahavai/features/cart/data/repositories/product_repositories_impl.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/domain/usecases/fetch_products.dart';


final productRepositoryProvider = Provider(
  (ref) => ProductRepositoryImpl(ProductRemoteDataSourceImpl(NetworkClient())),
);

final fetchProductsProvider = Provider(
  (ref) => FetchProducts(ref.read(productRepositoryProvider)),
);

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  const limit = 100; // Fetch a large number of products to find top discounts
  const skip = 0;
  final fetchProducts = ref.read(fetchProductsProvider);
  final result = await fetchProducts(skip, limit);
  return result.fold((failure) => throw failure, (products) => products);
});

final topDiscountedProductsProvider = FutureProvider<List<Product>>((
  ref,
) async {
  final allProducts = await ref.watch(allProductsProvider.future);
  final sortedProducts = List<Product>.from(allProducts)
    ..sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
  return sortedProducts.take(5).toList(); // Take top 5 discounted products
});

final productListProvider = FutureProvider.family<List<Product>, int>((
  ref,
  page,
) async {
  const limit = 10;
  final skip = (page - 1) * limit;
  final fetchProducts = ref.read(fetchProductsProvider);
  final result = await fetchProducts(skip, limit);
  return result.fold((failure) => throw failure, (products) => products);
});
