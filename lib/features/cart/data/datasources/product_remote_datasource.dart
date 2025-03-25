import 'dart:convert';
import 'package:havahavai/core/network/network_client.dart';
import 'package:havahavai/features/cart/data/models/product_model.dart';
//import 'package:http/http.dart' as http;


abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts(int skip, int limit);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final NetworkClient networkClient;

  ProductRemoteDataSourceImpl(this.networkClient);

  @override
  Future<List<ProductModel>> fetchProducts(int skip, int limit) async {
    final response = await networkClient.get(
      '/products?limit=$limit&skip=$skip',
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final products =
          (data['products'] as List)
              .map((json) => ProductModel.fromJson(json))
              .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
