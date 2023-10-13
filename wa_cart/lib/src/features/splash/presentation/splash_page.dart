
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:wa_cart/src/features/products/presentation/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedSplashScreen(
        splash: const Image(
          image: AssetImage("lib/src/resources/ic-cart-icon.png"),
        ),
        backgroundColor: Colors.green,
        nextScreen: const HomePage(),
    );
  }

}

// Container(
// decoration: const BoxDecoration(
// gradient: LinearGradient(
// stops: [0.25, 0.5, 0.7, 0.85],
// begin: Alignment.bottomLeft,
// end: Alignment.topRight,
// colors: <Color>[
// Color(0xff240b2e),
// Color(0xff581b6e),
// Color(0xffa73076),
// Color(0xfff2457d)
// ]
// ),
// ),
// child: const Center(
// child: SizedBox(
// child: Image(
// image: AssetImage("lib/src/resources/ic-cart-icon.png"),
// ),
// ),
// ),
// )
