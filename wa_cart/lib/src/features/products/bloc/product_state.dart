import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../domain/product_model.dart';

@immutable
abstract class ProductState extends Equatable{}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<ProductModel> products;
  ProductLoadedState(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);
  @override
  List<Object?> get props => [error];
}