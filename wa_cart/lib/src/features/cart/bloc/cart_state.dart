import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:wa_cart/src/features/cart/domain/cart_model.dart';

@immutable
abstract class CartState extends Equatable{}

class CartLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoadedState extends CartState {
  final List<CartModel> cartItems;
  CartLoadedState(this.cartItems);
  @override
  List<Object?> get props => [cartItems];
}