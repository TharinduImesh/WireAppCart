
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_bloc.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_event.dart';
import 'package:wa_cart/src/features/cart/domain/cart_model.dart';
import 'package:wa_cart/src/features/products/bloc/product_bloc.dart';
import 'package:wa_cart/src/features/products/bloc/product_event.dart';
import 'package:wa_cart/src/features/products/bloc/product_state.dart';
import 'package:wa_cart/src/features/products/data/product_repository.dart';
import 'package:wa_cart/src/features/products/domain/product_model.dart';
import 'package:wa_cart/src/features/products/presentation/product_detail_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() {
    // TODO: implement createState
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  late final CartBloc _cartBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: BlocProvider<ProductBloc>(
        create: (BuildContext context) => ProductBloc(
            (ProductRepository())
        )..add(LoadProductEvent()),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Center(
                    child: Text(
                      "Product List",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                ),
                backgroundColor: Colors.teal,
              ),
              body: _showContent(context, state),
            );
          },
        ),
      ),
      onWillPop: () async {
        exit(0);
      }
    );
  }

  Widget _showContent(BuildContext context, ProductState state) {
    if (state is ProductLoadingState) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is ProductLoadedState) {
      List<ProductModel> productList = state.products;
      return _showProductList(context, productList);
    } else {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text("Error"),
        ),
      );
    }
  }

  Widget _showProductList(BuildContext context, List<ProductModel> productList) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: _productCardView(context, productList[index]),
            );
          }),
    );
  }

  Widget _productCardView(BuildContext context, ProductModel productModel) {
    return Card(
        color: Colors.white,
        elevation: 5,
        child: InkWell(
          child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)
                      ),
                      child: Container(
                        width: 130,
                        height: 150,
                        color: Colors.white,
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
                    ),
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${productModel.name}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                          ),
                          Text(
                            'SKU: ${productModel.sku}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Colour: ${productModel.colour}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${productModel.price!.currency} ${productModel.price!.amount}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: (){
                                  _cartBloc.add(
                                      AddProductEvent(
                                          CartModel.singleQuantity(
                                              productModel
                                          )
                                      )
                                  );
                                },
                                child: const Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  )
                ],
              )
          ),
          onTap: () {
            _redirectToProductDetailPage(context, productModel);
          },
        )
    );
  }

  void _redirectToProductDetailPage(BuildContext context, ProductModel model) {
    Future.delayed(Duration.zero, () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlocProvider.value(
            value: _cartBloc,
            child: ProductDetailPage(productModel: model),
          ))
      );
    });
  }
}