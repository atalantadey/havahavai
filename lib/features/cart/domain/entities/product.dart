import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  final String thumbnail;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
  });

  double get discountedPrice => price * (1 - discountPercentage / 100);

  @override
  List<Object?> get props => [id, title, price, discountPercentage, thumbnail];
}
