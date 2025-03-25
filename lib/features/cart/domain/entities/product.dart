import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String? description;
  final double price;
  final double discountPercentage;
  final String thumbnail;
  final String? brand;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final String? returnPolicy;

  const Product({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
    this.brand,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.returnPolicy,
  });

  double get discountedPrice => price * (1 - discountPercentage / 100);

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    discountPercentage,
    thumbnail,
    brand,
    warrantyInformation,
    shippingInformation,
    availabilityStatus,
    returnPolicy,
  ];
}
