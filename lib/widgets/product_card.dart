import 'package:ewire_machine_test/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/cart/cart_counter_bloc.dart';
import 'price_tag.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onAddToCart;

  const ProductCard({super.key, required this.product, this.onAddToCart});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final image = product.image ?? "";
    final title = product.title ?? "";
    final price = product.price ?? 0.0;
    final rating = product.rating?.rate ?? 0.0;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product-details', arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.colorScheme.outline, width: 1),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: 'product-img-$image',
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? theme.colorScheme.onSurface.withOpacity(0.04)
                              : const Color(0xFFF8FAFC),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(23),
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Image.network(image, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          shape: BoxShape.circle,
                          border: isDark
                              ? Border.all(color: theme.colorScheme.outline)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? Colors.transparent
                                  : Colors.black.withOpacity(0.06),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: isFavorite
                              ? const Color(0xFFEF4444)
                              : theme.colorScheme.onSurface.withOpacity(0.4),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFF59E0B),
                              size: 16,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PriceTag(price: price.toDouble(), fontSize: 16),
                        GestureDetector(
                          onTap:
                              widget.onAddToCart ??
                              () {
                                BlocProvider.of<CartCounterBloc>(context).add(
                                  AddToCartEvent(product: product, quantity: 1),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$title added to cart!'),
                                    duration: const Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              color: theme.colorScheme.onPrimary,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
