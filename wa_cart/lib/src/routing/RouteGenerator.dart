
import 'package:flutter/material.dart';
import 'package:wa_cart/src/features/splash/presentation/splash_page.dart';

class RouteGenerator {
// Routing map
  static Route<dynamic>  generateRoute(RouteSettings settings) {
    switch(settings.name) {
      default: return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }
}