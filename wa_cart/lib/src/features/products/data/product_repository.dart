
import 'dart:convert';
import 'package:http/http.dart';
import 'package:wa_cart/src/features/products/domain/product_model.dart';

class ProductRepository {
  String userUrl = 'https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json';

  Future<List<ProductModel>> fetchProducts() async {
    Response response = await get(Uri.parse(userUrl));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}