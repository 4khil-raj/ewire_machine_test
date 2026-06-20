import 'package:ewire_machine_test/model/product_model.dart';
import 'package:flutter/material.dart';
import 'price_tag.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;
  final VoidCallback? onRemove;
  final ValueChanged<int>? onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.cartItem,
    this.onRemove,
    this.onQuantityChanged,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    final cartItem = widget.cartItem;
    final product = cartItem.product;
    final quantity = cartItem.quantity;
    final image = product.image ?? "";
    final title = product.title ?? "";
    final price = product.price ?? 0.0;
    final category = product.category ?? 'General';

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outline, width: 1),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.transparent : Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: isDark
                    ? theme.colorScheme.onSurface.withOpacity(0.04)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8),
              child: image.startsWith('http')
                  ? Image.network(image, fit: BoxFit.contain)
                  : Image.asset(image, fit: BoxFit.contain),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: widget.onRemove,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF7F1D1D).withOpacity(0.4)
                                : const Color(0xFFFEF2F2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF991B1B).withOpacity(0.5)
                                  : const Color(0xFFFEE2E2),
                            ),
                          ),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: isDark
                                ? const Color(0xFFF87171)
                                : const Color(0xFFEF4444),
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriceTag(price: price * quantity, fontSize: 16),

                      Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? theme.colorScheme.onSurface.withOpacity(0.04)
                              : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: theme.colorScheme.outline),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) {
                                  widget.onQuantityChanged?.call(quantity - 1);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 14,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onQuantityChanged?.call(quantity + 1);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 14,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
