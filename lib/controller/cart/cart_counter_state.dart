part of 'cart_counter_bloc.dart';

sealed class CartCounterState {}

final class CartCounterInitial extends CartCounterState {}

final class CartCounterLoadedState extends CartCounterState {
  final List<CartItem> cartItems;

  CartCounterLoadedState({required this.cartItems});

  int get totalCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item.product.price ?? 0.0) * item.quantity));
  double get deliveryFee => (cartItems.isEmpty || subtotal > 300.0) ? 0.0 : 15.0;
  double get totalAmount => subtotal + deliveryFee;
}
