
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wa_cart/src/features/cart/domain/cart_model.dart';

class DatabaseManager {
  DatabaseManager._();
  static final DatabaseManager dbManger = DatabaseManager._();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cart_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cart(id TEXT PRIMARY KEY, sku TEXT, name TEXT, mainImage TEXT, amount TEXT, currency TEXT, colour TEXT, quantity INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<bool> insertCartItem(CartModel cartItem) async {
    final db = await database;
    int lastId = await db.insert(
      'cart',
      cartItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return lastId > 0;
  }

  Future<List<CartModel>> cartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) {
      return CartModel(
        maps[i]['id'],
        maps[i]['sku'],
        maps[i]['name'],
        maps[i]['mainImage'],
        maps[i]['amount'],
        maps[i]['currency'],
        maps[i]['colour'],
        maps[i]['quantity']
      );
    });
  }

  Future<bool> updateCartItem(CartModel cartItem) async {
    final db = await database;
    int updatedId = await db.update(
      'cart',
      cartItem.toMap(),
      where: 'id = ?',
      whereArgs: [cartItem.id],
    );
    return updatedId > 0;
  }

  Future<bool> deleteCartItem(String id) async {
    final db = await database;
    int deletedId = await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
    return deletedId > 0;
  }
}