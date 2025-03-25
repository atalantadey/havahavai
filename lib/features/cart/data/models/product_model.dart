

import 'package:havahavai/features/cart/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    super.description,
    required super.price,
    required super.discountPercentage,
    required super.thumbnail,
    super.brand,
    super.warrantyInformation,
    super.shippingInformation,
    super.availabilityStatus,
    super.returnPolicy,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      brand: json['brand'],
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      returnPolicy: json['returnPolicy'],
    );
  }
}
