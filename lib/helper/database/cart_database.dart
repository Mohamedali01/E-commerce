import 'package:e_commerce/constants.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  CartDatabase._();

  static final CartDatabase db = CartDatabase._();

  Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    else {
      _database = await initDB();
      return _database;
    }
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'CartProducts.db');
    return await openDatabase(path, version: 5, onCreate: (db, _) {
      db.execute(
          "CREATE TABLE cart ($columnName TEXT NOT NULL,$columnImage TEXT NOT NULL,$columnPrice TEXT NOT NULL,$columnQuantity INTEGER NOT NULL,$columnId TEXT NOT NULL)");
    });
  }

  Future<void> insert(CartModel cartModel) async {
    var dbCon = await database;
    await dbCon.insert(cartTable, cartModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartModel>> getAllCartProducts() async {
    var dbCon = await database;
    List list = await dbCon.query(cartTable);
    return list.map((e) => CartModel.fromJson(e)).toList();
  }

  Future<void> clear() async {
    var dbCon = await database;
    await dbCon.delete(cartTable);
  }

  Future<void> deleteCartItem(String id)async{
    var dbCon = await database;
    await dbCon.delete(cartTable,where: '$columnId = ?',whereArgs: [id]);
  }
  Future<void> update(CartModel cartModel) async {
    var dbCon = await database;
    await dbCon.update(cartTable, cartModel.toJson(),
        where: '$columnId = ?', whereArgs: [cartModel.cartId]);
  }
}
