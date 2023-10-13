
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wa_cart/src/features/cart/bloc/cart_event.dart';
import 'package:wa_cart/src/features/cart/data/cart_repository.dart';
import 'package:wa_cart/src/features/cart/presentation/cart_page.dart';
import 'package:wa_cart/src/features/products/presentation/products_page.dart';
import 'package:wa_cart/src/utils/database_manager.dart';

import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_state.dart';
import '../../cart/domain/cart_model.dart';
import '../domain/product_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(
              (CartRepository(DatabaseManager.dbManger))
          )..add(LoadCartEvent()),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Scaffold(
                body: IndexedStack(
                  index: _selectedIndex,
                  children: const <Widget>[
                    ProductsPage(),
                    CartPage()
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.teal,
                  items: <BottomNavigationBarItem>[
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.list_alt),
                      label: 'Products',
                    ),
                    BottomNavigationBarItem(
                      icon: _showCartBadge(context),
                      label: 'Cart',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.white,
                  onTap: (int index){
                    _onItemTapped(context, index);
                  },
                ),
              );
            },
          ),
        ),
        onWillPop: () async {
          exit(0);
        }
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _showCartBadge(BuildContext context) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return StreamBuilder<CartState>(
      stream: cartBloc.stream,
      initialData: cartBloc.state,
      builder: (BuildContext context, AsyncSnapshot<CartState> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is CartLoadedState) {
            List<CartModel> cartItems = (snapshot.data as CartLoadedState).cartItems;
            return Badge(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              label: Text('${cartItems.length}'),
              child: const Icon(Icons.shopping_cart),
            );
          }
        }
        return const Icon(Icons.shopping_cart);
      },
    );
  }
}