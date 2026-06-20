part of 'cart_counter_bloc.dart';

sealed class CartCounterEvent {}

class LoadCartEvent extends CartCounterEvent {}

class AddToCartEvent extends CartCounterEvent {
  final ProductModel product;
  final int quantity;
  AddToCartEvent({required this.product, this.quantity = 1});
}

class UpdateQuantityEvent extends CartCounterEvent {
  final int productId;
  final int quantity;
  UpdateQuantityEvent({required this.productId, required this.quantity});
}

class RemoveFromCartEvent extends CartCounterEvent {
  final int productId;
  RemoveFromCartEvent({required this.productId});
}
