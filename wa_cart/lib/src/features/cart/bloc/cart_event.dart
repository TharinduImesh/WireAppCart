import 'package:flutter/material.dart';
import '../domain/cart_model.dart';

@immutable
abstract class CartEvent {
  const CartEvent();
}

class LoadCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class ActionCartEvent extends CartEvent {
  final CartModel cartModel;
  const ActionCartEvent(this.cartModel);
  @override
  List<Object?> get props => [cartModel];
}

class AddProductEvent extends ActionCartEvent {
  const AddProductEvent(super.cartModel);
}

class RemoveProductEvent extends ActionCartEvent {
  const RemoveProductEvent(super.cartModel);
}

class IncrementQuantityEvent extends ActionCartEvent{
  const IncrementQuantityEvent(super.cartModel);
}

class DecrementQuantityEvent extends ActionCartEvent{
  const DecrementQuantityEvent(super.cartModel);
}