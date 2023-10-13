
import 'package:wa_cart/src/features/cart/domain/cart_model.dart';
import 'package:wa_cart/src/utils/database_manager.dart';

class CartRepository {
  final DatabaseManager _dbManager;
  CartRepository(this._dbManager);

  Future<List<CartModel>> getCartItems() async {
    return await _dbManager.cartItems();
  }

  Future<bool> saveCartItem(CartModel cartModel) async {
    return await _dbManager.insertCartItem(cartModel);
  }

  Future<bool> updateCartItem(CartModel cartModel) async {
    return await _dbManager.updateCartItem(cartModel);
  }

  Future<bool> removeCartItem(String itemId) async {
    return await _dbManager.deleteCartItem(itemId);
  }
}