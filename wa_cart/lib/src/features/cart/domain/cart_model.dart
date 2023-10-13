
import 'package:wa_cart/src/features/products/domain/product_model.dart';

class CartModel {
  late final String? id;
  late final String? sku;
  late final String? name;
  late final String? mainImage;
  late final String? amount;
  late final String? currency;
  late final String? colour;
  int _quantity = 1;

  CartModel(
      this.id,
      this.sku,
      this.name,
      this.mainImage,
      this.amount,
      this.currency,
      this.colour,
      this._quantity);
  CartModel.singleQuantity(ProductModel productModel) {
    id = productModel.id;
    sku = productModel.sku;
    name = productModel.name;
    mainImage = productModel.mainImage;
    amount = productModel.price?.amount;
    currency= productModel.price?.currency;
    colour = productModel.colour;
  }

  int get quantity => _quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sku': sku,
      'name': name,
      'mainImage': mainImage,
      'amount': amount,
      'currency': currency,
      'colour': colour,
      'quantity': quantity,
    };
  }
}