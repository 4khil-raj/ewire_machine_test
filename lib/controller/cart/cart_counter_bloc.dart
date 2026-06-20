import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ewire_machine_test/model/product_model.dart';

part 'cart_counter_event.dart';
part 'cart_counter_state.dart';

class CartCounterBloc extends Bloc<CartCounterEvent, CartCounterState> {
  static const String _cartKey = 'cart_items';

  CartCounterBloc() : super(CartCounterInitial()) {
    on<LoadCartEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonStr = prefs.getString(_cartKey);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        try {
          final List<dynamic> decoded = jsonDecode(jsonStr);
          final List<CartItem> items = decoded
              .map((itemJson) => CartItem.fromJson(itemJson))
              .toList();
          emit(CartCounterLoadedState(cartItems: items));
        } catch (e) {
          emit(CartCounterLoadedState(cartItems: []));
        }
      } else {
        emit(CartCounterLoadedState(cartItems: []));
      }
    });

    on<AddToCartEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      List<CartItem> currentItems = [];

      final currentState = state;
      if (currentState is CartCounterLoadedState) {
        currentItems = List.from(currentState.cartItems);
      } else {
        final String? jsonStr = prefs.getString(_cartKey);
        if (jsonStr != null && jsonStr.isNotEmpty) {
          try {
            final List<dynamic> decoded = jsonDecode(jsonStr);
            currentItems = decoded
                .map((itemJson) => CartItem.fromJson(itemJson))
                .toList();
          } catch (_) {
            print("errrrroor");
          }
        }
      }

      final existingIndex = currentItems.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      if (existingIndex >= 0) {
        currentItems[existingIndex].quantity += event.quantity;
      } else {
        currentItems.add(
          CartItem(product: event.product, quantity: event.quantity),
        );
      }

      await prefs.setString(
        _cartKey,
        jsonEncode(currentItems.map((item) => item.toJson()).toList()),
      );

      emit(CartCounterLoadedState(cartItems: currentItems));
    });

    on<UpdateQuantityEvent>((event, emit) async {
      if (state is CartCounterLoadedState) {
        final prefs = await SharedPreferences.getInstance();
        final currentItems = List<CartItem>.from(
          (state as CartCounterLoadedState).cartItems,
        );

        final targetIndex = currentItems.indexWhere(
          (item) => item.product.id == event.productId,
        );

        if (targetIndex >= 0) {
          currentItems[targetIndex].quantity = event.quantity;

          await prefs.setString(
            _cartKey,
            jsonEncode(currentItems.map((item) => item.toJson()).toList()),
          );
        }

        emit(CartCounterLoadedState(cartItems: currentItems));
      }
    });

    on<RemoveFromCartEvent>((event, emit) async {
      if (state is CartCounterLoadedState) {
        final prefs = await SharedPreferences.getInstance();
        final currentItems = List<CartItem>.from(
          (state as CartCounterLoadedState).cartItems,
        );

        currentItems.removeWhere((item) => item.product.id == event.productId);

        await prefs.setString(
          _cartKey,
          jsonEncode(currentItems.map((item) => item.toJson()).toList()),
        );

        emit(CartCounterLoadedState(cartItems: currentItems));
      }
    });
  }
}
