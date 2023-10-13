
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_event.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_state.dart';
import 'package:wa_cart/src/features/cart/domain/cart_model.dart';

import '../data/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc(this._cartRepository): super(CartLoadingState()) {
    on<LoadCartEvent>((event, emit) async {
      await emitLoadedState(emit);
    });

    on<AddProductEvent>((event, emit) async {
      bool isInserted = await _cartRepository.saveCartItem(event.cartModel);
      if (isInserted) {
        await emitLoadedState(emit);
      }
    });

    on<RemoveProductEvent>((event, emit) async {
      bool isRemoved = await _cartRepository.removeCartItem(event.cartModel.id!);
      if (isRemoved) {
        await emitLoadedState(emit);
      }
    });

    on<IncrementQuantityEvent>((event, emit) async {
      CartModel updatedModel = CartModel(
          event.cartModel.id,
          event.cartModel.sku,
          event.cartModel.name,
          event.cartModel.mainImage,
          event.cartModel.amount,
          event.cartModel.currency,
          event.cartModel.colour,
          event.cartModel.quantity + 1
      );
      bool isUpdated = await _cartRepository.updateCartItem(updatedModel);
      if (isUpdated) {
        await emitLoadedState(emit);
      }
    });

    on<DecrementQuantityEvent>((event, emit) async {
      CartModel updatedModel = CartModel(
          event.cartModel.id,
          event.cartModel.sku,
          event.cartModel.name,
          event.cartModel.mainImage,
          event.cartModel.amount,
          event.cartModel.currency,
          event.cartModel.colour,
          event.cartModel.quantity > 1 ? event.cartModel.quantity - 1 : 1
      );
      bool isUpdated = await _cartRepository.updateCartItem(updatedModel);
      if (isUpdated) {
        await emitLoadedState(emit);
      }
    });
  }

  Future<bool> emitLoadedState(Emitter<CartState> emit) async {
    List<CartModel> itemList = [];
    itemList.addAll(await _cartRepository.getCartItems());
    emit(CartLoadedState(itemList));
    return true;
  }
}