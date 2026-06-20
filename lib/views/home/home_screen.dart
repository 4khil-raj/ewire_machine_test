import 'package:ewire_machine_test/controller/bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeScreenBloc>(context).add(LoadProductsEvent());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Shopefy'),
      body: SafeArea(
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            if (state is fetchedHomeScreenDatasState) {
              final filteredProducts = state.products.where((product) {
                final matchesCategory =
                    selectedCategory == 'All' ||
                    product.category == selectedCategory;
                final matchesSearch =
                    product.title.toString().toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ) ||
                    product.toString().toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    );
                return matchesCategory && matchesSearch;
              }).toList();
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Search Bar Section
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: CustomSearchBar(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(10),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  'assets/images/banner_promo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withAlpha(102),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(51),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Limited Time',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Get Up To\n50% OFF',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 20,
                      bottom: 8,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final cat = state.categories[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CategoryChip(
                              label: cat,
                              isSelected: selectedCategory == cat,
                              onTap: () {
                                setState(() {
                                  selectedCategory = cat;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 24,
                      bottom: 12,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Popular Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),

                  filteredProducts.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(
                                'No products found matching search or category.',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.65,
                                ),
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final product = filteredProducts[index];
                              return ProductCard(product: product);
                            }, childCount: filteredProducts.length),
                          ),
                        ),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
