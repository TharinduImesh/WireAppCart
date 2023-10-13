
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_bloc.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_event.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_state.dart';
import 'package:wa_cart/src/features/cart/domain/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  late final CartBloc _cartBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (context, state) {
          if (state is CartLoadingState) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CartLoadedState) {
            // List<CartModel> cartItems = state.cartItems;
            // return Scaffold(
            //     appBar: AppBar(
            //       title: const Center(
            //           child: Text(
            //             "Cart",
            //             style: TextStyle(
            //                 color: Colors.white
            //             ),
            //           )
            //       ),
            //       backgroundColor: Colors.teal,
            //     ),
            //     body: Stack(
            //       children: <Widget>[
            //         Positioned(
            //             left: 0,
            //             top: 0,
            //             right: 0,
            //             bottom: 50,
            //             child: ListView.builder(
            //                 itemCount: cartItems.length,
            //                 itemBuilder: (_, index) {
            //                   return Padding(
            //                     padding:
            //                     const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            //                     child: Card(
            //                       color: Colors.white,
            //                       elevation: 5,
            //                       child: Padding(
            //                           padding: const EdgeInsets.only(right: 5),
            //                           child: Row(
            //                             children: <Widget>[
            //                               Padding(
            //                                 padding: const EdgeInsets.only(right: 10),
            //                                 child: ClipRRect(
            //                                   borderRadius: const BorderRadius.only(
            //                                       topLeft: Radius.circular(15),
            //                                       bottomLeft: Radius.circular(15)
            //                                   ),
            //                                   child: Container(
            //                                     width: 130,
            //                                     height: 200,
            //                                     color: Colors.white,
            //                                     child: CachedNetworkImage(
            //                                       placeholder: (context, url) => const Center(
            //                                         child: SizedBox(
            //                                           width: 50,
            //                                           height: 50,
            //                                           child: CircularProgressIndicator(),
            //                                         ),
            //                                       ),
            //                                       imageUrl: cartItems[index].mainImage!,
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                               Expanded(
            //                                   child: Column(
            //                                     mainAxisAlignment: MainAxisAlignment.start,
            //                                     crossAxisAlignment: CrossAxisAlignment.start,
            //                                     children: <Widget>[
            //                                       Text(
            //                                         '${cartItems[index].name}',
            //                                         style: const TextStyle(
            //                                             fontSize: 18,
            //                                             fontWeight: FontWeight.w500
            //                                         ),
            //                                         overflow: TextOverflow.ellipsis,
            //                                         softWrap: false,
            //                                         maxLines: 2,
            //                                       ),
            //                                       Text(
            //                                         'SKU: ${cartItems[index].sku}',
            //                                         style: const TextStyle(fontSize: 15),
            //                                       ),
            //                                       Text(
            //                                         'Colour: ${cartItems[index].colour}',
            //                                         style: const TextStyle(fontSize: 15),
            //                                       ),
            //                                       Text(
            //                                         '${cartItems[index].currency} ${cartItems[index].amount}',
            //                                         style: const TextStyle(fontSize: 16),
            //                                       ),
            //                                       Row(
            //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                                         children: <Widget>[
            //                                           Row(
            //                                             children: <Widget>[
            //                                               TextButton(
            //                                                 onPressed: () {
            //                                                   _cartBloc.add(DecrementQuantityEvent(cartItems[index]));
            //                                                 },
            //                                                 child: const Icon(
            //                                                   Icons.remove,
            //                                                   color: Colors.black,
            //                                                   size: 30,
            //                                                 ),
            //                                               ),
            //                                               Text(
            //                                                 "${cartItems[index].quantity}",
            //                                                 style: const TextStyle(
            //                                                   fontSize: 20
            //                                                 ),
            //                                               ),
            //                                               TextButton(
            //                                                 onPressed: () {
            //                                                   _cartBloc.add(IncrementQuantityEvent(cartItems[index]));
            //                                                 },
            //                                                 child: const Icon(
            //                                                   Icons.add,
            //                                                   color: Colors.black,
            //                                                   size: 30,
            //                                                 ),
            //                                               )
            //                                             ],
            //                                           ),
            //                                           TextButton(
            //                                             onPressed: () {
            //                                               _cartBloc.add(RemoveProductEvent(cartItems[index]));
            //                                             },
            //                                             child: const Icon(
            //                                               Icons.delete,
            //                                               color: Colors.red,
            //                                               size: 30,
            //                                             ),
            //                                           )
            //                                         ],
            //                                     )
            //                                   ],
            //                                 )
            //                               )
            //                             ],
            //                           )
            //                       ),
            //                     ),
            //                   );
            //                 }
            //             )
            //         ),
            //         Positioned(
            //             left: 0,
            //             right: 0,
            //             bottom: 0,
            //             child: Container(
            //               height: 50,
            //               color: Colors.red,
            //               child: Center(
            //                 child: Text(
            //                     "Total: ${cartItems.isNotEmpty ? cartItems[0].currency! : ""} ${calculateTotal(cartItems)}",
            //                   style: const TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 23,
            //                     fontWeight: FontWeight.w300
            //                   ),
            //                 ),
            //               ),
            //             )
            //         )
            //       ],
            //     ),
            // );
            return _showCartContent(context, state.cartItems);
          } else {
            return const SizedBox();
          }
        },
      );
  }

  Widget _showCartContent(BuildContext context, List<CartModel> cartItems) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
              "Cart",
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
              left: 0,
              top: 0,
              right: 0,
              bottom: 50,
              child: _cartItemList(context, cartItems)
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 50,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Total: ${cartItems.isNotEmpty ? cartItems[0].currency! : ""} ${calculateTotal(cartItems)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _cartItemList(BuildContext context, List<CartModel> cartItems) {
    return ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (_, index) {
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: _cartItem(context, cartItems[index]),
          );
        }
    );
  }

  Widget _cartItem(BuildContext context, CartModel cartItem) {
    return Card(
      color: Colors.white,
      elevation: 5,
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
                    height: 190,
                    color: Colors.white,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      imageUrl: cartItem.mainImage!,
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
                        '${cartItem.name}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 2,
                      ),
                      Text(
                        'SKU: ${cartItem.sku}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Colour: ${cartItem.colour}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        '${cartItem.currency} ${cartItem.amount}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  _cartBloc.add(DecrementQuantityEvent(cartItem));
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "${cartItem.quantity}",
                                style: const TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _cartBloc.add(IncrementQuantityEvent(cartItem));
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              _cartBloc.add(RemoveProductEvent(cartItem));
                            },
                            child: const Icon(
                              Icons.delete,
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
    );
  }

  double calculateTotal(List<CartModel> cartItems) {
    double sum = 0;
    for( final item in cartItems) {
      sum += item.quantity * double.parse(item.amount!);
    }
    return sum;
  }
}