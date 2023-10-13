
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_bloc.dart';
import 'package:wa_cart/src/features/products/domain/product_model.dart';

import '../../cart/bloc/cart_event.dart';
import '../../cart/domain/cart_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailPage({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
              "Product Details",
              style: TextStyle(
                  color: Colors.white
              ),
            )
        ),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 50,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                SizedBox(
                  width: MediaQuery. of(context). size.width,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    imageUrl: productModel.mainImage!,
                  ),
                ),
                Center(
                  child: Text(
                    '${productModel.name}',
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 2,
                  ),
                ),
                Text(
                  'SKU: ${productModel.sku}',
                  style: const TextStyle(fontSize: 18),
                ),
                Container(
                  height: 15,
                ),
                Text(
                  'Color: ${productModel.colour}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Sizes: ${productModel.sizes}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Stock status: ${productModel.stockStatus}',
                  style: const TextStyle(fontSize: 20),
                ),
                Container(
                  height: 15,
                ),
                const Text(
                  'Product description:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${productModel.description}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            )
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: Colors.red,
                child: TextButton(
                  child: const Text(
                    "Add to cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                  onPressed: (){
                    BlocProvider.of<CartBloc>(context).add(
                        AddProductEvent(CartModel.singleQuantity(
                            productModel
                        ))
                    );
                    Navigator.pop(context);
                  },
                ),
              )
          )
        ],
      ),
    );
  }
}