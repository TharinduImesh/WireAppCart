
import 'package:flutter/material.dart';

@immutable
abstract class ProductEvent {
  const ProductEvent();
}

class LoadProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}
