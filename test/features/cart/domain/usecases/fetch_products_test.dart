import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/domain/usecases/fetch_products.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.mocks.dart';
// Import the generated mocks

void main() {
  late FetchProducts fetchProducts;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    fetchProducts = FetchProducts(mockProductRepository);
  });

  const tSkip = 0;
  const tLimit = 10;
  final tProducts = [
    Product(
      id: 1,
      title: "Essence Mascara Lash Princess",
      price: 9.99,
      discountPercentage: 7.17,
      thumbnail: "https://example.com/thumbnail.png",
    ),
    Product(
      id: 2,
      title: "iPhone 9",
      price: 549.0,
      discountPercentage: 12.96,
      thumbnail: "https://example.com/thumbnail2.png",
    ),
  ];

  group('FetchProducts', () {
    test(
      'should return a list of products when the repository call is successful',
      () async {
        // Arrange
        when(
          mockProductRepository.fetchProducts(tSkip, tLimit),
        ).thenAnswer((_) async => Right(tProducts));

        // Act
        final result = await fetchProducts(tSkip, tLimit);

        // Assert
        expect(result, Right(tProducts));
        verify(mockProductRepository.fetchProducts(tSkip, tLimit)).called(1);
        verifyNoMoreInteractions(mockProductRepository);
      },
    );

    test('should return an Exception when the repository call fails', () async {
      // Arrange
      when(
        mockProductRepository.fetchProducts(tSkip, tLimit),
      ).thenAnswer((_) async => Left(Exception('Failed to fetch products')));

      // Act
      final result = await fetchProducts(tSkip, tLimit);

      // Assert
      expect(
        result,
        Left<Exception, List<Product>>(Exception('Failed to fetch products')),
      );
      verify(mockProductRepository.fetchProducts(tSkip, tLimit)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
