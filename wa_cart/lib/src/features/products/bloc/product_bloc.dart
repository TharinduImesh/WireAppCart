import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wa_cart/src/features/products/bloc/product_event.dart';
import 'package:wa_cart/src/features/products/bloc/product_state.dart';
import 'package:wa_cart/src/features/products/domain/product_model.dart';

import '../data/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository): super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      try {
        List<ProductModel> products = await _productRepository.fetchProducts();
        emit(ProductLoadedState(products));
      } catch(e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}