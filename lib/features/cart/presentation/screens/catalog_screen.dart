import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahavai/core/constants/app_colours.dart';
import 'package:havahavai/core/constants/app_styles.dart';
import 'package:havahavai/features/cart/domain/entities/product.dart';
import 'package:havahavai/features/cart/presentation/providers/product_provider.dart';
import 'package:havahavai/features/cart/presentation/screens/cart_screen.dart';
import 'package:havahavai/features/cart/presentation/widgets/discount_carousel.dart';
import 'package:havahavai/features/cart/presentation/widgets/product_list_item.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  int _page = 1;
  final ScrollController _scrollController = ScrollController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  String _searchQuery = '';
  String _sortOption = 'Default'; // Default, High to Low, Low to High

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
      }
    });
  }

  Future<void> _refreshProducts(WidgetRef ref) async {
    setState(() {
      _page = 1;
      _allProducts = [];
      _filteredProducts = [];
      _searchQuery = '';
      _sortOption = 'Default';
    });
    ref.refresh(productListProvider(_page));
  }

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredProducts = List.from(_allProducts);
      } else {
        _filteredProducts =
            _allProducts
                .where(
                  (product) =>
                      product.title.toLowerCase().contains(_searchQuery) ||
                      (product.brand?.toLowerCase().contains(_searchQuery) ??
                          false),
                )
                .toList();
      }
      _sortProducts();
    });
  }

  void _sortProducts() {
    setState(() {
      if (_sortOption == 'High to Low') {
        _filteredProducts.sort(
          (a, b) => b.discountedPrice.compareTo(a.discountedPrice),
        );
      } else if (_sortOption == 'Low to High') {
        _filteredProducts.sort(
          (a, b) => a.discountedPrice.compareTo(b.discountedPrice),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productListAsync = ref.watch(productListProvider(_page));
    final topDiscountedAsync = ref.watch(topDiscountedProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(ref),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: _filterProducts,
                ),
              ),
            ),
            // Carousel
            SliverToBoxAdapter(
              child: topDiscountedAsync.when(
                data: (topProducts) => DiscountCarousel(products: topProducts),
                loading:
                    () => const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                error:
                    (error, _) => SizedBox(
                      height: 200,
                      child: Center(child: Text('Error: $error')),
                    ),
              ),
            ),
            // Sort Option
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Most Popular',
                      style: AppStyles.titleStyle.copyWith(fontSize: 20),
                    ),
                    DropdownButton<String>(
                      value: _sortOption,
                      items:
                          ['Default', 'High to Low', 'Low to High']
                              .map(
                                (option) => DropdownMenuItem(
                                  value: option,
                                  child: Text(option),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _sortOption = value!;
                          _sortProducts();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Product Grid
            productListAsync.when(
              data: (products) {
                // Remove duplicates by checking product IDs
                for (var product in products) {
                  if (!_allProducts.any((p) => p.id == product.id)) {
                    _allProducts.add(product);
                  }
                }
                _filteredProducts =
                    _searchQuery.isEmpty
                        ? List.from(_allProducts)
                        : _allProducts
                            .where(
                              (product) =>
                                  product.title.toLowerCase().contains(
                                    _searchQuery,
                                  ) ||
                                  (product.brand?.toLowerCase().contains(
                                        _searchQuery,
                                      ) ??
                                      false),
                            )
                            .toList();
                _sortProducts();
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == _filteredProducts.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ProductListItem(product: _filteredProducts[index]);
                  }, childCount: _filteredProducts.length + 1),
                );
              },
              loading:
                  () => const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
              error:
                  (error, _) => SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: $error'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _refreshProducts(ref),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
