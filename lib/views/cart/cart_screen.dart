import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/cart/cart_counter_bloc.dart';
import '../../model/product_model.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/cart_item_card.dart';
import '../../widgets/price_tag.dart';
import '../../widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Shopping Cart',
        showBackButton: true,
        showCartIcon: false,
      ),
      body: BlocBuilder<CartCounterBloc, CartCounterState>(
        builder: (context, state) {
          if (state is CartCounterInitial) {
            BlocProvider.of<CartCounterBloc>(context).add(LoadCartEvent());
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = state is CartCounterLoadedState
              ? state.cartItems
              : <CartItem>[];
          final subtotal = state is CartCounterLoadedState
              ? state.subtotal
              : 0.0;
          final deliveryFee = state is CartCounterLoadedState
              ? state.deliveryFee
              : 0.0;
          final total = state is CartCounterLoadedState
              ? state.totalAmount
              : 0.0;

          final theme = Theme.of(context);
          final isDark = theme.brightness == Brightness.dark;

          if (cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: theme.colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Looks like you haven\'t added anything yet.',
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    child: CustomButton(
                      text: 'Explore Shop',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return CartItemCard(
                      key: ValueKey(item.product.id),
                      cartItem: item,
                      onQuantityChanged: (newQty) {
                        if (item.product.id != null) {
                          BlocProvider.of<CartCounterBloc>(context).add(
                            UpdateQuantityEvent(
                              productId: item.product.id!,
                              quantity: newQty,
                            ),
                          );
                        }
                      },
                      onRemove: () {
                        if (item.product.id != null) {
                          BlocProvider.of<CartCounterBloc>(context).add(
                            RemoveFromCartEvent(productId: item.product.id!),
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${item.product.title} removed from cart',
                            ),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border(
                    top: BorderSide(color: theme.colorScheme.outline),
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          PriceTag(
                            price: subtotal,
                            fontSize: 16,
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Fee',
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          deliveryFee == 0.0
                              ? const Text(
                                  'FREE',
                                  style: TextStyle(
                                    color: Color(0xFF10B981),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : PriceTag(
                                  price: deliveryFee,
                                  fontSize: 16,
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(color: theme.colorScheme.outline),
                      ),

                      // Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          PriceTag(
                            price: total,
                            fontSize: 20,
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Checkout Button
                      CustomButton(
                        text: 'Proceed to Checkout',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Proccessing'),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
