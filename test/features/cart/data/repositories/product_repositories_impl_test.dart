import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:havahavai/features/cart/data/models/product_model.dart';
import 'package:havahavai/features/cart/data/repositories/product_repositories_impl.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.mocks.dart';


void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    repository = ProductRepositoryImpl(mockRemoteDataSource);
  });

  const tSkip = 0;
  const tLimit = 10;
  final tProductModels = [
    ProductModel(
      id: 1,
      title: "Essence Mascara Lash Princess",
      price: 9.99,
      discountPercentage: 7.17,
      thumbnail: "https://example.com/thumbnail.png",
    ),
    ProductModel(
      id: 2,
      title: "iPhone 9",
      price: 549.0,
      discountPercentage: 12.96,
      thumbnail: "https://example.com/thumbnail2.png",
    ),
  ];

  group('ProductRepositoryImpl', () {
    test(
      'should return a list of products when the data source call is successful',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.fetchProducts(tSkip, tLimit),
        ).thenAnswer((_) async => tProductModels);

        // Act
        final result = await repository.fetchProducts(tSkip, tLimit);

        // Assert
        expect(result, Right(tProductModels));
        verify(mockRemoteDataSource.fetchProducts(tSkip, tLimit)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return an Exception when the data source call fails',
      () async {
        // Arrange
        when(
          mockRemoteDataSource.fetchProducts(tSkip, tLimit),
        ).thenThrow(Exception('Failed to fetch products'));

        // Act
        final result = await repository.fetchProducts(tSkip, tLimit);

        // Assert
        expect(
          result,
          Left<Exception, List<Product>>(Exception('Failed to fetch products')),
        );
        verify(mockRemoteDataSource.fetchProducts(tSkip, tLimit)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}
