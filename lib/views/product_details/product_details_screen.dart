import 'package:ewire_machine_test/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/cart/cart_counter_bloc.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/price_tag.dart';
import '../../widgets/custom_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductModel?;

    final title = product?.title ?? ' Product Title';
    final price = product?.price ?? 0.00;
    final rating = product?.rating?.rate ?? 0.0;
    final reviews = product?.rating?.count ?? 0;
    final image = product?.image ?? 'assets/images/product_headphone.png';
    final description =
        product?.description ??
        'Product description details go here. This is a fallback mock state.';
    final category = product?.category ?? 'General';

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: category, showBackButton: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 320,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? theme.colorScheme.onSurface.withOpacity(0.04)
                          : const Color(0xFFF8FAFC),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(32),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Hero(
                            tag: 'product-img-$image',
                            child: image.startsWith('http')
                                ? Image.network(image, fit: BoxFit.contain)
                                : Image.asset(image, fit: BoxFit.contain),
                          ),
                        ),
                        // Floating Favorite Toggle
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.colorScheme.outline,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isDark
                                        ? Colors.transparent
                                        : Colors.black.withOpacity(0.06),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                color: isFavorite
                                    ? const Color(0xFFEF4444)
                                    : theme.colorScheme.onSurface.withOpacity(
                                        0.4,
                                      ),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF78350F).withOpacity(0.4)
                                    : const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: isDark
                                        ? const Color(0xFFFBBF24)
                                        : const Color(0xFFD97706),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    rating.toString(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? const Color(0xFFFBBF24)
                                          : const Color(0xFFD97706),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '($reviews customer reviews)',
                              style: TextStyle(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.6,
                                ),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                PriceTag(
                                  price: price,
                                  fontSize: 24,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: theme.colorScheme.outline,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          size: 16,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        onPressed: () {
                                          if (quantity > 1) {
                                            setState(() {
                                              quantity--;
                                            });
                                          }
                                        },
                                      ),
                                      Text(
                                        '$quantity',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          size: 16,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            quantity++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(height: 40, color: theme.colorScheme.outline),

                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(top: BorderSide(color: theme.colorScheme.outline)),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Add to Cart',
                      isOutline: true,
                      onPressed: () {
                        if (product != null) {
                          BlocProvider.of<CartCounterBloc>(context).add(
                            AddToCartEvent(
                              product: product,
                              quantity: quantity,
                            ),
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$quantity x $title added to cart!'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: 'Buy Now',
                      backgroundColor: theme.colorScheme.secondary,
                      onPressed: () {
                        if (product != null) {
                          BlocProvider.of<CartCounterBloc>(context).add(
                            AddToCartEvent(
                              product: product,
                              quantity: quantity,
                            ),
                          );
                        }
                        Navigator.pushNamed(context, '/cart');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
